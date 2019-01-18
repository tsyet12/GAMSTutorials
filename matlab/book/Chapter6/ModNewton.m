% Modified Newtons Method
% Symbolic calculations
%
function return = ModNewton(xx,niter)
tol = 0.0001; lowbound = 0; intvl = 1; ntrials = 20;
nvar = lngth(xx);
for j = 1:nvar
   x(j) = xx(j);
end
as(1)=0;
xs(1,:)=x;
fs(1)=5.3125;


for i = 1:niter -1
   	syms x1 x2 f g1 g2 h

	f = 3 + (x1 - 1.5*x2)^2 +(x2 - 2)^2;
	g1 = diff(f,x1);
   g2 = diff(f,x2);
   x1 = x(1); x2 = x(2);
   h = jacobian([g1;g2],[x1,x2]);
   hval=subs(h)
   s = -inv(hval)*[subs(g1) subs(g2)]';
   
   
   output = GoldSection_nVar(functname,tol,x, ...
      s,lowbound,intvl,ntrials);
   
   as(i+1) = output(1);
   fs(i+1) = output(2);
   for k = 1:nvar
      xs(i+1,k)=output(2+k);
      x(k)=output(2+k)
   end
end
   

