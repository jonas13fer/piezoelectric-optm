%==========================================================================                                                                          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
%                                                                         % 
%       UNIVERSIDADE FEDERAL DE GOIÁS                                     %  
%       IMTec - UFG  - PPGMO                                              %
%                                                                         %
%       IMPLEMENTAÇAO DA TECNICA DE OTIMIZAÇAO "POWELL METHOD"            %
%                                       
%                                                     
%                       Jonas Oliveira                                    %
%                                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

clear all
clc
                 
evalcosf = @let_a; %função objetivo

% Limites laterais das variáveis de projeto
vlb=[0.0 0.04 0.0 0.02];      %lower bounds
vub=[0.56 .60 0.38 .40];    %upper bounds


% Ponto inicial
x0=[0.2638,.3362,.1638,.2362]';


fprintf('\n')
disp('POWELLs METHOD')
fprintf('\n')

tic
[xo,Ot,nS]=powell(evalcosf,x0,0,0,vlb,vub,-1,1e-8,'default');


fprintf('\n')
disp ('==================================================================')
%disp(['Variaveis de projeto  ',num2str(xo)])
disp(['Funcao Objetivo = ',num2str(Ot)])
disp(['Número de pontos visitados = ', num2str(nS)])
toc;
