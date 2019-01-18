function [g] = seattomin_grad(x)
%
% Gradient of the 'seat' example function for gradient search
%
g(1) = 6*x(1)*x(1) + x(2)*x(2) + 10*x(1);
g(2) = 2*x(1)*x(2) + 2*x(2);
