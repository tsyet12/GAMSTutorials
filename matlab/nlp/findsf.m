function [c,pi] = findsf(r,p,n)
%
% findsf(r,p,n) finds the necessary number of channels c
% for the M/M/c/c system with utilization r and loss
% probability p. n = starting number
% erlangpdf(r,c) is used to compute the loss probability
%
pi = erlangpdf(r,n);
i = n;
while pi > p        % brutal force slow algorithm !
   i = i+1;
   pi = erlangpdf(r,i);
end
c = i;

