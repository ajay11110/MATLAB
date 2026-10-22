A = 1;                    
f = 5;                     
t = 0:0.001:1; 
y = A*sawtooth(2*pi*f*t, 0.5);

plot(t,y);
xlabel("Time (s)");
ylabel("Amplitude");
title("Triangular wave");
grid off;