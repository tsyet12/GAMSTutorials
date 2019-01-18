function [lossp] = erlangpdf(r,c)
%
% erlangpdf(r,c) computes the loss probability
% for the M/M/c/c system with utilization r
% does not use poisspdf of Matlab
% fast version
%
down = 1;       % first term for i=0
d = 1;
for i=1:c
   d=d*r/i;     % terms in sum differ by r/i
   down = down + d;
end
lossp = d/down; % last term is the numerator

