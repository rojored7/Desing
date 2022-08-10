function ux = trapezoide(a, b, c, d, x)
% Datos para un triangulo
if(x < a | x > d)
    ux=0;

elseif(x >= a & x <= b)
    ux = (x-a)/(b-a);

elseif(x >= b & x <= c)
    ux = 1;

else
    ux = (d-x)/(d-c);
end
end
