function ret = obj_optcont(x)
global xx1 xx2 yy1 yy2 nBez A v0
global xv1 xv2
global phi nDes
global xdes

% get the integrated state
% and the error in the boundary conditions
nDes = length(x);
x(1) = 0;  % Taking care of oversight
x(nDes-1)=1;
xdes = x;
nDes = length(x);


tinterval = [0  1];
h0 = [xx1 yy1];
[t h] = ode45('brachi',tinterval,h0); 
lv = length(t);
lx = length(x);


% objective function is error squared in the final point
ret =  (h(lv,1)-xx2)^2 + (h(lv,2)-yy2)^2 ;