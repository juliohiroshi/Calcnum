tic()
a = 100 % mm²/s
Comprimentox = 50;%mm
Comprimentoy = 12.5;%mm
dx = dy = 2.5; %mm
nx = Comprimentox/dx +1 %mm
ny = Comprimentoy/dy +1 %mm

%Adição do tempo
tempomax = 0.5; %s
tempo = 0
dt = 0.01;  %s
nt = tempomax/dt+1

%Matriz chute-inicial
Tinicial = 30;
T = ones(ny, nx, nt)*Tinicial;

%Condições de contorno
T(ny, :, :) = 100;
T(:, 1, :) = 100;
T_old = T;

erromax = 10

while erromax>0.001;
    %i percorre o raio da barra visto a linha
    for i=2:ny-1
      %j percorre o comprimento longitudinal da barra
      for j=2:nx-1
        %t percorre o eixo temporal
        for t=2:nt
          T(i,j,t) = T(i,j,t-1) + dt*a*(T(i+1,j,t-1)+T(i-1,j,t-1)+T(i,j+1,t-1)+T(i,j-1,t-1) - 4*T(i,j,t-1))/(dx*dx);
        endfor
      endfor
    endfor


    %Derivada prescrita nas paredes
    for t=2:nt
      for j=2:nx
        T(1, j, t) = T(2, j, t);
      endfor
    endfor

    %Derivada prescrita nas paredes
    for t=2:nt
      for i=2:ny
        T(i, nx, t) = T(i, nx-1, t);
      endfor
    endfor

    %Erro definido como a maior diferença
    erro = T-T_old;
    erromax = max(max(max(abs(erro))))
    T_old = T;
endwhile


figure (1);
[c,h] = contourf(T(:,:, nt));
clabel(c, h, 'FontSize', 12, 'Color', 'white');
title("Distribuição de temperaturas t = 0.5")
xlabel('Nós x')
ylabel('Nós y')



toc()
