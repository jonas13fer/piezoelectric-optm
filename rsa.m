%% Random Search Algorithm (Pure Random Search Algorithm)
% by : Jonas F. Oliveira (jonasferoliveira.ufg@gmail.com)
% 05/06/2019
% The RSA is the simplest algorithm to solve optimization problem
% it is not efficient and it sometimes cannot solve the problem


clc
close all
clear all
dim=4;
popsize=100;
ftarget=0.01;
numIter=100;
ObjFun=@let_a

for i=1:numIter
    candidate=10*rand(dim,popsize)-5;
    best=min(feval(ObjFun,candidate));
    if best <= ftarget
        break;
    end
end
disp(best);
