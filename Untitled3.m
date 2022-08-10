close all;
clear all;
clc;

i=0;
resolucion = 1;

%% semantica de posicion del motor en grados

for e=0: resolucion: 360 %universo discurso 
    i=i+1;
    PRU(i)=trapmf(0,10,20,30,e);
    MLD(i)=trapezoideiz(0,51,e);
    LD(i)=trapezoide(41,51,100,110,e);
    CD(i)=trapezoide(100,110,151,161,e);
    P(i)=trapezoide(150,155,165,170,e);
    CI(i)=trapezoide(165,175,230,240,e);
    LI(i)=trapezoide(230,240,290,300,e);
    MLI(i)=trapezoidede(290,360,e);
end

% graficas de las señales de entrada 
nexttile

z=[0:resolucion:360];
plot(z,PRU);
hold on
plot(z,LD);
hold on
plot(z,CD);
hold on
plot(z,P);
hold on
plot(z,CI);
hold on
plot(z,LI);
hold on
plot(z,MLI);
hold on
title('Graficas de entrada')

e0=45;

for e=0: resolucion: 360
    if e==e0
        x = e 
    end
    
end

%% Respuesta de voltaje
j=0;
for v=0: 0.1: 12 %universo discurso 
    j=j+1;
    MLD1(j)=trapezoideiz(0,2,v);
    LD1(j)=trapezoide(1,2,3,4,v);
    CD1(j)=trapezoide(3,4,5,6,v);
    P1(j)=trapezoide(5,6,7,8,v);
    CI1(j)=trapezoide(7,8,9,10,v);
    LI1(j)=trapezoide(9,10,11,12,v);
    MLI1(j)=trapezoidede(11,12,v);
end   
% graficas de las señales de entrada 

z1=[0: 0.1 :12];

nexttile
plot(z1,MLD1);
hold on
plot(z1,LD1);
hold on
plot(z1,CD1);
hold on
plot(z1,P1);
hold on
plot(z1,CI1);
hold on
plot(z1,LI1);
hold on
plot(z1,MLI1);
hold on
title('Graficas de control')

%% fusificar

MLD2=trapezoideiz(0,51,x)
LD2=trapezoide(41,51,100,110,x)
CD2=trapezoide(100,110,151,161,x)
P2=trapezoide(150,155,165,170,x)
CI2=trapezoide(165,175,230,240,x)
LI2=trapezoide(230,240,290,300,x)
MLI2=trapezoidede(290,360,x)


%% Inferencia difusa MANDANI


B1 = menor(MLD1,MLD2)
B2 = menor(LD1,LD2)
B3 = menor(CD1,CD2)
B4 = menor(P1,P2)
B5 = menor(CI1,CI2)
B6 = menor(LI1,LI2)
B7 = menor(MLI1,MLI2)

nexttile
plot(z1,B1);
hold on
plot(z1,B2);
hold on
plot(z1,B3);
hold on
plot(z1,B4);
hold on
plot(z1,B5);
hold on
plot(z1,B6);
hold on
plot(z1,B7);
hold on

nexttile

B = mayor(B1,mayor(B2,mayor(B3,mayor(B3,mayor(B4,mayor(B5,mayor(B6,B7)))))))

plot(z1,B);
hold on

%% DEFUZZY
