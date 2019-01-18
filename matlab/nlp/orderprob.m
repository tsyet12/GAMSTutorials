function [p] = orderprob(mu,N)
%
% Queueing Theory I, Worksheet #1, Problem 3a
%
% Input:
% mu = seling rate (dozens per day)
% N = initial stock (dozens)
%
% Returns:
% p = array of probabilities of placing an order
%     at the end of the days 1 - 7
%
% Example use:
% probs = orderprob(3,18)
%
for t=1:7
 lambda = mu*t;
 for i=1:18
  pn(i)=poisspdf(N-i,lambda);
 end
 p0=1-sum(pn);
 p(t)=p0+sum(pn(1:5));
end