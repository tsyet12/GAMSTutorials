function [P,r,S,A] = SDPrandomPrEx
% (c) jskl UoM
%
% SDPrandomPrEx returns arrays P and r for the book example A
%
% Arguments: none
%
% Returns:
% P = array TPM of transition probabilities p(i,j,a) ! note a as 3rd index !
% r = array TRM of immediate rewards r(i,j,a) ! note a as 3rd index !
% S = number of states (states numbered 1..S)
% A = number of actions in each state (actions numbered 1..A)
%
P(:,:,1)=[.7 .3;.4 .6];
P(:,:,2)=[.9 .1;.2 .8];
r(:,:,1)=[6 -5;7 12];
r(:,:,2)=[10 17;-14 13];
S = 2;
A = 2;
