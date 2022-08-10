clc;
close all;
clear all;


%% sistema 

syms S R I1 I2 C1 C2 L VO VI% c1 c2 l r

eq1 = R*I1 + (1/C1*S)*(I1-VO*C2*S)==VI
eq2 = (1/C1*S)*(VO*C2*S-I1) + L*S*VO*C2*S + (1/C2*S)*VO*C2*S==0


[X Y]=solve(eq1,eq2)

%% constantes 

%num1 = 1/(c1*c2*l*r)
%den1 = [1 1/(c1*r) (c1+c2)/(c1*c2*l) 1/(c1*c2*l)]

ts = 0.01;
r = 100000;
l = 1*10^-3;
c1 = 1*10^-6;
c2 = 1*10^-6;

F=tf([1] , [(r*l*c1*c2) (l*c2) ((r*c2)+(r*c1)) 1])

G = c2d(F,ts,'zoh')


figure 
step(F)
title('Sistema en continuo')
xlabel('Tiempo(s)', 'interpreter' , 'latex')
ylabel('amplitud', 'interpreter' , 'latex')
legend({'Respuesta en continuo del sistema'},'interpreter' , 'latex')
figure
step(G)
title('Sistema en discreto')
xlabel('Tiempo(s)', 'interpreter' , 'latex')
ylabel('amplitud', 'interpreter' , 'latex')
legend({'Respuesta en discreto del sistema'},'interpreter' , 'latex')
%% MMCR
n = 3;      %orden del sistema
fs = 100;   %Frecuencia de muestreo
Ts = 1/fs;  %Tiempo de muestreo 

t = 200*fs; %Numero de muestras 

P = [0.1;0.1;0.1;0.1;0.1; 0.1; 0.1]; % se inicializa un vector P de tamaño 2n+1
C = 100*eye(2*n+1);
phi = 0.9995;
phi2 = phi*phi;

r = rand(1);
con = 1;
b1 = 0.04867;


for k=1:t

    if k == round(t/2)
        b1 = 0.05867
        P
    end
    if con >= 2*fs
        r = rand(1);
        con = 1;
    else 
        con = con + 1;
    end
    
    kTs(k) = k*Ts;
    u(k) = r;
    
    if k==1
        y(1) = 0;
        z = [u(k); 0; 0; 0; 0; 0; 0];
        
    elseif k==2 
        y(k) = 1.823*y(k-1) + b1*u(k-1);
        z = [u(k); y(k-1); u(k-1); 0; 0; 0; 0];
        
    elseif k==3
        y(k) = 1.823*y(k-1) - 1.781*y(k-2) + b1*u(k-1) - 0.04233*u(k-2);
        z = [u(k); y(k-1); u(k-1); y(k-2); u(k-2); 0; 0];
        
    else
        
        y(k) = 1.823*y(k-1) - 1.781*y(k-2) + 0.9048*y(k-3) + b1*u(k-1) - 0.04233*u(k-2) + 0.0463*u(k-3);
        z = [u(k); y(k-1); u(k-1); y(k-2); u(k-2); y(k-3); u(k-3)];
        
    end
    
    %% Algoritmo recursivo
    
    g = C * z;
    alpha2 = phi2 + z' * g;
    ye(k) = P' * z;
    e(k) = y(k) - ye(k);
    P = P + (1/alpha2)* g * e(k);
    C = (1/phi2)*(C-(1/alpha2) * g * g');
    
    

end
P

n1= 1;%3*N/4;
n2 = t;


figure 
plot(kTs(n1:n2),u(n1:n2),'r',kTs(n1:n2),y(n1:n2),'b')
title('Metodo vs Datos')
xlabel('Tiempo(s)', 'interpreter' , 'latex')
ylabel('amplitud', 'interpreter' , 'latex')
legend({'$U(kt)$','$Y(t)$'},'interpreter' , 'latex')
grid on


figure 
plot(kTs(n1:n2),e(n1:n2),'r')
title('Error')
xlabel('Tiempo(s)', 'interpreter' , 'latex')
ylabel('amplitud', 'interpreter' , 'latex')
legend({'$e(kt)$'},'interpreter' , 'latex')
grid on