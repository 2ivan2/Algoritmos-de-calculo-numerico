% 1 Escribir un programa que calcule el polinomio de interpolación de Lagrange de una función en unos puntos dados
% mediante la fórmula de Newton, y que permita añadir nuevos puntos de interpolación (de uno en uno). Dibujar la función
% y el polinomio de interpolación obtenido. Hacer una versión que sirva para interpolar los valores de una tabla dibujando,
% en este caso, el polinomo de interpolación y los valores interpolados.

function ProgramaInterpolacion()
%Pedir puntos
vecp = input('Introduce un vector con los puntos a evaluar: ');
%Pedir tabla o funcion
ok = true;
while ok == true
    opcion = input('Introduce f para funcion o t para tabla: ', 's');
    if opcion == 'f'
        ok = false;
        fstr=input('Dame la función con ''x'' como variable:  ','s');
        fvec=vectorize(fstr);
        f=eval(['@(x) ' fvec]);
        
        figure
        hold on
        fplot(f, [min(vecp),max(vecp)]);
        vecf = f(vecp);
        [pol, prodAcum, vecp, vecf] = InterpolacionFuncion(vecp, vecf);
    elseif  opcion == 't'
        ok = false;
        vecf = input('Introduce un vector con la imagen de los puntos: ');
        
        figure
        hold on
        [pol, prodAcum, vecp, vecf] = InterpolacionFuncion(vecp, vecf);
    end
end

ok = true;

while ok == true
    opcionp = input('Quieres introducir otro punto?:','s');
    if opcionp == 's'
        
        p = input('Introduce el punto: ');
        if opcion == 'f'
            
            figure
            hold on
            fplot(f, [min([vecp, p]),max([vecp, p])]);
            
            [pol, prodAcum, vecp, vecf] = InterpolacionFuncionPunto(p, f(p), pol, prodAcum, vecp, vecf);
        elseif opcion == 't'
            fp = input('Introduce su imagen: ');
            
            figure
            hold on
            [pol, prodAcum, vecp, vecf] = InterpolacionFuncionPunto(p, fp, pol, prodAcum, vecp, vecf);
            
        end
    elseif  opcionp == 'n'
        ok = false;
    end
end
hold off
close ALL;
end


function [pol, prodAcum, vectp, fvectp] = InterpolacionFuncion(vectp, fvectp)
prodAcum = 1;
pol = fvectp(1);
%Actualizamos la tabla de diferencias divididas
for j = 1 : length(vectp) - 1
    k = length(vectp) - j;
    for i = 1 : k
        fvectp(i) = (fvectp(i) - fvectp(i + 1))/(vectp(i) - vectp(i + j));
    end
    %Calculamos el polinomio acumulado mediante vectores
    aux = prodAcum;
    prodAcum = [prodAcum, 0];
    prodAcum = prodAcum - [0, aux*vectp(j)];
    pol = [0, pol] + fvectp(1)* prodAcum ;
end

x = linspace(min(vectp),max(vectp));
y = polyval(pol, x);
plot(x, y);
plot(vectp, polyval(pol, vectp), 'o')
end

function [pol, prodAcum, vectp, fvectp] = InterpolacionFuncionPunto(p, fp, pol, prodAcum, vectp, fvectp)
%Añadimos una nueva diagonal a la tabla, que en nuestro caso sera un ultimo
%elemento del vector
fvectp = [fvectp, fp];
vectp = [vectp, p];
%Subimos escalonadamente
for i = length(fvectp) - 1 : -1 : 1
    fvectp(i) = (fvectp(i) - fvectp(i + 1))/(vectp(i) - vectp(end));
end
%Calculamos el polinomio acumulado mediante vectores
aux = prodAcum;
prodAcum = [prodAcum, 0];
prodAcum = prodAcum + [0, aux.*(-1*vectp(end - 1))];
pol = [0, pol] + fvectp(1).* prodAcum ;

x = linspace(min(vectp),max(vectp));
y = polyval(pol, x);
plot(x, y);
plot(vectp, polyval(pol, vectp), 'o')
end
