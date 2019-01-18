for t=1:7
 for i=1:18
  pn(i)=poisspdf(N-i,m*t);
 end
 p0=1-sum(pn);
 p(t)=p0+sum(pn(1:5));
end