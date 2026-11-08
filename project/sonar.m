clear; clc; close all;

%% Settings
Fs = 48000;                 % Sample rate (Hz)
soundSpeed = 343;           % Approximate speed of sound (m/s)
recordSeconds = 1.5;         % Total recording time
chirpSeconds = 0.08;         % Chirp duration
startFreq = 1500;            % Start frequency (Hz)
endFreq = 6000;              % End frequency (Hz)

minDistance = 0.40;          % Ignore echoes closer than this (m)
maxDistance = 3.00;          % Search up to this distance (m)

%% Create a short rising-frequency chirp
N = round(chirpSeconds * Fs);
t = (0:N-1)' / Fs;

sweepRate = (endFreq - startFreq) / chirpSeconds;
tx = sin(2*pi*(startFreq*t + 0.5*sweepRate*t.^2));

%% Prepare microphone recording and speaker playback
recorder = audiorecorder(Fs, 16, 1);
player = audioplayer(tx, Fs);

% Recording and playing the chirp
record(recorder);
pause(0.15);
playblocking(player);
pause(max(0, recordSeconds - chirpSeconds - 0.15));
stop(recorder);

rx = getaudiodata(recorder, 'double');
rx = rx(:);

if isempty(rx) || max(abs(rx)) < 0.00001
    error('No usable microphone signal was recorded. Check microphone permissions and input settings.');
end

%% Cross-correlate recording with the transmitted chirp
[correlation, lags] = xcorr(rx, tx);

% Find the direct sound near the expected playback start.
directWindowStart = round(0.08 * Fs);
directWindowEnd = round(0.45 * Fs);
earlyIndices = find(lags >= directWindowStart & lags <= directWindowEnd);

if isempty(earlyIndices)
    error('Could not find a valid direct-sound search region.');
end

[directPeak, directLocalIndex] = max(abs(correlation(earlyIndices)));
directIndex = earlyIndices(directLocalIndex);
directLag = lags(directIndex);

% Search for a later matching signal within the selected distance range.
minDelaySamples = round((2 * minDistance / soundSpeed) * Fs);
maxDelaySamples = round((2 * maxDistance / soundSpeed) * Fs);

echoIndices = find((lags >= directLag + minDelaySamples) & (lags <= directLag + maxDelaySamples));

if isempty(echoIndices)
    error('Recording is too short for the selected maximum distance.');
end

[echoPeak, echoLocalIndex] = max(abs(correlation(echoIndices)));
echoIndex = echoIndices(echoLocalIndex);
echoLag = lags(echoIndex);

%% Calculate distance relative to the direct-sound timing reference
delaySamples = echoLag - directLag;
echoDelay = delaySamples / Fs;
estimatedDistance = soundSpeed * echoDelay / 2;

fprintf('\n--- Sonar estimate ---\n');
fprintf('Direct-sound lag: %.2f ms\n', 1000*directLag/Fs);
fprintf('Later-peak lag: %.2f ms\n', 1000*echoLag/Fs);
fprintf('Delay after direct: %.2f ms\n', 1000*echoDelay);
fprintf('Estimated distance: %.2f m\n', estimatedDistance);

%% Plot the recording and correlation
timeRx = (0:numel(rx)-1)' / Fs;

figure;
plot(timeRx, rx);
xlabel('Time (seconds)');
ylabel('Microphone amplitude');
title('Microphone recording');
grid on;

figure;
plot(lags/Fs, abs(correlation));
hold on;
plot(directLag/Fs, abs(correlation(directIndex)), 'o');
plot(echoLag/Fs, abs(correlation(echoIndex)), 'o');
xlabel('Lag (seconds)');
ylabel('Absolute correlation');
title('Chirp correlation: direct sound and later candidate peak');
legend('Correlation', 'Direct sound', 'Later candidate');
grid on;