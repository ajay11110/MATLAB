a=2;
s=0:0.01:10;

F=zeros(size(s));

for i=1:length(s)
    F(i)=integral(@(t) exp(-a*t).*exp(-s(i)*t),0,inf);
end

plot(s,F);
title("Laplace Transformation");
xlabel("Frequency");
ylabel("F(t)");