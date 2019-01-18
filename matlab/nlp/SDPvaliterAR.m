function [mu,rho,J,h,iter,time,ri,Pmu,rr] = SDPvaliterAR(S,A,P,r,epsilon)
% (c) jskl UoM
%
% SDPvaliterAR inplements the RELATIVE value iteration algorithm to find an optimal policy for AVERAGE REWARD case
%
% Arguments:
% S = number of states (states numbered 1..S)
% A = number of actions in each state (actions numbered 1..A)
%     We assume same numbers. If less, make extra rewards and transition probabilities zero
% P = array TPM of transition probabilities p(i,j,a) ! note a as 3rd index !
% r = array TRM of immediate rewards r(i,j,a) ! note a as 3rd index !
% epsilon = precision, span seminorm used
%
% Returns:
% mu = optimal policy
% rho = optimal average reward
% J = optimal value function vector from value iteration
% h = optimal value function vector from final computation of rho (policy evaluation)
% iter = number of iterations performed
% time = CPU time needed
% ri = expected rewards for optimal policy
% Pmu = TPM for optimal policy
% rr = expected immediate rewards rr(i,a)
%
% To prepare arguments use function SDPrandomPr
%
time = cputime;
J = zeros(S,1);                     % J(i) = 0
for i=1:S                           % for all states i
   for a=1:A                        % for all actions a
      rr(i,a) = P(i,:,a)*r(i,:,a)'; % expected immediate rewards
   end
end
nrm = epsilon+1;                    % initial norm > epsilon
iter = 0;
while nrm >= epsilon
   iter = iter+1;
   K = J;                           % old value functions
   for a=1:A                        % for all actions a, distinguished state i* = 1
      y(a) = rr(1,a) + P(1,:,a)*K;  % value to be maximized
   end
   [x mu(1)] = max(y);              % updating value vector and policy for i*
   for i=2:S                        % for all remaining states i
      for a=1:A                     % for all actions a
         y(a) = rr(i,a) + P(i,:,a)*K;    % value to be maximized
      end
      [J(i) mu(i)] = max(y);        % updating value vector and policy
      J(i) = J(i) - x;              % states relative to state 1
   end
   J(1) = 0;
   nrm = max(J-K) - min(J-K);       % span seminorm
end
for i=1:S                           % for all states i compute final result
   for a=1:A                        % for all actions a
      y(a) = rr(i,a) + P(i,:,a)*J;  % value to be maximized
   end
   [x mu(i)] = max(y);              % finding optimal policy
end
mu = mu';                           % computing rho and h:
for i=1:S                           % for all states i
   ri(i) = rr(i,mu(i));             % expected rewards for given policy
   for j=1:S                        % for all states i
      Pmu(i,j) = P(i,j,mu(i));      % TPM for given policy
   end
end
Q = Pmu - eye(S);
h = [Q(:,1:S-1) -ones(S,1)]\(-ri'); % computing h, h(S)=rho
rho = h(S);
h(S) = 0;
time = cputime - time;
