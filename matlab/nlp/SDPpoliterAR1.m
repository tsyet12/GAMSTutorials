function [mu,rho,h,iter,time,ri,Pmu,rr] = SDPpoliterAR1(S,A,P,r)
% (c) jskl UoM
%
% SDPpoliterAR1 implements the policy iteration algorithm to find an optimal policy for AVERAGE REWARD case
% Version 1: same set of actions for all states
%
% Arguments:
% S = number of states (states numbered 1..S)
% A = number of actions in each state (actions numbered 1..A)
%     We assume same numbers. If less, make extra rewards and transition probabilities zero
% P = array TPM of transition probabilities p(i,j,a) ! note a as 3rd index !
% r = array TRM of immediate rewards r(i,j,a) ! note a as 3rd index !
%     for minimization (r are costs), call the function with -r
%
% Returns:
% mu = optimal policy
% rho = optimal average reward
% h = optimal value function vector
% iter = number of iterations performed
% time = CPU time needed
% ri = expected rewards for optimal policy
% Pmu = TPM for optimal policy
% rr = expected immediate rewards rr(i,a)
%
% To prepare arguments use function SDPrandomPr
%
time = cputime;
rr = zeros(S,A);                    % preallocations
ri = zeros(S,1);
Pmu = zeros(S,S);
y = zeros(A,1);
mu = ones(S,1);                     % initial mu(i) = 1
for i=1:S                           % for all states i
   for a=1:A                        % for all actions a
      rr(i,a) = P(i,:,a)*r(i,:,a)'; % expected immediate rewards
   end
end
iter = 0;
improved = 1;                       % flag whether improvement happened
while improved == 1
   iter = iter+1;
   improved = 0;
   for i=1:S                        % for all states i
      ri(i) = rr(i,mu(i));          % expected rewards for given policy
      for j=1:S                     % for all states i
         Pmu(i,j) = P(i,j,mu(i));   % TPM for given policy
      end
   end
   Q = Pmu - eye(S);
   h = [Q(:,1:S-1) -ones(S,1)]\(-ri);   % computing h, h(S)=rho
   rho = h(S);
   h(S) = 0;
   for i=1:S                        % for all states i
      for a=1:A                     % for all actions a
         y(a) = rr(i,a) + P(i,:,a)*h;    % value to be maximized
      end
      [x newmui] = max(y);          % maximization
      if x>y(mu(i))                 % improvement ?
         improved = 1;
         mu(i) = newmui;            % updating policy if improvement
      end
   end
end
time = cputime - time;
