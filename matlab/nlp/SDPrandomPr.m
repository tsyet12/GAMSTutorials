function [P,r,S,A,time] = SDPrandomPr(s,ac,mr)
% (c) jskl UoM
%
% SDPrandomPr returns randomly generated arrays P and r
%
% Arguments:
% s = number of states (states numbered 1..s)
% ac = number of actions in each state (actions numbered 1..ac) we assume
%      same numbers
% mr = maximum reward - all rewards random uniform in (0,mr)
%
% Returns:
% P = array TPM of transition probabilities p(i,j,a) ! note a as 3rd index !
% r = array TRM of immediate rewards r(i,j,a) ! note a as 3rd index !
% S = number of states (states numbered 1..S)
% A = number of actions in each state (actions numbered 1..A)
% time = CPU time needed
%
time = cputime;
P = eye(s);                         % If P,r existed already
r = eye(s);
for a=1:ac                          % for all actions a
   r(:,:,a) = mr*rand(s,s);         % random rewards in (0,mr)
   x = rand(s,s);                   % random entries in (0,1)
   su = sum(x);                     % sums in columns
   for i=1:s
      x(:,i) = x(:,i)/su(i);        % normalized columns
   end
   P(:,:,a) = x';                   % normalized probabilities in rows
end
S = s;
A = ac;
time = cputime - time;
