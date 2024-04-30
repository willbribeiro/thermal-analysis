clear,clc

% carrega os dados do arquivo txt
A = load('DSC-f0654a Aula DSC 2020s.txt');

% coloca os dados nas listas
for i = 1:length(A)
    tempo(i) = A(i,1);
    temperatura(i) = A(i,2);
    dsc(i) = A(i,3)/10.200;
end
plot(temperatura,dsc)
axis([31,205,-0.25,0.7])
title('Curva DSC')
xlabel('Temperatura (ºC)')
ylabel('Fluxo de calor (mW/mg)')