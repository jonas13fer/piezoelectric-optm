%==========================================================================   
%==========================================================================                                                                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
%                                                                         % 
%       UNIVERSIDADE FEDERAL DE GOIÁS                                     %  
%       IMTec - UFG  - PPGMO                                              %
%                                                                         %
%       IMPLEMENTAÇAO DA TECNICA DE OTIMIZAÇAO "SIMULATED ANNEALING"      %
%                                       
%                                                     
%                       Romes Antonio Borges                              %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                                                                          
%==========================================================================
%==========================================================================

function [fbest, xbest, ncalls, iaceit, ibest] = simannealing(evalcosf, ...
    x0, xlower, xupper, starttemp,stoptemp, ntemp)

    %======================================================================
    %               Parâmetros de entrada
    %======================================================================
    %evalcosf = função objetivo
    %x0 = Vetor dos parâmetros de projeto (configuração inicial)
    %xlower = limite inferior das variáveis de projeto
    %xupper = limite superior das variáveis de projeto 
    %starttemp = Temperatura incial é o desvio padrão da perturbação 
                %randômica usada inicialmente deve ser maior que a máxima
                %distância esperada entre o início e o ponto de mínimo.
    %stoptemp = %É o desvio padrão final. Ele deve ter a magnitude da 
                %precisão esperada na localização do melhor ponto
    %ntemp = Quantidade de temperaturas
    %======================================================================
    %======================================================================
    
    
    %======================================================================
    %               Parâmetros de resposta
    %======================================================================
    %fbest = melhor valor da função objetivo
    %xbest = melhor ponto encontrado
    %ncalls = número de avaliações da função objetivo
    %iaceit = número de pontos aceitos durante pelo critério de Metropolis
    %ibest = número de pontos melhorados
    %======================================================================
    %======================================================================
    
    
    %======================================================================
    %               Parâmetros de execução pré-estabelecidos
    %======================================================================
    niters = 300;   %Quantidade de iteraçãoes para cada temperatura
    setback = 10;   %Volta a iteração se necessário
    nepsilon = 5;   %Número de temperaturas consecutivas onde o critério de
                    %convergência deve ser satisfeito
    
    maxcalls = 3000;     %Numero limite de avaliações da função objetivo
    fquit = 1.e-3;       %Tolerância considerada para a função minimizada
    kb = 1.e-6;          %Constante de Boltzmann (tdesvio)
    %======================================================================
    %======================================================================
    
    nvars = length(x0);                        %Quantidade de variáveis de projeto           
    rt = exp(log(stoptemp/starttemp)/(ntemp-1)); %coeficiente de
                                                %atualização da temperatura
    %Configuração inicial                                             
    x = x0;
    xbest = x0;      
    fbest = evalcosf(xbest);
    E0 = fbest;
    ncalls = 1;
    
    ibest = 1;
    bestx(1,:) = xbest;
    bestfunction(1) = fbest;

    iaceit = 1;     
    temp = starttemp;
   
        
    for itemp = 1:1:ntemp   %Loop de redução da temperatura
        %disp(['TEMPERATURA: ',num2str(itemp)])
              
        jj = 1;
        while jj <= niters %Loop para cada temperatura
            %disp(['       Ponto: ',num2str(jj)])
                
            %Nova configuração
            xreturn = shake(nvars,x,temp, xlower, xupper);
            ncalls = ncalls+1;
                
            E1 = evalcosf(xreturn); 
            dE = E1-E0; %variação da função objetivo (função energia)
                
            if dE <= 0
                %Teste para aumentar o número de buscas caso haja melhora 
                %na função objetivo na iteração jj da temperatura itemp.
                jj = max(0,jj-setback);
                
                x = xreturn; %Aceita a nova configuração
                E0 = E1;
                if E1<fbest
                    fbest = E1;
                    xbest = xreturn; %Atualiza o ponto ótimo
                    ibest = ibest+1;
                    
                    bestx(ibest,:) = xbest(1,:);
                    bestfunction(ibest) = fbest;
                end
                 
            elseif dE > 0
                pfval = exp((-dE)/kb*temp);
                prand = rand;
                if prand < pfval 
                    iaceit = iaceit+1;                   
                    x = xreturn; %Aceite a configuração
                    E0 = E1;
                end
            end
            
            jj = jj+1;
            
            %==============================================================
            %          Critérios de convergência
            %==============================================================
            if(ibest>nepsilon)
                df = bestfunction(ibest-nepsilon)-bestfunction(ibest);
                if df <= fquit        %Atendida a tolerância
                    %disp('Parada pela tolerância da função objetivo')
                    return
                end
            end
            
            if ncalls >= maxcalls %número máximo de avaliações da f. obj.
                %disp('Parada pelo número de pontos visitados')
                return
            end
            %==============================================================
            %==============================================================
        end             
                                 
        temp=rt*temp; %Atualição da temperatura
        
    end
    
end

