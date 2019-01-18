function g = nabla_ex_cycBS(x)
%
% Gradient of example function B&S, xmin = [2 1]
%
% y = (x(1) - 2)^4 + (x(1) - 2*x(2))^2;
g = [4*(x(1) - 2)^3 + 2*(x(1) - 2*x(2)); -4*(x(1) - 2*x(2))];