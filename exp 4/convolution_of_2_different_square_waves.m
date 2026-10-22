dt = 0.001;
t1 = -3:dt:3;
t2 = -2:dt:2;

x1 = double(t1 >= -2 & t1 <= 2); 
x2 = double(t2 >= -1 & t2 <= 1); 

y = conv(x1, x2)*dt; 

t_y = (t1(1) + t2(1)):dt:(t1(end) + t2(end));

figure;
subplot(3,1,1);
plot(t1, x1);
title('First Square Wave x_1(t)');
xlabel("Time");
ylabel("Amplitude");
grid off;

subplot(3,1,2);
plot(t2, x2);
title('Second Square Wave x_2(t)');
xlabel("Time");
ylabel("Amplitude");
grid off;

subplot(3,1,3);
plot(t_y, y);
title('Convolution Output y(t)');
xlabel("Time");
ylabel("Amplitude");
grid off;