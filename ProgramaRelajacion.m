%2.Escribir un programa que resuelva un sistema lineal mediante el m�todo de relajaci�n por puntos, pidiendo por
%pantalla, adem�s de la matriz y el segundo miembro, el par�metro de relajaci�n, el n�mero m�ximo de iteraciones y la
%precisi�n para el test de parada.

function ProgramaRelajacion()
%Solicitamos la matriz y el segundo miembro
A = input('Introduce una matriz: ');
b = input('Introduce el t�rmino independiente: ');
%Solicitamos el n�mero m�ximo de iteraciones y la precisi�n del test de
%parada
k = input('Introduce el n�mero m�ximo de iteraciones: ');
precisioneps = input('Introduce la precisi�n del test: ');
w = input('Introduce el factor de peso: ');
[u, numVueltasOk, precisionOk] = MetodoRelajacion(A, b, k, precisioneps, w);
disp('El valor de la soluci�n es: ');
disp(u);
%Numero de iteraciones dadas
disp('N�mero de iteraciones dadas: ');
disp(numVueltasOk);
%A uno si se ha salido por alcanzar la precisi�n, y no el n�mero de
%iteraciones
disp('Ha alcanzado la precisi�n: ');
disp(precisionOk);
disp('  (Si uno, ha alcanzado la precisi�n)');
end

function [u, numVueltasOk, precisionOk] = MetodoRelajacion(A, b, k, precisioneps, w)
dim = size(A);
%Suponemos que es cuadrada
n = dim(1);
kp = 0;
precisionOk = false;
u_k = ones(1, n);
kp = 0;
while kp <= k && precisionOk == false
    for i = 1 : n
        r(i) = b(i) - (A(i, 1 : i - 1) * u_k(1 : i - 1)') - (A(i, i : n) * u_k(i : n)');
        u_k(i) = u_k(i) + (w * r(i) / A(i, i));
    end
    if norm(r) / norm(b) < precisioneps
        precisionOk = true;
    end
    kp = kp + 1;
end
u = u_k;
numVueltasOk = kp;
end