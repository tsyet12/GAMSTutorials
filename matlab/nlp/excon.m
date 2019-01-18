function [c,ceq] = excon(x)
   c = [x(1)^2 + x(2) - 5; 1/4*(x(1)+1)^2 - x(2)];
   ceq = x(1)^3 - x(2);
