t=-5:0.01:5;
unitstep =t>=0;
plot(t,unitstep);
xlabel("Time(s)");
ylabel("Amplitude");
title("Unit step function")
ylim([-0.2,1.2]);
grid  off;