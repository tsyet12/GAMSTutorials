function [c,ceq] = gcon(x,S)
c = x'*S*x - 70000;
ceq = [];
