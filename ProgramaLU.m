%4:Programar el método LU, implementándolo siguiendo las indicaciones dadas en clase, de forma
%que sirva para resolver sucesivos sistemas con la misma matriz.

%Solicita matriz y termino independiente la primera vez y las demás solo
%término independiente.
function ProgramaLU()
%Solicitar matriz
A = input('Introduce una matriz: ');
b = input('Introduce el término independiente: ');
[A, u] = MetodoLU(A, b);
display(u);

seguir = input('¿Quiere introducir otro sistema?(1 para seguir)');
while seguir == 1
    b = input('Introduce el término independiente: ');
    u = MetodoLU(A, b);
    display(u);
    seguir = input('¿Quiere introducir otro sistema?(1 para seguir)');
end
end

function varargout = MetodoLU(A, b)
%Si no se ha aplicado LU
if nargout ~= 1
    varargout{1} = LU(A);
    %Si posee factorización LU
    %Aplicar remonte
    varargout{2} = remonte(varargout{1}, b);
    %Si se ha aplicado y queremos cambiar el b
else
    varargout{1} = remonte(A, b);
end
end

function[A] = LU(A)
dim = size(A);
%Suponemos que es cuadrada
n = dim(1);
%Calculamos U y luego L y las guardamos en A (La diagonal de L no es
%necesario gaurdarla ya que son todo unos, y por eso entran las dos en A)
%A queda de la forma: A <= zeroMatrix + (L-I) + U
for i = 1:n
    %Fila i-esima de U
    for j = i : n
        A(i, j) = A(i, j) -  (A(i, 1 : i - 1) * A(1 : i - 1, j));
    end
    %Fila i-esima de L
    if A(i,i) == 0
        error('Su matriz no admite factorización LU. Fin de la ejecución...');
    else
        for j = i + 1 : n
            A(j, i) = (1 / A(i, i)) * (A(j, i) - (A(j, 1 : i - 1) * A(1 : i - 1, i)));
        end
    end
end
end

%El remonte cambia respecto a la eliminacion gaussiana, ya que no tenemos
%punteros de filas
function[u] = remonte(A, b)
dim = size(A);
%Suponemos que es cuadrada
n = dim(1);
%Primer paso calculo w
w(1) = b(1);
for i = 2 : n
    w(i) = b(i) - (A(i, 1 : i - 1) * w(1 : i - 1)');
end
%Segundo paso calculo u
u(n) = w(n) / A(n, n);
for i = n-1 : -1 : 1
    u(i) = (1 / A(i, i)) * (w(i) - (A(i, i + 1 : n) * u(i + 1 : n)'));
end
end