
fss = xs1.^2 - xs2.^2;
gs1 = 2.5509*xs1.*xs1 +0.1361*xs1-333.7933*(xs1.^4-xs2.^4);
gs2 = (.0488+ 1.4619*xs1).*(xs1.*xs1+xs1.*xs2+xs2.*xs2) ...
   -166.5641*(xs1.^4-xs2.^4);
gs3 =  1.0868*xs1+0.3482 -28.4641*(xs1.^4-xs2.^4);
gs4 = xs2-xs1 +0.001;

fprintf('\n\nThe solution *** Case a ***(x1*,x2*, f*, g1, g2 g3 g4):\n'), ...
   disp(double([xs1 xs2 fss gs1 gs2 gs3 gs4]))

%unlike the previous case all the solutions are displayed
%
x1s=double(xs1(1));
fprintf('\n x1 = '),disp(x1s)
x2s=double(xs2(1));
fprintf('\n x2 = '),disp(x2s)

fprintf('\nConstraint:')
fprintf('\ng1:  '),disp(subs(g1s))
fprintf('\ng2:  '),disp(subs(g2s))
fprintf('\ng3:  '),disp(subs(g3s))
fprintf('\ng4:  '),disp(subs(g4s))
b2s=0.0; b4s = 0.0;
[bs1 bs3]=solve(subs(grad1s),subs(grad2s),'b1s,b3s');

fprintf('Multipliers b1 and b3  : ')
fprintf('\nb1:  '),disp(double(bs1))
fprintf('\nb2:  '),disp(double(bs3))

