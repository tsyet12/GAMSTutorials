function g = nabla_banana(x)
%
% Gradient of Rosenbrock narrow valey function, xmin = [1 1], zmin = 0
%
% y = 100*(x(2) - x(1)^2)^2 + (1-x(1))^2;
% 
g = [200*(x(2) - x(1)^2)*(-2*x(1)) - 2*(1-x(1));  200*(x(2) - x(1)^2)];