t=-5:0.0001:5;
deltafn = t==0;

plot(t,deltafn);
xlim([-6,6]);
ylim([-3,3]);
xlabel("Time (s)");
ylabel("Amplitude");
title("Unit Impulse function");
grid off;
