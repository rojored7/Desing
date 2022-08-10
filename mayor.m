function salida = mayor(vector, valor)

i=1;

for i=1:1:length(vector)
    if(vector(i) >= valor(i))
        salida(i) = vector(i);
    else
        salida(i) = valor(i);
    end
    
end