%2:Programar el método de eliminación gaussiana, implementándolo siguiendo las indicaciones dadas en clase, de forma
%que sirva para resolver sucesivos sistemas con la misma matriz. Comparar
%con el comando n de MATLAB.


%Solicita matriz y termino independiente la primera vez y las demás solo
%término independiente.
function ProgramaGaussiana()
%Solicitar matriz
A = input('Introduce una matriz: ');
b = input('Introduce el término independiente: ');
[A, v, n, u] = EliminacionGaussiana(A, b);
display(u);

seguir = input('¿Quiere introducir otro sistema?(1 para seguir)');
while seguir == 1
    b = input('Introduce el término independiente: ');
    u = EliminacionGaussiana(A, b, v, n);
    display(u);
    seguir = input('¿Quiere introducir otro sistema?(1 para seguir)');
end
end

%Función que implementa la eliminación gaussiana. Diferencia si viene la
%matriz y el termino independiente o solo el término independiente como
%parametros de salida y llama a gaussian y a remonte si tiene más de un
%parametro de salida, y solo a remonte si tiene un parámetro de salida
function varargout = EliminacionGaussiana(A, b, v, n)
%Si no se ha aplicado el gaussian
if nargout ~= 1
    %invertible aborta la ejecucion si no es invertible la matriz A
    [varargout{1}, varargout{2}, varargout{3}] = gaussian(A);
    %Aplicar remonte
    varargout{4} = remonte(varargout{1}, b, varargout{2}, varargout{3});
    %Si se ha aplicado y queremos cambiar el b
else
    varargout{1} = remonte(A, b, v, n);
end
end

%Te calcula la matriz triangular superior con los pivotes en la parte
%triangular inferior
function[A, v, n] = gaussian(A)

dim = size(A);
%Suponemos que es cuadrada
n = dim(1);
v = 1 : 1 : n;

for i = 1 : n
    %Calculamos el pivote más gordo
    [pivote_gordo, posicion] = max(abs(A(v(i : n), i)));
    if pivote_gordo == 0
        error('Su matriz no es invertible. Fin de la ejecución...');
    else
        posicion = posicion + i - 1;
        if v(posicion) ~= v(i)
            %Tenemos que cambiar la fila
            %A([i,posicion],:)= A([posicion,i],:);
            v([i, posicion]) = v([posicion, i]);
        end
        %Dividimos la columna por el pivote
        A(v(i + 1 : n), i) = A(v(i + 1 : n), i) / A(v(i), i);
        %Tenemos guardado debajo del pivote los alpha dividido entre el pivote
        %gordo, y ahora restaremos los subvectores
        for j = i + 1 : n
            A(v(j), i + 1 : n) =  A(v(j), i + 1 : n) - A(v(j), i) * A(v(i), i + 1 : n);
        end
    end
end
end

%Calcula el remonte y devuelve la solución
function[u] = remonte(A, b, v, n)
%Primer paso calculo w
w(1) = b(v(1));
for i = 2 : n
    w(i) = b(v(i)) - (A(v(i), 1 : i - 1) * w(1 : i - 1)');
end
%Segundo paso calculo u
u(n) = w(n) / A(v(n), n);
for i = n - 1 : - 1 : 1
    u(i) = (1 / A(v(i), i)) * (w(i) - (A(v(i), i + 1 : n) * u(i + 1 : n)'));
end
end