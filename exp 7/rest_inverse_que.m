t = -5:0.01:5;
F = zeros(size(t));

for i = 1:length(t)
    F(i) = real((1/(2*pi)) * (integral(@(w) (exp(-1i*2*w) - exp(1i*2*w)) .* exp(1i*w*t(i)), -500, 500)));
end

figure;
plot(t, F);
title("Inverse Fourier Transform");
xlabel("Time(s)");
ylabel("Amplitude");