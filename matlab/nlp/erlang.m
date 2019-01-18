function [lossp] = erlang(rho,c)
% (c) jskl UoM
%
% erlang(rho,s) computes the loss probability
% for the M/G/c/c system with utilization rho.
% Fast version, does not use poisspdf of Matlab.
%
% Example use: pc = erlang(rho,c)
%
down = 1;       % first term for i=0
d = 1;
for i=1:c
   d=d*rho/i;   % terms in sum differ by rho/i
   down = down + d;
end
lossp = d/down; % last term is the numerator
