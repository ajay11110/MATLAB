A = 5;
f = 5;
t = 0:0.001:1;

y = A*square(2*pi*f*t);

plot(t,y)

xlim([0,1]);
ylim([-5.2,5.2]);
xlabel("Time");
ylabel("Amplitude");
title("square wave");