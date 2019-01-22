%6:Programar el método Cholesky, implementándolo siguiendo las indicaciones dadas en clase, de forma
%que sirva para resolver sucesivos sistemas con la misma matriz.

%Solicita matriz y termino independiente la primera vez y las demás solo
%término independiente.
function ProgramaCholesky()
%Solicitar matriz
A = input('Introduce una matriz: ');
b = input('Introduce el término independiente: ');
[A, u] = MetodoCholesky(A, b);
display(u);
seguir = input('¿Quiere introducir otro sistema?(1 para seguir)');
while seguir == 1
    b = input('Introduce el término independiente: ');
    u = MetodoCholesky(A, b);
    display(u);
    seguir = input('¿Quiere introducir otro sistema?(1 para seguir)');
end
end


function varargout = MetodoCholesky(A, b)
%Si no se ha aplicado LU
if nargout ~= 1
    varargout{1} = Cholesky(A);
    %Si posee factorización LU
    %Aplicar remonte
    varargout{2} = remonte(varargout{1}, b);
    %Si se ha aplicado y queremos cambiar el b
else
    varargout{1} = remonte(A, b);
end
end

function A = Cholesky(A)
dim = size(A);
%Suponemos que es cuadrada
n = dim(1);
%Calculamos la matriz B y la almacenamos en la parte triangular inferior de
%A
for i = 1 : n
    %Calculo de los elementos de B
    %Calculamos primero el elemento de la diagonal para cada i, y luego la
    %fila hasta esa i
    aux = A(i, i) - norm(A(i, 1 : i - 1))^2;
    if aux <= 0
        error('Su matriz no admite factorización de Cholesky. Fin de la ejecución...');
    else
        A(i, i) = sqrt(aux);
    end
    
    for j = i + 1 : n
        A(j, i) = (1 / A(i, i)) * (A(i, j) - ((A(i, 1 : i - 1) * A(j, 1 : i - 1)')));
    end
end
end

%El remonte cambia respecto a la eliminacion gaussiana, ya que no tenemos
%punteros de filas
%Ademas introducimos una pequeña modificación
function [u] = remonte(A, b)
dim = size(A);
%Suponemos que es cuadrada
n = dim(1);
%Primer paso calculo w
w(1) = b(1);
for i = 2 : n
    w(i) = b(i) - (A(i, 1 : i - 1) * w(1 : i - 1)');
    %Dividimos entre el pivote, ya que aqui no tienen porque ser todo unos
    w(i) = w(i) / A(i, i);
end
%Segundo paso calculo u
%Usamos B transpuesta
u(n) = w(n) / A(n, n);
for i = n - 1 : - 1 : 1
    u(i) = (1 / A(i, i)) * (w(i) - (u(i + 1 : n) * A(i + 1 : n, i)));
end
end