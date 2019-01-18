function [c,pi] = finds(r,p,n)
%
% finds(r,p,n) finds the necessary number of channels c
% for the M/M/c/c system with utilization r and loss
% probability p. n = starting number
% erlangp(c,r) is used to compute the loss probability
%
pi = erlangp(n,r);
i = n;
while pi > p        % brutal force slow algorithm !
   i = i+1;
   pi = erlangp(i,r);
end
c = i;

