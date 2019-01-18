function [Li,LQi,Wi,WQi,roi,lambdai,L,LQ,W,WQ,p0,pbusy,marginal,vi,lambdail,Lil,LQil] = jacksonnetcls(r,R,mu,c,lambda,mn)
% (c) jskl UoM
%
% jacksonnetcls solves stable open Jackson networks with multi channel stations and classes of customers
%
% (k = number of stations, n = number of classes)
% Arguments:
% r = distribution of arrivals [r(i,l)=probability of arriving to station i for class l](kxn matrix)
% R = probability of movements [R(i,j,l)=probability of moving from i to j for class l](kxkxn array)
% mu = service rates (k vector)
% c = numbers of channels (k vector)
% lambda = arrival rates [lambda(l)=arrival rate for class l (n vector)
% mn = maximal marginal probability required (mn >= 0)
%
% Returns k vectors [Li,LQi,Wi,WQi,roi,lambdai] where:
% Li = mean system sizes
% LQi = mean queue lengths
% Wi = mean system times
% WQi = mean queue waits
% roi = traffic rates (utilization of servers)
% lambdai = total effective arrival rates
%
% scalars [L,LQ,p0,pbusy] where
% L = total mean system size (number in network)
% LQ = total mean number of waiting items
% p0 = probability of empty network
% pbusy = probability that all nodes are busy
%
% n vectors [W,WQ] where
% W = total mean times spent in the network
% WQ = total mean waiting times
%
% (m+1) x k matrix
% marginal = marginal probabilities p0 - pm in columns
%
% kxn matrices [vi,lambdai,Lil,LQil] where
% vi = expected numbers of visits (solution to traffic equations)
% lambdail = arrival rates for classes
% Lil = numbers in systems for classes
% LQil = numbers in queues for classes
%
% Example use generally: 
% [Li,LQi,Wi,WQi,roi,lambdai,L,LQ,W,WQ,p0,pbusy,marginal,vi,lambdail,Lil,LQil] = jacksonnetcls(r,R,mu,c,lambda,mn)
%
% G&H (WS15_3) example: (R must be created e.g. as follows)
%
% >> R1=[0 1 0;0 0 0.02;0 0 0]
% >> R2=[0 0 1;0 0 0;0 0.01 0]
% >> R=eye(3)
% >> R(:,:,1)=R1
% >> R(:,:,2)=R2
%
% [Li,LQi,Wi,WQi,roi,lambdai,L,LQ,W,WQ,p0,pbusy,marginal,vi,lambdail,Lil,LQil] = jacksonnetcls([1 0 0;1 0 0]',R,[120 10 3]',[1 3 7]',[19.25 15.75]',10)
%
[k,n]=size(r);             % k = number of stations, n = number of classes
for l=1:n                  % solving traffic equations for all classes
  vi(:,l)=(eye(k)-R(:,:,l)')\r(:,l);    % numbers of visits for class l
  lambdail(:,l)=lambda(l)*vi(:,l);      % arrival rates for class l
end
lambdai=sum(lambdail')';   % total arrival rates
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
   p=p*roi(i)/(1-roi(i));  % c(i) cancelles !
   p0=1/(s + p);    
   LQi(i)=p*p0*roi(i)/(1-roi(i)); % queue lengths
   Li(i)=LQi(i)+ri(i);     % system sizes
   marginal(1,i)=p0;       % p0
   p=p0;
   for j=2:mn+1
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
LQ=sum(LQi);               % total number of waiting customers
for l=1:n
   W(l)=vi(:,l)'*Wi;       % total times spent in network for classes
   WQ(l)=vi(:,l)'*WQi;     % total waiting times for classes
end
p0=1;                      % probability of empty network
pbusy=1;                   % probability that all nodes are busy
for j=1:k
   p0=p0*marginal(1,j);
   pbusy=pbusy*(1-marginal(1,j));
end
for l=1:n                  % system and queue sizes for classes
   Lil(:,l)=Li.*(lambdail(:,l)./lambdai);
   LQil(:,l)=LQi.*(lambdail(:,l)./lambdai);
end

