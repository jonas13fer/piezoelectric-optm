% ======================================================== % 
% Files of the Matlab programs included in the book:       %
% Xin-She Yang, Nature-Inspired Metaheuristic Algorithms,  %
% Second Edition, Luniver Press, (2010).   www.luniver.com %
% ======================================================== %    
% Modified by Jonas Oliveira

function main

clc
clear all
close all
format long

evalcosf = @let_a; %função objetivo

vlb=[0.0 0.04 0.0 0.02];      %lower bounds
vub=[0.56 .60 0.38 .40];    %upper bounds

D=4;
XVmin=vlb;
XVmax=vub;

NP=100;  
MaxGeneration=10000;
alpha=0.5; 
betamin=0.2; 
gamma=1;
y=[];
semente=0;
rand('seed',semente);

[x,fval,NumEval]=firefly_algorithm(evalcosf,D,NP,MaxGeneration,alpha,betamin,gamma,XVmin,XVmax,y);

