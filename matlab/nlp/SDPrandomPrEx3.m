function [P,r,S,A] = SDPrandomPrEx3(alpha,beta,Rs,Rw,Pen)
% (c) jskl UoM
%
% SDPrandomPrEx3 returns arrays P and r for the recycling robot example
%
% Arguments: none
% alpha = probability to stay in high status
% beta = probability to stay in low status (otherwise penalty and move to high)
% Rs = mean number of cans found if search
% Rw = mean number of cans obtained if wait
% P = recharging penalty
%
% Returns:
% P = array TPM of transition probabilities p(i,j,a) ! note a as 3rd index !
% r = array TRM of immediate rewards r(i,j,a) ! note a as 3rd index !
% S = number of states (states numbered 1..S)
% A = number of actions in each state (actions numbered 1..A)
%
P(:,:,1)=[alpha  1-alpha;1-beta  beta];
P(:,:,2)=[1 0;0 1];
P(:,:,3)=[0 0;1 0];
r(:,:,1)=[Rs Rs; -Pen Rs];
r(:,:,2)=[Rw 0;0 Rw];
r(:,:,3)=[0 0;0 0];
S = 2;
A = 3;
