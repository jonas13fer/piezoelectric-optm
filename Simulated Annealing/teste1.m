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

clear all
clc
                 
evalcosf = @let_a; %função objetivo

% Limites laterais das variáveis de projeto
vlb=[0.0 0.04 0.0 0.02];      %lower bounds
vub=[0.56 .60 0.38 .40];    %upper bounds

xlower = vlb;
xupper = vub;    

% Ponto inicial
x0 = xlower+(xupper-xlower).*rand(size(xlower));
%x0=[0.2638,.3362,.1638,.2362];

% %Critério 1 para temperatura inicial
%starttemp = abs(log(abs(evalcosf(x0))));

%Critério 2 para temperatura inicial
E0 = evalcosf(x0);
starttemp = 0;
for ii = 1:10
    x = xlower+(xupper-xlower).*rand(size(xlower));
    dE = evalcosf(x)-E0;
    starttemp = max(starttemp,dE);
end

stoptemp = .001;                
ntemps = 10;

fprintf('\n')
disp('SIMULATED ANNEALING')
fprintf('\n')


tic
[fbest, xbest, ncalls, iaceit, ibest] = simannealing(evalcosf, ....
    x0, xlower, xupper, starttemp,stoptemp, ntemps);


fprintf('\n')
disp ('==================================================================')
disp(['Variaveis de projeto  ',num2str(xbest)])
disp(['Funcao Objetivo = ',num2str(fbest)])
disp(['Número de pontos visitados = ', num2str(ncalls)])
disp(['Número de pontos aceitos =  ',num2str(iaceit)])
disp(['Número de pontos melhorados =   ',num2str(ibest)])
toc;
