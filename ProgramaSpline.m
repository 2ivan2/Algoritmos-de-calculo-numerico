% 2 Programar el cálculo de una función spline cúbica interpoladora de una
% función dada. Dibujar ambas funciones. Hacer, también en este caso, una
% versión que interpole los valores de una tabla dibujando la función
% spline cúbica obtenida y dichos valores.

function ProgramaSpline()
%Pedir puntos
vecp = input('Introduce un vector con los puntos a evaluar: ');
%Pedir tabla o funcion
ok = true;
tipo = input('Tipo 1 o 2:' );
cond(1) = 0;
cond(2) = 0;
while ok == true
    opcion = input('introduzce f para funcion o t para tabla: ', 's');
    if opcion == 'f'
        ok = false;
        fstr=input('Dame la funcion con ''x'' como variable:  ','s');
        fvec=vectorize(fstr);
        f=eval(['@(x) ' fvec]);
        
        der =vectorize(diff(sym(f)));
        fprima = eval(['@(x) ' der]);
        
        cond(1) = fprima(vecp(1));
        cond(2) = fprima(vecp(end));
        vecf = f(vecp);
        
        figure
        hold on
        fplot(f, [min(vecp),max(vecp)]);
        
        SplineFuncion(vecp, vecf, tipo, cond);
        
    elseif  opcion == 't'
        if tipo == 2
            cond(1) = input('Valor de la derivada en el más pequeño: ');
            cond(2) = input('Valor de la derivada en el más grande: ');
        end
        ok = false;
        vecf = input('Introduce un vector con la imagen de los puntos: ');
        figure
        hold on
        SplineFuncion(vecp, vecf, tipo, cond);
    end
end
salir = input('Presiona enter para salir');
hold off;
close ALL;
end

function SplineFuncion(vectp, fvectp, tipo, cond)
n = length(vectp) - 1;
%Calculamos h_j
for i = 1 : n
    h(i) = vectp(i + 1) - vectp(i);
end
b = ones(n + 1, 1) + 1;
b = transpose(b);
for j = 1 : n-1
    lambda(j + 1) = h(j + 1) / (h(j) + h(j + 1));
    mu(j) = 1 - lambda(j + 1);
    d(j + 1) = (6 / (h(j) + h(j + 1))) * (((fvectp(j + 2) - fvectp(j + 1)) / h(j + 1)) - ((fvectp(j + 1) - fvectp(j)) / h(j)));
    %Los +1 de lambda y de d se deben a que quiero que cuadren los indices
    %del libro para así facilitarme las fórmulas, ya que en matlab los
    %array no tienen posición cero
end
if tipo == 1
    lambda(1) = 0;
    d(1) = 0;
    mu(n) = 0;
    d(n + 1) = 0;
elseif tipo == 2
    lambda(1) = 1;
    mu(n) = lambda(1);
    d(1) = (6 / h(1))*(((fvectp(2) - fvectp(1)) / h(1)) - cond(1));
    d(n + 1) = (6 / h(n))*(cond(2) - ((fvectp(n + 1) - fvectp(n)) / h(n)));
end
M = Tridiagonal(mu, b, lambda, d);
%Calculamos los polinomios
S = ones(n, 4);
for j = 1 : n
    alpha(j) = fvectp(j);
    beta(j) = ((fvectp(j + 1) - fvectp(j)) / h(j))  - ((2 * M(j) + M(j + 1)) / 6) * h(j);
    gamma(j) = M(j) / 2;
    delta(j) = (M(j + 1) - M(j)) / (6 * h(j));
    S(j, :) = [0, 0, 0, alpha(j)] + beta(j) .* [0, 0, 1, -vectp(j)] + gamma(j) .* [0, 1, -2*vectp(j), vectp(j)^2] + delta(j) .* [1, -3*vectp(j), 3*vectp(j)^2, -vectp(j)^3];
end
%Representamos las spline cada una en su intervalo
hold on
for j = 1:n
    x = linspace(vectp(j), vectp(j+1), 50);
    y = polyval(S(j,:), x);
    plot(x, y, 'r'); %Pintamos de rojo la spline
end
plot(vectp, fvectp, 'o')
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