t=-5:0.0001:2;
e = exp(t);
plot(t,e);

xlim([-6,4]);
xlabel("Time (s)");
ylabel("Amplitude");
title("Exponential function");
grid off;
