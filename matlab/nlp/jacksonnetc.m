function [Li,LQi,Wi,WQi,roi,lambdai,vi,L,LQ,W,WQ,p0,pbusy,marginal] = jacksonnetc(r,R,mu,c,lambda,n)
% (c) jskl UoM
%
% jacksonnetc solves stable open Jackson networks with multi channel stations
%
% Arguments:
% r = distribution of arrivals [r(i)=probability of arriving to station i](k vector)
% R = probability of movements [R(i,j)=probability of moving from i to j](kxk matrix)
% mu = service rates (k vector)
% c = numbers of channels (k vector)
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
% [Li,LQi,Wi,WQi,roi,lambdai,vi,L,LQ,W,WQ,p0,pbusy,marginal] = jacksonnetc(r,R,mu,c,lambda,n)
%
% Lectures example: 
% [Li,LQi,Wi,WQi,roi,lambdai,vi,L,LQ,W,WQ,p0,pbusy,marginal] = jacksonnetc([0.6 0.4]',[0.3 0.5;0.4 0.2],[1/4 1/3]',[1 1]',1/10,10)
% G&H (QTS) example:
% [Li,LQi,Wi,WQi,roi,lambdai,vi,L,LQ,W,WQ,p0,pbusy,marginal] = jacksonnetc([1 0 0]',[0 0.55 0.45;0 0 0.02;0 0.01 0],[120 10 3]',[1 3 7]',35,10)
%
k=length(r);               % k = number of stations
vi=(eye(k)-R')\r;          % solving traffic equations
lambdai=lambda*vi;         % arrival rates
ri=lambdai./mu;            % numbers in service           
roi=ri./c;                 % traffic rates              
for i=1:k
   p=1;
   s=1;
   lq=1;
   for m=1:(c(i)-1)
      p=p*c(i)*roi(i)/m;
      s=s+p;
   end
   p=p*roi(i)/(1-roi(i));  % c(i) se vykrati !
   p0=1/(s + p);    
   LQi(i)=p*p0*roi(i)/(1-roi(i)); % queue lengths
   Li(i)=LQi(i)+ri(i);     % system sizes
   marginal(1,i)=p0;       % p0
   p=p0;
   for j=2:n+1
      p=p*roi(i);          % always multiply by roi
      if (j-1)<=c(i)
         p=p*c(i)/(j-1);   % this multiplication only till c
      end
      marginal(j,i)=p;     % pn
   end
end
Li=Li';
LQi=LQi';
Wi=Li./lambdai;            % system waits
WQi=Wi-(ones(k,1)./mu);    % queue waits
L=sum(Li);                 % total system size
LQ=sum(LQi);               % total number of waiting
W=vi'*Wi;                  % total time spent in network
WQ=vi'*WQi;                % total waiting time
p0=1;                      % probability of empty network
pbusy=1;                   % probability that all nodes are busy
for j=1:k
   p0=p0*marginal(1,j);
   pbusy=pbusy*(1-marginal(1,j));
end
