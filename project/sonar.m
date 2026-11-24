clear; clc; close all;

%% Settings
Fs = 48000; soundSpeed = 343;
recordSeconds = 1.5; chirpSeconds = 0.08;
startFreq = 1500; endFreq = 6000;
minDistance = 0.40; maxDistance = 3.00;

%% Generate chirp, record, and play
t = (0:round(chirpSeconds*Fs)-1)' / Fs;
tx = sin(2*pi*(startFreq*t + 0.5*((endFreq - startFreq)/chirpSeconds)*t.^2));

rec = audiorecorder(Fs, 16, 1);
player = audioplayer(tx, Fs);

record(rec);
pause(0.15);
playblocking(player);
pause(max(0, recordSeconds - chirpSeconds - 0.15));
stop(rec);

rx = getaudiodata(rec, 'double');
assert(~isempty(rx) && max(abs(rx)) >= 1e-5, 'No usable microphone signal was recorded. Check microphone permissions and input settings.');

%% Cross-correlate and find direct + echo peaks
[corr, lags] = xcorr(rx, tx);
absCorr = abs(corr);

earlyIdx = find(lags >= round(0.08*Fs) & lags <= round(0.45*Fs));
assert(~isempty(earlyIdx), 'Could not find a valid direct-sound search region.');
[directPeak, i] = max(absCorr(earlyIdx));
directLag = lags(earlyIdx(i));

echoIdx = find(lags >= directLag + round((2*minDistance/soundSpeed)*Fs) & lags <= directLag + round((2*maxDistance/soundSpeed)*Fs));
assert(~isempty(echoIdx), 'Recording is too short for the selected maximum distance.');
[echoPeak, i] = max(absCorr(echoIdx));
echoLag = lags(echoIdx(i));

%% Calculate and print distance
echoDelay = (echoLag - directLag) / Fs;
fprintf('\n--- Sonar estimate ---\nDirect-sound lag: %.2f ms\nLater-peak lag: %.2f ms\nDelay after direct: %.2f ms\nEstimated distance: %.2f m\n', ...
    1000*directLag/Fs, 1000*echoLag/Fs, 1000*echoDelay, soundSpeed*echoDelay/2);

%% Plots
figure;
plot((0:numel(rx)-1)/Fs, rx); grid on;
xlabel('Time (seconds)'); ylabel('Microphone amplitude'); title('Microphone recording');

figure;
plot(lags/Fs, absCorr, directLag/Fs, directPeak, 'o', echoLag/Fs, echoPeak, 'o'); grid on;
xlabel('Lag (seconds)'); ylabel('Absolute correlation');
title('Chirp correlation: direct sound and later candidate peak');
legend('Correlation', 'Direct sound', 'Later candidate');