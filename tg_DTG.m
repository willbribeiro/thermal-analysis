% script para curvas TG e DTG
% author: Willian B. Ribeiro
clear,clc

A = load('willian.txt');
for c = 1:length(A)
    tempo(c) = A(c,1);
    temperatura(c) = A(c,2);
    TGA(c) = A(c,3);
end
for c = 1:length(TGA)
    TG_porcentagem(c) = (TGA(c)/TGA(1))*100;
end

% calcular a derivada primeira da curva TG (DTG) - 
% (método Differentiate - Originlab)
for i = 1:length(TG_porcentagem)
    if i == 1
         derivada(i) = (TG_porcentagem(i+1)-TG_porcentagem(i))/(tempo(i+1)-tempo(i));
    elseif i == length(TG_porcentagem)
         derivada(i) = (TG_porcentagem(i)-TG_porcentagem(i-1))/(tempo(i)-tempo(i-1));
    else
        primeiro = (TG_porcentagem(i+1)-TG_porcentagem(i))/(tempo(i+1)-tempo(i));
        segundo = (TG_porcentagem(i)-TG_porcentagem(i-1))/(tempo(i)-tempo(i-1));
        derivada(i) = (1/2)*(primeiro + segundo);
    end
end

while true
    disp('*=*=*=*=MENU*=*=*=*=*=')
    disp('(1) - Gráfico Curva TG')
    disp('(2) - Gráfico Curva DTG')
    disp('(3) - Gráfico TG/DTG')
    disp('(0) - para sair')
    disp('*=*=*=*=*=*=*=*=*=*=*=')
    escolha = input('Digite sua opção: ');
    disp(' ')    
    
    switch escolha
        case 1
            % cria o gráfico TG
            figure(1)
            plot(temperatura, TG_porcentagem)
            ylabel('Massa (%)')
            xlabel('Temperatura (ºC)')
            title('Curva TG')
            axis([25,930,0,105])
        case 2
            % cria o gráfico DTG
            figure(2)
            plot(temperatura,derivada)
            ylabel('DTG (%/s)')
            xlabel('Temperatura (ºC)')
            title('Curva DTG')
            axis([25,930,-0.6,0.05])
        case 3
            % cria o gráfico TG/DTG
            figure(3)
            yyaxis left
            plot(temperatura,TG_porcentagem)
            ylabel('Massa (%)')
            axis([25,930,0,105])

            yyaxis right
            plot(temperatura,derivada)
            ylabel('DTG (%/s)')
            axis([25,930,-0.6,0.05])

            title('Curva TG e DTG')
            xlabel('Temperatura (ºC)')
            legend({'TG','DTG'}, 'Location', 'southwest')
        case 0
            break
        otherwise
            disp('Escolha inválida. Escolha novamente')
    end
end