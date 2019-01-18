function [lossp] = erlangp(c,r)
%
% erlangp(c,r) computes the loss probability
% for the M/M/c/c system with utilization r
% uses poisspdf and poisscdf of Matlab
%
lossp = poisspdf(c,r)/poisscdf(c,r);

