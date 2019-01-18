function [c,ceq] = g(x)
c = x(2) - exp(-x(1));
ceq = x(4) - 5 - (x(3) - 3)^2;
