function ux = trapezoidede( a, b, x)
% Datos para un triangulo
if(x < a)
    ux=0;

elseif(x >= a & x <= b)
    ux = (x-a)/(b-a);

elseif(x > b)
    ux = 1;

else
    
end
end