function H = H_ex_grad(x,a,b,c)
%
% Hessian of the example function for Newton search
%
% y = a*x*x + b*y*y + c*x*y
%
% g = [2*a*x(1) + c*x(2); 2*b*x(2) + c*x(1)];
H = [2*a  c; c  2*b];