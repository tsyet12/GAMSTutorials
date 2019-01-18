function H = H_ex_cycBS(x)
%
% Hessian of example function B&S, xmin = [2 1]
%
% y = (x(1) - 2)^4 + (x(1) - 2*x(2))^2;
%
% g = [4*(x(1) - 2)^3 + 2*(x(1) - 2*x(2)); -4*(x(1) - 2*x(2))];
H = [12*(x(1) - 2)^2 + 2*x(1)  -4; -4  8];