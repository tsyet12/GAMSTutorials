function y = banana(x)
%
% Rosenbrock narrow valey function, xmin = [1 1], f(xmin) = 0
%
y = 100*(x(2) - x(1)^2)^2 + (1-x(1))^2;