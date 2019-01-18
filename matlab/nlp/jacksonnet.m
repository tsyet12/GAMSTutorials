function [Li,LQi,Wi,WQi,roi,lambdai,vi,L,LQ,W,WQ,p0,pbusy,marginal] = jacksonnet(r,R,mu,lambda,n)
% (c) jskl UoM
%
% jacksonnet solves stable open Jackson networks with single channel stations
%
% Arguments:
% r = distribution of arrivals [r(i)=probability of arriving to station i](k vector)
% R = probability of movements [R(i,j)=probability of moving from i to j](kxk matrix)
% mu = service rates (k vector)
% lambda = arrival rate (scalar)
% n = maximal marginal probability required (n >= 0)
%
% Returns k vectors [Li,LQi,Wi,WQi,roi,lambdai,vi] where:
% Li = mean system sizes
% LQi = mean queue lengths
% Wi = mean system times
% WQi = mean queue waits
% roi = traffic rates (utilization of servers)
% lambdai = effective arrival rates
% vi = expected numbers of visits (solution to traffic equations)
%
% scalars [L,LQ,W,WQ,p0,pbusy] where
% L = total mean system size (number in network)
% LQ = total mean number of waiting items
% W = total mean time spent in the network
% WQ = total mean waiting time
% p0 = probability of empty network
% pbusy = probability that all nodes are busy
%
% (n+1) x k matrix
% marginal = marginal probabilities p0 - pn in columns
%
% Example use generally: 
% [Li,LQi,Wi,WQi,roi,lambdai,vi,L,LQ,W,WQ,p0,pbusy,marginal] = jacksonnet(r,R,mu,lambda,n)
%
% Example use (lectures example): 
% [Li,LQi,Wi,WQi,roi,lambdai,vi,L,LQ,W,WQ,p0,pbusy,marginal] = jacksonnet([0.6 0.4]',[0.3 0.5;0.4 0.2],[1/4 1/3]',1/10,10)
%
k=length(r);               % k = number of stations
vi=(eye(k)-R')\r;          % solving traffic equations
roi=lambda*(vi./mu);       % traffic rates
Li=roi./(ones(k,1)-roi);   % system sizes
lambdai=lambda*vi;         % arrival rates
Wi=Li./lambdai;            % system waits
WQi=Wi-(ones(k,1)./mu);    % queue waits
LQi=WQi.*lambdai;          % queue lengths
L=sum(Li);                 % total system size
LQ=sum(LQi);               % total number of waiting
W=vi'*Wi;                  % total time spent in network
WQ=vi'*WQi;                % total waiting time
p0=prod(ones(k,1)-roi);    % probability of empty network
pbusy=prod(roi);           % probability that all nodes are busy
for i=1:n+1
   for j=1:k
      marginal(i,j) = (1 - roi(j))*roi(j)^(i-1);
   end
end