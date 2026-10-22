x1= [1,2,3,4];
x2 = [2,3];

[r,index] = xcorr(x1,x2);
stem(index, r);
xlabel("lag");
ylabel("Correlation");
title("Cross-correlation");
