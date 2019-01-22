%1.Escribir un programa que resuelva un sistema lineal mediante el m�todo de Jacobi por puntos, pidiendo por pantalla,
%adem�s de la matriz y el segundo miembro, el n�mero m�ximo de iteraciones y la precisi�n para el test de parada.

function ProgramaJacobi()
%Solicitamos la matriz y el segundo miembro
A = input('Introduce una matriz: ');
b = input('Introduce el t�rmino independiente: ');
%Solicitamos el n�mero m�ximo de iteraciones y la precisi�n del test de
%parada
k = input('Introduce el n�mero m�ximo de iteraciones: ');
precisioneps = input('Introduce la precisi�n del test: ');
[u, numVueltasOk, precisionOk] = MetodoJacobi(A, b, k, precisioneps);
disp('El valor de la soluci�n es: ');
disp(u);
%Numero de iteraciones dadas:
disp('N�mero de iteraciones dadas: ');
disp(numVueltasOk);
%A uno si se ha salido por alcanzar la precisi�n, y no el n�mero de
%iteraciones
disp('Ha alcanzado la precisi�n: ');
disp(precisionOk);
disp('  (Si uno, ha alcanzado la precisi�n)');
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