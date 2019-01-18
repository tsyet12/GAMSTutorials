% Example 5.1 and 5.1.a	
% Numerical Techniques - 1 D optimization
% Optimzation with MATLAB, Section 5.2.1
% Dr. P.Venkataraman
%
%	

syms  al f g
f = (al-1)^2*(al-2)*(al-3);
g = -1 - 1.5*al + 0.75*al*al;
ezplot(f,[0 4])
l1 =line([0 4],[0 0]);
set(l1,'Color','k','LineWidth',1,'LineStyle','-')
hold on
ezplot(g,[0 4])
grid
hold off
xlabel('\alpha')
ylabel('f(\alpha), g(\alpha)')
title('Example 5.1 and Example 5.1a')
