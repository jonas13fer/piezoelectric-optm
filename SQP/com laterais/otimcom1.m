% FMINCON Finds a constrained minimum of a function of several variables.

% min F(X) subject to: A*X <= B, Aeq*X = Beq (linear constraints)
% X C(X)<= 0, Ceq(X) = 0 (nonlinear constraints)
% LB <= X <= UB (lower and upper bounds)
 % Entrada: FMINCON(FUN,X0,A,B,Aeq,Beq,LB,UB,NONLCON,OPTIONS,P1,P2,...)
 % NONLCON: accepts X and returns the vectors C and Ceq, representing the
 % nonlinear inequalities and equalities respectively. FMINCON minimizes
 % FUN such that C(X)<=0 and Ceq(X)=0.

 % Saida: [X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN]: idêntico à otimização sem restrições

 % Mostra na tela os parametros da otimizaçao ao longo das iteraçoes e a soluçao final
 options = optimset('LargeScale','off');
 options = optimset(options,'display','iter');
 % Step 1: Write an M-file confun.m for the constraints: porque as
 % restriçoes sao nao-lineares. Caso fossem lineares, bastaria entrar com
 % A e B (desigualdade) ou Aeq e Beq (igualdade)

% Funçao objetivo
 
%%%%%%%% fun = 'exp(x(1))*(4*x(1)^2+2*x(2)^2+4*x(1)*x(2)+2*x(2)+1)';
fun = 'x(1)^2+x(2)^2+2*x(3)^2- x(4)^2- 5*x(1)-5*x(2)-21*x(3)+ 7*x(4)+100'
 % Ponto de partida
 x0 = [0,0,0,0];
 % Restriçoes laterais (lb <= x <= ub)
 lb = [-100,-100,-100,-100]; % Set lower bounds
 ub = [100,100,100,100 ]; % No upper bounds
 % Invoke constrained optimization routine
[x, fval,exitflag,output] = fmincon(fun,x0,[],[],[],[],[],[],@confun,options)