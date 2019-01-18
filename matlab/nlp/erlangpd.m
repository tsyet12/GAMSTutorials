function [lossp] = erlangpd(r,c)
%
% erlangpd(r,c) computes the loss probability
% for the M/M/c/c system with utilization r
% does not use poisspdf of Matlab
%
up = 1;        
for i=1:c
   up=up*r/i;
end
down = 1;       % first term for i=0
for i=1:c
   d = 1;
   for j=1:i
      d=d*r/j;
   end
   down = down + d;
end
lossp = up/down;

