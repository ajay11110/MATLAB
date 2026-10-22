t=-2:0.0001:2;
p = t.*t;
plot(t,p);

xlim([-6,6]);
ylim([-2,6])
xlabel("Time (s)");
ylabel("Amplitude");
title("Exponential function");
grid off;
