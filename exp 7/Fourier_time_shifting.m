a=2;
w=-10:0.01:10;

F = zeros(size(w));

for i=1:length(w)
    F(i) = exp(-1i*w(i)*2)+ exp(1i*w(i)*2);
end
magnitude = abs(F);
phase = angle(F);

subplot(2,1,1);
plot(w, magnitude);
title("Magnitude Spectrum");
xlabel("Frequency");
ylabel("Magnitude");

subplot(2,1,2);
plot(w, phase);
title("Phase Spectrum");
xlabel("Frequency");
ylabel("Phase");