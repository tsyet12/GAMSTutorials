function [P,r,S,A] = SDPrandomPrEx2
% (c) jskl UoM
%
% SDPrandomPrEx2 returns arrays P and r for the Tijms maintenance problem example
%
% Arguments: none
%
% Returns:
% P = array TPM of transition probabilities p(i,j,a) ! note a as 3rd index !
% r = array TRM of immediate rewards r(i,j,a) ! note a as 3rd index !
% S = number of states (states numbered 1..S)
% A = number of actions in each state (actions numbered 1..A)
%
P(:,:,1)=[.9 .1 0 0 0 0;0 .8 .1 .05 .05 0;0 0 .7 .1 .2 0;0 0 0 .5 .5 0;0 0 0 0 0 0;0 0 0 0 0 0];
P(:,:,2)=zeros(6,6);
 P(2,1,2)=1;
 P(3,1,2)=1;
 P(4,1,2)=1;
P(:,:,3)=zeros(6,6);
 P(5,6,3)=1;
 P(6,1,3)=1;
r(:,:,1)=zeros(6,6);
r(:,:,2)=zeros(6,6);
 r(2,1,2)=7;
 r(3,1,2)=7;
 r(4,1,2)=5;
r(:,:,3)=zeros(6,6);
 r(5,6,3)=10;
S = 6;
A = 3;
