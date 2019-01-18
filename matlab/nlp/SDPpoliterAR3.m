function [mu,rho,h,iter,time,ri,Pmu,rr] = SDPpoliterAR3(S,A,P,r,f)
% (c) jskl UoM
%
% SDPpoliterAR3 implements the policy iteration algorithm to find an optimal policy for AVERAGE REWARD case
% Version 3: various sets of actions. Function f returns the set of possible actions for state i,
%            transition probabilities P and rewards r are functions. Use if matrices are sparse.
%
% Arguments:
% S = number of states (states numbered 1..S)
% A = total number of possible actions (actions numbered 1..A)
% P = function that returns the transition probabilities p(i,j,a)
% r = function that returns the immediate rewards r(i,j,a)
%     for minimization (r are costs), call the function with -r
% f = function that returns the set (vector) of actions for given state
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
% Example use for Ex2:
% [mu,rho,h,iter,time,ri,Pmu,rr] = SDPpoliterAR3(6,3,@SDPP2,@SDPr2,@SDPa2)
%
time = cputime;
mu = zeros(S,1);                    % preallocations
rr = zeros(S,A);
ri = zeros(S,1);
Pmu = zeros(S,S);
for i=1:S                           % for all states i
   ai = f(i);                       % actions for state i
   mu(i) = ai(1);                   % initial mu(i) = 1st action
   for a=1:A                        % for all actions a
      rr(i,a) = 0;
      for j=1:S
         rr(i,a) = rr(i,a) + P(i,j,a)*r(i,j,a); % expected immediate rewards (even if not used)
      end
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
      ai = f(i);                    % actions for state i
      ain = length(ai);             % and their number
      y = zeros(ain,1);
      for a=1:ain                   % for all actions a
         y(a) = rr(i,ai(a));
         for j=1:S
             y(a) = y(a) + P(i,j,ai(a))*h(j);    % value to be maximized
         end
      end
      [x newmui] = max(y);          % maximization
      j = logical(ai==mu(i));       % position of so far best action in ai
      if x>y(j)                     % improvement ?
         improved = 1;
         mu(i) = newmui;            % updating policy if improvement
      end
   end
end
time = cputime - time;
