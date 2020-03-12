function [c, ceq] = confun(x)

% Nonlinear inequality constraints
%%%%%%%%%%%%% c = [1.5 + x(1)*x(2) - x(1) - x(2); -x(1)*x(2) - 10];

c = [x(1)^2 + x(2)^2 + x(3)^2 + x(4)^2 + x(1) - x(2) + x(3) - x(4) - 100;  x(1)^2 + 2*x(2)^2 + x(3)^2 + 2*x(4)^2 - x(1) - x(4) - 10; 2*x(1)^2 + x(2)^2 + x(3)^2 + 2*x(1)-x(2) - x(4) - 5]
 % Nonlinear equality constraints
 ceq = [];

