a=1;
f=5;
t=0:.000001:1;
y=a*sin(2*pi*f*t);

plot(t,y);
title('Sinusoidal Wave');
xlabel('Time');
ylabel('Amplitude');
grid off;

