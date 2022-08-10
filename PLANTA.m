clc;
clear all;

fs = 100; %frecuencia de muestreo
Ts = 1/fs; %tiempo de muestreo
f = 2; %frecuencia entrada
N = 4*fs/f; %numero de muestras

x(1) = 1;%3*sin(2*pi*f*Ts*1);
x(2) = 1;%3*sin(2*pi*f*Ts*2);
y(1) = 0;
y(2) = 1.917*y(1) + 0.003115*x(1);
kTs(1)= 1*Ts;
kTs(2)= 2*Ts;

for k=3:N
    kTs(k) = k*Ts;
    x(k) = 1;%*sin(2*pi*f*Ts*k);
    y(k) = 1.917*y(k-1) -0.9231*y(k-2)+ 0.003115*x(k-1) + 0.003033*x(k-2);
end

n1= 1;%3*N/4;
n2 = N;
plot(kTs(n1:n2),x(n1:n2),'*r',kTs(n1:n2),y(n1:n2),'*b')
grid on
    