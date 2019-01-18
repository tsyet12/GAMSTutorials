function x=gauss(A,b)
% solves set of equations Ax=b
% A should be square nonsingular
% no tests
rmax=length(A(:,1));
c=[A b];
for i=1:rmax
   c=downpivot(c,i,i);
end
x=zeros(rmax,1);
for j=0:rmax-1
   i=rmax-j;
   s=0;
   for k=i+1:rmax
      s=s+x(k)*c(i,k);
   end
   x(i)=c(i,rmax+1)-s;
end
