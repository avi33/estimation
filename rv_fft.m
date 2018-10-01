%real value fft. exploiting conjugate symmetry to save oprations
%n - shall be even
n_samples = 1000; 
x = randn(n_samples, 1);
n = size(x,1);
if mod(n,2)~=0    
    x = [x;0];
    n = n + 1;
end
n_half = n/2;
%create complex signal, half size, interleaved samples
y = x(1:2:n)+1i*x(2:2:n);
Y = fft(y);
%compute 2 ffts on complex signals with n/2 samples 
A = 0.5*(Y+conj([Y(1); Y(n_half:-1:2)]) );        % even part
B = -0.5*1i*(Y-conj([Y(1); Y(n_half:-1:2)]) );     % odd part
%
X = [A; A(1)] + exp(-1i*2*pi/n*(0:n_half)').*[B; B(1)];  % combine
X2 = fft(x);
max(abs(X-X2(1:n_half+1)))  % 2.4492e-15