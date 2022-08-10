function r=trapmf(a, b, c, d, x)
r=mayor(menor(menor((x-a)/(b-a),1), (d-x)/(d-c)),0)
end