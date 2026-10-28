a = 2; 
t = -1:0.01:10; 
F = zeros(size(t)); 

for i = 1:length(t) 
    F(i) = real((1/(2*pi))*(integral(@(w) (1./(a+1i*w)).*exp(1i*w*t(i)), -500, 500))); 
end 

figure; 
plot(t, F); 
title("Inverse Fourier Transform"); 
xlabel("Time (seconds)"); 
ylabel("Amplitude"); 
