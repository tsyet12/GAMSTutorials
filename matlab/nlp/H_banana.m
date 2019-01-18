function H = H_banana(x)
%
% Hessian of Rosenbrock narrow valey function, xmin = [1 1], zmin = 0
%
% y = 100*(x(2) - x(1)^2)^2 + (1-x(1))^2;
% 
% g = [200*(x(2) - x(1)^2)*(-2*x(1)) - 2*(1-x(1));  200*(x(2) - x(1)^2)];
H = [200*(-2*x(2) + 6*x(1)^2) + 2  -400*x(1); -400*x(1)  200];    