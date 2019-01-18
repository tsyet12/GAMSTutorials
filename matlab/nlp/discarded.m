function [d] = discarded(mu,N)
%
% Queueing Theory I, Worksheet #1, Problem 3b
%
% Input:
% mu = selling rate (dozens per day)
% N = initial stock (dozens)
%
% Returns:
% d = average number of discarded dozens at the end
%     of the week
%
% Example use:
% d = discarded(3,18)
%
lambda = mu*7;
d=0;
for i=1:N
   d = d + i*poisspdf(N-i,lambda);
end
