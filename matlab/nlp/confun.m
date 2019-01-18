         function [c,ceq] = confun(x,S,v)
         c = x'*S*x - v;
         ceq = [];
