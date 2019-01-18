function y = bananaR4(x)
%
% Function made of 2 bananas + sin + cos
%
y = 100*(x(2) - x(1)^2)^2 + (1-x(1))^2 + 100*(x(4) - x(3)^2)^2 + (1-x(3))^2 + sin(x(1)) + cos(x(2));
