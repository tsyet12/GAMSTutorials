function g = nabla_ex_grad(x,a,b,c)
%
% Gradient of the example function for gradient search
%
% y = a*x*x + b*y*y + c*x*y
%
g = [2*a*x(1) + c*x(2); 2*b*x(2) + c*x(1)];

