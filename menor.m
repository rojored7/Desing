function salida = menor(vector, valor)

i=1;

for i=1:1:length(vector);
    if(vector(i) <= valor)
        salida(i) = vector(i);
    else
        salida(i) = valor;
    end
    
end