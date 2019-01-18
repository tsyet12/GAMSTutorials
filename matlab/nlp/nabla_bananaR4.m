function y = nabla_bananaR4(x)
%
% Gradient of function made of 2 bananas + sin + cos
%
y = [-400*(x(2)-x(1)^2)*x(1) - 2*(1-x(1)) + cos(x(1)); 200*(x(2)-x(1)^2) - sin(x(2)); -400*(x(4)-x(3)^2)*x(3) - 2*(1-x(3)); 200*(x(4)-x(3)^2)];
