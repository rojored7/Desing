function ux = triangulode(a, m, b, x)
% Datos para un triangulo
if(x <= a)
    ux=0;

elseif(x > a & x <= m)
    ux = (x-a)/(m-a);

elseif(x > m & x < b)
    ux = (b-x)/(b-m);

else
    ux = 1;
end
end