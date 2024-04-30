clear,clc
for w = 1:4
    if w == 1
        filename = 'TGA-c145a-celulose tx 5.txt';
    elseif w == 2
        filename = 'TGA-c150a-celulose tx 10-1.txt';
    elseif w == 3
        filename = 'TGA-c151a-celulose tx 20.txt';
    else
        filename = 'TGA-c152a-celulose tx 40.txt';
    end
    
    % para limpar as listas para cada arquivo
    clear A; clear tempo; clear temperatura; clear TG_massa; clear TG_porc; 
    clear alfa; clear derivada
    
    % carrega os dados do arquivo txt para a variável A 
    A = load (filename);
    for c = 1:length(A)
        tempo(c) = A(c,1);
        temperatura(c) = A(c,2);
        TG_massa(c) = A(c,3);
    end
    
    % converte a TG de massa para porcentagem
    for c = 1:length(TG_massa)
         TG_porc(c) = (TG_massa(c)/TG_massa(1))*100;
         alfa(c) = (TG_massa(1)-TG_massa(c))/(TG_massa(1)-TG_massa(length(TG_massa)));
    end
    
    % calcular a derivada primeira da curva TG (DTG) - 
    % (método Differentiate - Originlab)
    for i = 1:length(TG_porc)
        if i == 1
            derivada(i) = (TG_porc(i+1)-TG_porc(i))/(tempo(i+1)-tempo(i));
        elseif i == length(TG_porc)
            derivada(i) = (TG_porc(i)-TG_porc(i-1))/(tempo(i)-tempo(i-1));
        else
            primeiro = (TG_porc(i+1)-TG_porc(i))/(tempo(i+1)-tempo(i));
            segundo = (TG_porc(i)-TG_porc(i-1))/(tempo(i)-tempo(i-1));
            derivada(i) = (1/2)*(primeiro + segundo);
        end
    end
    
    % encontrar a T pico em cada taxa
    min = derivada(1);
    indice = 1;
    for cont = 2:length(derivada)
        if derivada(cont) < min
            min = derivada(cont);
            indice = cont;
        end
    end
    T_pico(w) = temperatura(indice);
    
    % Figura 1 - Curvas TG de cada taxa de aquecimento
    figure (1)
    plot(temperatura, TG_porc)
    axis([10 605 0 105])
    hold on
    
    % Figura 2 - Conversão
    figure (2)
    plot(temperatura, alfa)
    axis([10 605 -0.1 1.1])
    hold on
    
    % Figura 3 - Curvas DTG
    figure (3)
    plot(temperatura, derivada)
    hold on
end

figure (1)
title('Curvas TG')
xlabel('Temperatura (ºC)')
ylabel('Massa (%)')
legend('5 ºC/min','10 ºC/min', '20 ºC/min', '40 ºC/min')

figure (2)
title('Conversão vs. Temperatura')
xlabel('Temperatura (ºC)')
ylabel('Conversão')
legend({'5 ºC/min','10 ºC/min', '20 ºC/min', '40 ºC/min'},'Location','northwest')

figure (3)
title('Curvas DTG')
xlabel('Temperatura (ºC)')
ylabel('DTG (%/seg)')
legend({'5 ºC/min','10 ºC/min', '20 ºC/min', '40 ºC/min'},'Location','southwest')