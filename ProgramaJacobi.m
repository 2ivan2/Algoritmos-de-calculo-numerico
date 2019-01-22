%1.Escribir un programa que resuelva un sistema lineal mediante el método de Jacobi por puntos, pidiendo por pantalla,
%además de la matriz y el segundo miembro, el número máximo de iteraciones y la precisión para el test de parada.

function ProgramaJacobi()
%Solicitamos la matriz y el segundo miembro
A = input('Introduce una matriz: ');
b = input('Introduce el término independiente: ');
%Solicitamos el número máximo de iteraciones y la precisión del test de
%parada
k = input('Introduce el número máximo de iteraciones: ');
precisioneps = input('Introduce la precisión del test: ');
[u, numVueltasOk, precisionOk] = MetodoJacobi(A, b, k, precisioneps);
disp('El valor de la solución es: ');
disp(u);
%Numero de iteraciones dadas:
disp('Número de iteraciones dadas: ');
disp(numVueltasOk);
%A uno si se ha salido por alcanzar la precisión, y no el número de
%iteraciones
disp('Ha alcanzado la precisión: ');
disp(precisionOk);
disp('  (Si uno, ha alcanzado la precisión)');
end

function [u, numVueltasOk, precisionOk] = MetodoJacobi(A, b, k, precisioneps)
dim = size(A);
%Suponemos que es cuadrada
n = dim(1);
kp = 0;
precisionOk = false;
u_k = ones(1, n);
u_k1 = ones(1, n);
kp = 0;
while kp <= k && precisionOk == false
    for i = 1 : n
        r(i) = b(i) - (A(i, 1 : n) * u_k(1 : n)');
        d(i) = r(i) / A(i, i);
        u_k1(i) = u_k(i) + d(i);
    end
    u_k = u_k1;
    if norm(r) / norm(b) < precisioneps
        precisionOk = true;
    end
    kp = kp + 1;
end
u = u_k1;
numVueltasOk = kp;
end