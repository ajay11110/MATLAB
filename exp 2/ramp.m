t=-2:0.01:5;
rampfn = t.*(t>=0);
plot(t,rampfn);
grid on;
xlim([-3,6]);
ylim([-3,7]);
xlabel("Time (s)");
ylabel("Amplitude");
title("Ramp function");