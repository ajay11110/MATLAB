x=[1 2 3];
y=[ 1 2];

output = conv(x,y);
n=0:(length(output)-1);
figure;

stem(n, output);
title("Convolution of Two Sequences");
xlabel("Sample(n)");
ylabel("Amplitude");
grid off;