function retval = FALM_741(x)
% 
% calculates the unconstrained fuction for ALM method
%
global lamda beta
global n m leq
global rh rg
retval = Ofun_741(x);

if leq > 0
   hval = Hfun_741(x);
   lamda;
   retval = retval + lamda*hval'+ rh*(hval*hval');
end

if m > 0
   gval = Gfun_741(x);
   for j = 1:m
      g(j) = max(gval(j),-beta(j)/(2*rg));
   end
   retval = retval + beta*g'+ rg*(g*g');
end
