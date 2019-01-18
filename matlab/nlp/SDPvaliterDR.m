function [mu,J,iter,time,rr] = SDPvaliterDR(S,A,P,r,lambda,epsilon)
% (c) jskl UoM
%
% SDPvaliterDR inplements the value iteration algorithm to find an optimal policy for DISCOUNTED REWARDS case
% Asynchronous (Gauss Seidel) version - uses already updated J's
%
% Arguments:
% S = number of states (states numbered 1..S)
% A = number of actions in each state (actions numbered 1..A)
%     We assume same numbers. If less, make extra rewards and transition probabilities zero
% P = array TPM of transition probabilities p(i,j,a) ! note a as 3rd index !
% r = array TRM of immediate rewards r(i,j,a) ! note a as 3rd index !
% lambda = discounting factor = 1/(1+interest_rate)
% epsilon = precision, ||.||inf norm used
%
% Returns:
% mu = optimal policy
% J = optimal value function vector
% iter = number of iterations performed
% time = CPU time needed
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
d = 0.5*epsilon*(1-lambda)/lambda;  % norm limit
nrm = d+1;                          % initial norm > d
iter = 0;
while nrm > d
   iter = iter+1;
   K = J;                           % old value functions
   for i=1:S                        % for all states i
      for a=1:A                     % for all actions a
         y(a) = rr(i,a) + lambda*(P(i,:,a)*J);    % value to be maximized
      end
      [J(i) mu(i)] = max(y);        % updating value vector and policy
   end
   nrm = norm(J - K,inf);           % ||.||inf norm
end
for i=1:S                           % for all states i compute the final result
   for a=1:A                        % for all actions a
      y(a) = rr(i,a) + lambda*(P(i,:,a)*J);       % value to be maximized
   end
   [x mu(i)] = max(y);              % finding optimal policy
end
mu = mu';
time = cputime - time;
