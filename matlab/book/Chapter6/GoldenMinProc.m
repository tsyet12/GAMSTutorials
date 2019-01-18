% 1-D optimal step size using golden section
% This is a Golden Section Search M-file for  a scalar function of
%	vector inputs.  
%	The default values are 	alpha0 = 0.0
%									astep = 1.0  for scanning ( calculation of bounds)
%									nstep = 10  number of scanning steps
%									toler = 1.0e-08  tolerance in the computation
function value = GoldenMinProc(functname,x,s)

global countloop astep alphal toler nstep;

flag = 1;  	% used to flag the search in the reverse direction
% calling Boundsmin2 to calculate upperbound on alpha 
% using bracketting

% with progress to the solution the astep value used for bracketting 
% is decreased


solution = Boundsmin2(functname,x,s,alphal,astep,nstep);

% if alpha search returns  value close to alphal 
% flag the calling procedure to reverse the direction of the 
% search vector and try again
%	to account for precision degradation we compare difference

if solution(1) == alphal 
   flag = -1;
   value = [flag solution(1) solution(2) x];
   return;
end


au = solution(1); fau = solution(2);
eps1 = toler/(au - alphal);
if eps1 > 1.0
   eps1 = 0.001;
end

tau = 0.38197;
nmax = round(-2.078*log(eps1));
% 
al = alphal;	xl = x + al*s;	fal = feval(functname,xl);	
a1 = (1-tau)*al + tau*au;
	x1 = x + a1*s;	fa1 = feval(functname,x1);
a2 = tau*al + (1 - tau)*au;
	x2 = x + a2*s;	fa2 = feval(functname,x2);   

%avec = [al a1 a2 au; fal fa1 fa2 fau];

for i = 1:nmax

	if fa1 >= fa2
   	al = a1;	fal = fa1;
   	a1 = a2;	fa1 = fa2;
   	au = au;	fau = fau;
   	a2 = tau*al + (1 - tau)*au;	x2 = x + a2*s;	fa2 = feval(functname,x2);
   	%avec = [al a1 a2 au; fal fa1 fa2 fau];
   
	else
   	au = a2;	fau = fa2;
   	a2 = a1;	fa2 = fa1;
   	a1 = (1-tau)*al + tau*au;	x1 = x + a1*s;		fa1 = feval(functname,x1);
   	al = al;	fal = fal;
   	%avec = [al a1 a2 au; fal fa1 fa2 fau];
	end
end
%avec =[al a1 a2 au ;fal fa1 fa2 fau];
%disp(avec);

% returning value

if fa1 > fa2 
   value = [flag a2 fa2 x2];
else
   value = [flag a1 fa1 x1];
end
   