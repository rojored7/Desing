clc
clear all
close all

syms s I1 I2 C1 C2 R L Vo Vi

eqn4 = s*Vi == L*I1*s^2 + (I1-I2)/C1;
eqn5 = (I1-I2)/C1 == R*I2*s + I2/C2;
eqn6 = I2/C2 == Vo*s; 

eqn1 = s*Vi == L*I1*s^2 + (I1-I2)/C1;
eqn2 = (I1-I2)/C1 == R*I2*s + I2/C2;
eqn3 = I2/C2 == Vo*s; 

I1 = solve(eqn1,I1);
eqn2 = simplify((I1-I2)/C1 == R*I2*s + I2/C2);

I2 = solve(eqn2,I2);
eqn3 = I2/C2 == Vo*s;

Vo = solve(eqn3,Vo);

collect(Vo,s)
%% CONSTANTES 

r = 10000;
l = 1*10^-3;
c1 = 1*10^-6;
c2 = 1*10^-6;

fc = 1/(2*pi*sqrt(l*c1))

ts = 1/fc;

%% MOdelado tf laplace

num=[1];
den=[(r*l*c1*c2) (l*(c2+c1)) (c2*r) (1)];

F=tf(num , den)
step(F)
hold on


syms a b c d x

eqn = a*x^3 + b*x^2 + c*x + d == 0
S = solve(eqn)
p=[a b c d];
roots(p)


%% Z
g=c2d(F,ts)
g1=c2d(F,0.01)
numz=g.numerator();
denz=g.denominator();
step(g)
hold on
x=(0.01967*exp(0.2*pi*j)-0.03896*exp(0.1*pi*j)+0.01929)/(exp(0.3*pi*j)-2.961*exp(0.2*pi*j)+2.922*exp(0.1*pi*j)-0.961)

mf=(sqrt((-0.0059)^2+(- 0.0628)^2))
af=atan((-0.0059)/(- 0.0628))-pi
%% z con scrip

%% Constantes
fs = 1000; %frecuencia de muestreo
Ts = 1/fs; %tiempo de muestreo
f = 20; %frecuencia entrada
N = 4*fs/f; %numero de muestras

%% Valores 

%Entrada

x(1) = 1;%3*square(fc*Ts*1);
x(2) = 1;%3*square(fc*Ts*2);
x(3) = 1;%3*square(fc*Ts*3);
%Aprox salida

y(1) = 0;
y(2) = 0.2091*y(1) +0.6304*x(1);
y(3) = 0.2091*y(1) + 0.1556*y(2) +0.6304*x(1) +0.3671*x(2);

%Grafica

kTs(1)= 1*Ts;
kTs(2)= 2*Ts;
kTs(3)= 3*Ts;

for k=4:N
    kTs(k) = k*Ts;
    x(k) = 1;%3*square(fc*Ts*k);
    y(k) = 0.2091*y(k-1)+0.1556*y(k-2) -0.1353*y(k-3)+0.6304*x(k-1) +0.3671*x(k-2) + 0.2319*x(k-3);
 
end

%% Graficas

n1= 1;%3*N/4;
n2 = N;


figure 
plot(kTs(n1:n2),y(n1:n2),'r',kTs(n1:n2),x(n1:n2),'b')
title('Salida estimada')
xlabel('Tiempo(s)'),ylabel('amplitud')
grid on
%% Simulación respuesta en tiempo del modelo 


t = 0:pi/100:pi;
w = (2*pi*fc)

Ft=tf([1] , [(r*l*c1*c2) (l*(c2+c1)) (c2*r) (1)]);

A = abs(freqresp(Ft,fc))
Arg = 180*phase(freqresp(Ft,fc))/pi

ye=A*square(5*t+Arg);
yt=A*sin(5*t+Arg);
figure
plot(t,ye,t,yt)
hold on
%lsim(Ft,yt,t)

syms t s
ff=1/ (1e-11*s^3 + 2e-09*s^2 + 0.01*s + 1)
inv = ilaplace(ff)
figure
fplot(inv,[-0.01 -0.005])