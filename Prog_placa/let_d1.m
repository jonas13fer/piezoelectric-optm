%----------------------------------------------------------------%
%Romes A. Borges
%Rectangular plates
%Smart Structure
%----------------------------------------------------------------%
%Program for calling the objective function- Optimization
%The objective function is created in plateotim1.m
%-----------------------------------------------------
%DATA FOR CONFIG. 1
%x=[0.2638,.3362,.1638,.2362];        %initial guess at the solution
vlb=[0.,0.0724,0.,0.0724];      %lower bounds
vub=[0.5276,.60,0.3276,.40];      %upper bounds
options(13)=2;    %there are 2 equality constraints
%
%DATA FOR CONFIG. 2
%x=[0.,.0724;.3638,.4];          %initial guess at the solution
%
%DATA FOR CONFIG. 3
x=[0.5276,.6;0.,0.0724];          %initial guess at the solution
%
x=constr('let_d',x,options,vlb,vub);    %%%%plateotim1
