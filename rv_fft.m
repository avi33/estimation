x = 1:100;   % some real-valued signal
n = length(x);                  % must be even!
n2 = n/2;                       % assume n is even
z = x(1:2:n)+1i*x(2:2:n);        % complex signal of length n/2
Z = fft(z);
Ze = .5*( Z + conj([Z(1),Z(n2:-1:2)]) );        % even part
Zo = -.5*1i*( Z - conj([Z(1),Z(n2:-1:2)]) );     % odd part
X = [Ze,Ze(1)] + exp(-1i*2*pi/n*(0:n2)).*[Zo,Zo(1)];  % combine
X2 = fft(x);
max(abs(X-X2(1:n2+1)))  % 2.4492e-15