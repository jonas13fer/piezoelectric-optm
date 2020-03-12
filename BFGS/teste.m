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
% Ponto inicial
x0=[0.2638,.3362,.1638,.2362];
vlb=[0.0,0.04,0.0,0.02]';      %lower bounds

fprintf('\n')
disp('BFGS METHOD')
fprintf('\n')

tic
[x] = BFGS(evalcosf,x0,20, 0.0001, 0,1 ,20);

fprintf('\n')
disp ('==================================================================')
%disp(['Variaveis de projeto  ',num2str(xo)])
%disp(['Funcao Objetivo = ',num2str(Ot)])
%disp(['Número de pontos visitados = ', num2str(nS)])
toc;
