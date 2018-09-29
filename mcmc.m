clear; clc; close all;
p = @(x) 0.3*exp(-0.2*x.^2)+0.7*exp(-0.2*(x-15).^2);
q = @(x,sgm) normpdf(x,0,sgm);

%MCMC
n_iters = 10000;
x = zeros(n_iters,1);
%initial point
x(1) = rand(1);
sgm_q = 20;
for k = 2:n_iters
    %sample from uniform distribution to be p
    u = rand(1);
    %propose new x
    xs = x(k-1)+sgm_q*randn(1);
    %acceptance, the bias ration cancels out, since q is symmetric
    A = min(1,p(xs)/p(x(k-1)));
    %accept or stay in previous position
    if u < A
        x(k) = xs;
    else
        x(k) = x(k-1);
    end
end

[h,b] = hist(x,200);
h = h'/sum(h);
plot(b,h,'.-');
hold on;
y = (-10:0.1:30)';
pp = p(y); pp = pp/sum(pp);
plot(y,pp,'r.-');
grid;
hold off;
legend('true','mcmc');
str = sprintf('%s',['iters=',num2str(n_iters),' sigma-q=',num2str(sgm_q)]);
title(str);