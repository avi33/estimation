function [x_d] = delaySigByFraction(x , d)

n=size(x,1);
dw = 2*pi/n;
if (mod(n,2)==1)
    w = [0, dw:dw:pi, fliplr(-dw:-dw:-pi)]';
else
    w = [0:dw:pi-dw, fliplr(-dw:-dw:-pi)]';
end
phi = d*w;    
x_d = ifft(fft(x) .* exp(-1i*phi));
end