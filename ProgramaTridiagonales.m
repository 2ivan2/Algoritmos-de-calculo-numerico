%8:Programar el método para resolver sistemas tridiagonales, implementándolo siguiendo las indicaciones dadas en clase, de forma
%que sirva para resolver sucesivos sistemas con la misma matriz.

%Solicita matriz y termino independiente la primera vez y las demás solo
%término independiente.
function ProgramaTridiagonales()
%Solicitar matriz
a = input('Introduce el vector de a: ');
b = input('Introduce el vector de b: ');
c = input('Introduce el vector de c: ');
d = input('Introduce el término independiente: ');

x = Tridiagonal(a, b, c, d);
display(x);
seguir = input('¿Quiere introducir otro sistema?(1 para seguir)');
while seguir == 1
    d = input('Introduce el término independiente: ');
    x = Tridiagonal(a, b, c, d);
    display(x);
    seguir = input('¿Quiere introducir otro sistema?(1 para seguir)');
end
end

function [x] = Tridiagonal(a, b, c, d)
dim = size(b);
n = dim(2)
%Suponemos que es cuadrada
%Calculamos las m
m(1) = b(1);
for k = 2 : n
    if m(k - 1) ~=0
        m(k) = b(k) - (c(k - 1) / m(k - 1)) * a(k - 1);
    else
        error('Error');
    end
end
%Calculamos las g
g(1) = d(1) / m(1);
for k = 2 : n - 1
    g(k) = (d(k) - g(k - 1) * a(k - 1)) / m(k);
end
%Ya que el m(n) no se comprobo en el otro bucle
if m(n) ~= 0
    g(n) = (d(n) - g(n - 1) * a(n - 1)) / m(n);
else
    error('Error');
end
%Calculamos la solucion
x(n) = g(n);
for k = n - 1 : -1 : 1
    x(k) = g(k) - (c(k) / m(k)) * x(k + 1);
end
end