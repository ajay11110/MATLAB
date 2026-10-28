a=2;
w=-10:0.01:10;
b=5;

F = zeros(size(w));
F2 = zeros(size(w));

for i=1:length(w)
    F(i) = integral(@(t) exp(-a*t).*exp(-1i*w(i)*t), 0, inf);
    F2(i) = integral(@(t) exp(-a*b*t).*exp(-1i*w(i)*t), 0, inf);
end
magnitude = abs(F);
phase = angle(F);
magnitude2 = abs(F2);
phase2 = angle(F2);

subplot(2,2,1);
plot(w, magnitude);
title("Magnitude Spectrum");
xlabel("Frequency");
ylabel("Magnitude");

subplot(2,2,2);
plot(w, phase);
title("Phase Spectrum");
xlabel("Frequency");
ylabel("Phase");

subplot(2,2,3);
plot(w, magnitude2);
title("Scalled Magnitude Spectrum");
xlabel("Frequency");
ylabel("Scalled Magnitude");

subplot(2,2,4);
plot(w, phase2);
title("Scalled Phase Spectrum");
xlabel("Frequency");
ylabel("Scalled Phase");