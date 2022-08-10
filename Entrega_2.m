clc;
close all;
clear all;

%% constantes 
Ts = 0.01;
r1 = 100000;
r2 = 100000;
c1 = 1*10^-6;
c2 = 1*10^-6;

syms z

f = tf(1,[r1*r2*c1*c2 (r1*c1+r2*c2+r1*c2) 1])

g = c2d(f,Ts,'zoh')

figure
step(f)
hold on
figure
step(g)
hold on

%% MMCC
T = readtable('MMCC.txt');
T = T{:,1:3};
tim = T(:,1)';
u = T(:,2)';
y = T(:,3)';


n = 2 
t = size(u,2);
ZT = u;

for i = 1:n
    for j = 1:t-i
        ZT(2*i,i+j) = y(j);
        ZT(2*i+1,i+j) = u(j);
    end
end

Z = ZT';
Y = y';
YT = y;
P = inv(ZT*Z)*ZT*Y;
PT = YT*Z*inv(ZT*Z);
NuM = zeros(1,ceil(size(PT,2)/2));
DeN = zeros(1,floor(size(PT,2)/2));
j = 1;

for i = 1: 2:size(PT,2)
    NuM(j) = PT(i);
    j = j + 1;
end

j = 1;

for i = 2: 2:size(PT,2)
    DeN(j) = PT(i);
    j = j + 1;
end

NuM;
DeN = [1, DeN*-1];

final = tf(NuM,DeN,Ts,'Variable','z^-1')
opt = stepDataOptions('StepAmplitude',10);
Y = step(final,opt,tim*Ts,'r');

figure 
plot(tim*Ts,y,'r',tim*Ts,Y,'g')
title('Datos')
xlabel('Tiempo(s)'),ylabel('amplitud')
grid on


e = y - Y';
figure 
plot(tim*Ts,e)
title('error')
xlabel('Tiempo(s)'),ylabel('amplitud')
grid on