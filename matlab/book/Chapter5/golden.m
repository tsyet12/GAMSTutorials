% 1-D optimal step size using golden section
%
format compact;

%default values of alpha
alpha1d = 0.0;  	astepd = 1.0;	nstepd = 10;
tolerd = 0.001;

alphal = input('lower limit of alpha and press return(default = 0)  : ');
if alpha1 == 0 
   alpha1 = alpha1d;
end
astep = input('step alpha in the scanning for upper bound(default = 1)  : ');
if astep == 0
   astep = astepd;
end
nstep = input('number of scanning steps   :  ');
if nstep == 0
   nstep = nstepd;
end
toler = input('tolerance in the computation of minimum  :  ');
if toler == 0
   toler = tolerd;
end
% the following statements are for running the golden section alone
x = input(' current design vecto  : ');		%  starting design
s = input(' current search direction vector  :  ';	% default search direction

solution = Boundsmin('Objfun',x,s,alpha1,astep,nstep);
au = solution(1); fau = solution(2);
eps1 = toler/(au - alpha1);
tau = 0.38197;
nmax = round(-2.078*log(eps1))
% 
al = alphal;	xl = x + al*s;	fal = Objfun(xl);	
a1 = (1-tau)*al + tau*au;
	x1 = x + a1*s;	fa1 = Objfun(x1);
a2 = tau*al + (1 - tau)*au;
	x2 = x + a2*s;	fa2 = Objfun(x2);   
% fau = funvalue(au);
avec = [al a1 a2 au; fal fa1 fa2 fau]

for i = 1:nmax

if fa1 >= fa2
   al = a1;	fal = fa1;
   a1 = a2;	fa1 = fa2;
   a2 = tau*al + (1 - tau)*au;	x2 = x + a2*s;	fa2 = Objfun(a2);
   au = au;	fau = fau;
   avec = [al a1 a2 au; fal fa1 fa2 fau]
   
else
   au = a2;	fa2 = fau;
   a2 = a1;	fa2 = fa1;
   a1 = (1-tau)*al + tau*au;	x1 = x + a1*s;		fa1 = Objfun(a1);
   al = al;	fal = fal;
   avec = [al a1 a2 au; fal fa1 fa2 fau]
end
end
avec =[al a1 a2 au ;fal fa1 fa2 fau]

   