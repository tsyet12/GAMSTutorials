% Example 4.3	Flag Pole Problem
%
% Optimzation with MATLAB, Section 4.5.2
% Dr. P.Venkataraman
% Flag Pole Problem (see also Example 2.4)
%

%******************************
%  scaled problem
%*****************************

syms x1s x2s g1s g2s g3s g4s fs b1s b2s b3s b4s Fs
g1s = 2.5509*x1s*x1s +.1361*x1s-33.148*(x1s^4-x2s^4);
g2s = (0.0488+ 1.4619*x1s)*(x1s*x1s+x1s*x2s+x2s*x2s) ...
   -166.5641*(x1s^4-x2s^4);
g3s = 1.0868*x1s + 0.3482 -28.4641*(x1s^4-x2s^4);
g4s = x2s-x1s + 0.001;

fs = x1s*x1s -x2s*x2s;
Fs = fs + b1s*g1s+ b2s*g2s + b3s*g3s +b4s*g4s;

%the gradient of F
syms grad1s grad2s
grad1s = diff(Fs,x1s);
grad2s = diff(Fs,x2s);


% solution
[xs1 xs2] = solve(g1s,g3s,'x1s,x2s');


fss = xs1.^2 - xs2.^2;
gs1 = 2.5509*xs1.*xs1 +0.1361*xs1-33.148*(xs1.^4-xs2.^4);
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

[b1s b3s]=solve(subs(grad1s),subs(grad2s),'b1s,b3s');

fprintf('Multipliers b1 and b3  : ')
fprintf('\nb1:  '),disp(double(b1s))
fprintf('\nb3:  '),disp(double(b3s))

