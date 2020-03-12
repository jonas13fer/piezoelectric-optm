% Modified by Jonas Oliveira

function main

clc
clear all
clear global
close all
format long
%
vlb=[0.0 0.04 0.0 0.02];      %lower bounds
vub=[0.56 .60 0.38 .40];    %upper bounds

initial_time = cputime; 
bee_alg.VTR = 1.e-10; 
bee_alg.D = 4; 
bee_alg.XVmin = vlb; 
bee_alg.XVmax = vub;
bee_alg.y=[]; 
bee_alg.n= 20;      % number of scout bees (e.g. 40-100)
bee_alg.iter=100;   % number of iterations (e.g. 1000-5000)
bee_alg.m=10;       % number of best selected patches (e.g. 10-50)
bee_alg.e=5;       % number of elite selected patches (e.g. 10-50)
bee_alg.n1=10;      % number of recruited bees around best selected patches (e.g. 10-50)
bee_alg.n2=5;      % number of recruited bees around elite selected patches (e.g. 10-50)
bee_alg.ngh=0.001;  % Patch radius for neighbourhood search
bee_alg.ref=1;  

%
[X,FO,NF]=bee_algorithm('let_a',bee_alg)
%
final_time = 1/60*(cputime-initial_time);
fprintf(1,'  time of execution (in minutes) = %f\n',final_time);

load evol_process.txt
evolprocess=evol_process;

figure(1)
stairs(evolprocess(:,1),evolprocess(:,2),'b-')
