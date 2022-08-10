function ux = trapezoideiz( c, d, x)
% Datos para un triangulo
if(x > d)
    ux=0;

elseif(x >= c & x <= d)
    ux = (d-x)/(d-c);

elseif(x < c)
    ux = 1;

else
    
end
end
