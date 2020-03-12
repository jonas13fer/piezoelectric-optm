
function main

% Bacterial Foraging Optimization Algorithm

% Implemented by Borges, R. A.
% version 1.0 - 22/03/2010
%Modificado por Romes A. Borges/ Janeiro de 2011
%Version 2.0
%small modification in 09 de Julho de 2015
%Version 2.1

clc
clear all
clear global
close all
format long

bf.D=4;                         
% dimension of search space 

vlb=[0.0 0.04 0.0 0.02];    %lower bounds
vub=[0.56 .60 0.38 .40];    %upper bounds

bf.Xmin=vlb;                     
% inferior limite 

bf.Xmax=vub;                     
% superior limite

bf.NP=100;                       
% The number of bacteria - population size

bf.Nc=10;                      
% Number of chemotactic steps 

bf.Ns=4;                        
% Limits the length of a swim 

bf.Nre=20;                      
% The number of reproduction steps 

bf.Ned=2;                       
% The number of elimination-dispersal events 

bf.Sr=bf.NP/2;                  
% The number of bacteria reproductions (splits) per generation 

bf.Ped=0.25;                    
% The probabilty that each bacteria will be eliminated/dispersed 

caux=rand(bf.NP,1);
bf.C(:,1)=0.025*caux/(max(caux));       
% the run length  

bf.par=[];
% parameter values

nvezes=6;
% execution number

for ijk=1:nvezes
  ijk  
  clear initial_time  final_time
  initial_time = cputime;   
  [X,FO,NF]=bacterial_foraging('let_a',bf);
  final_time = cputime-initial_time;
  results(ijk,:)=[X' FO NF final_time];   
end

results;

aux_org=sort(results(:,bf.D+1))

clear i j rescomp

for i=1:nvezes
 for j=1:round(nvezes/2)
   if results(i,bf.D+1)==aux_org(j) 
     rescomp(j,:)=results(i,:);  
   end
 end  
end

rescomp;

[xa,xb]=size(rescomp);

resultsf=[rescomp(round(nvezes/2),:);mean(rescomp);rescomp(1,:)];

resultsfa=[rescomp(round(nvezes/2),bf.D+1:xb);mean(rescomp(:,bf.D+1:xb));rescomp(1,bf.D+1:xb)];

save result_comp.txt resultsf -ASCII
save result_obj.txt resultsfa -ASCII

open result_comp.txt
open result_obj.txt
 

% load feval_process.txt
% open feval_process.txt
% fes = feval_process;
% 
% figure(1)
% stairs(fes(:,1),fes(:,2),'b-')
% xlabel('Ns*Nc')
% ylabel('Objective function')

