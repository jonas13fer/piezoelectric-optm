% FMINCON Finds a constrained minimum of a function of several variables.

% min F(X) subject to: A*X <= B, Aeq*X = Beq (linear constraints)
% X C(X)<= 0, Ceq(X) = 0 (nonlinear constraints)
% LB <= X <= UB (lower and upper bounds)
 % Entrada: FMINCON(FUN,X0,A,B,Aeq,Beq,LB,UB,NONLCON,OPTIONS,P1,P2,...)
 % NONLCON: accepts X and returns the vectors C and Ceq, representing the
 % nonlinear inequalities and equalities respectively. FMINCON minimizes
 % FUN such that C(X)<=0 and Ceq(X)=0.
clear all
clc
 % Saida: [X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN]: id?ntico ? otimiza??o sem restri??es

 % Mostra na tela os parametros da otimiza?ao ao longo das itera?oes e a solu?ao final
 options = optimset('LargeScale','off');
 options = optimset(options,'display','iter');
 % Step 1: Write an M-file confun.m for the constraints: porque as
 % restri?oes sao nao-lineares. Caso fossem lineares, bastaria entrar com
 % A e B (desigualdade) ou Aeq e Beq (igualdade)

% Fun?ao objetivo
 %fun = 'exp(x(1))*(4*x(1)^2+2*x(2)^2+4*x(1)*x(2)+2*x(2)+1)';

 % Ponto de partida
%x0 = [-1,1];
 
x0=[0.2638,.3362,.1638,.2362];   %initial guess at the solution
%options.InitialPopulationMatrix = x0;

%x0=[0.0,.0,.0,.0];
%GEOMETRIA FIXA
%vlb=[0.,0.0724,0.,0.0724];      %lower bounds
%vub=[0.5276,.60,0.3276,.40];    %upper bounds

%GEOMETRIA VARI?VEL
vlb=[0.0,0.04,0.0,0.02];      %lower bounds
vub=[0.56,.60,0.38,.40];    %upper bounds
%options(12)=4;    %there are 2 equality constraints
 A = [1 -1 0 0; 0 0 1 -1; -1 1 0 0;0 0 -1 1];
 b = [-0.04 -0.02 0.15 0.10];
 nvars=4;
 % Invoke constrained optimization routine
%tic
%[x, fval,exitflag,output] = fmincon('let_a',x0,A,b,[],[],vlb,vub,@confun,options);
%toc
tic 
[x,fval,exitflag,output,population,scores] = ga(@let_a,nvars,A,b,[],[],vlb,vub,@confun);
toc