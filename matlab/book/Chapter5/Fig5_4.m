% to generate figure 5.4
% Example 5.1
% Numerical Techniques - 1 D optimization
% Optimzation with MATLAB, Section 5.2.5
% Dr. P.Venkataraman
%
%	

syms  al f g aL fL au fu a1 f1 a2 f2
f = (al-1)^2*(al-2)*(al-3);
g = -1 - 1.5*al + 0.75*al*al;
ezplot(f,[0 4])
l1 =line([0 4],[0 0]);
set(l1,'Color','k','LineWidth',1,'LineStyle','-')
hold on

tau = 0.38197;


al = 0; aL = al; fL = subs(f);
au = 4.0; al = au; fu = subs(f);

a1 = (1-tau)*aL + tau*au; al = a1; f1 = subs(f);
a2 = tau*aL + (1 - tau)*au; al = a2; f2 = subs(f);

l2 =line([aL aL],[0 fL]);
l3 =line([au au],[0 fu]);
l4 =line([a1 a1],[0 f1]);
l5 =line([a2 a2],[0 f2]);


grid
hold off
xlabel('\alpha')
ylabel('f(\alpha)')
title('Example 5.1: Golden Section - start')
