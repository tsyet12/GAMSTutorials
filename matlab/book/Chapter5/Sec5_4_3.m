% Example 5.5	
% Numerical Techniques - 1 D optimization
% Optimzation with MATLAB, Section 5.4.3
% Dr. P.Venkataraman
%
%	

syms  al f g
g = -1 - 1.5*al + 0.75*al*al;
f=g*g;
ezplot(g,[0 4])
l1 =line([0 4],[0 0]);
set(l1,'Color','k','LineWidth',1,'LineStyle','-')
hold on
ezplot(f,[0 4])
grid
hold off
xlabel('\alpha')
ylabel('g(\alpha), f(\alpha)')
title('Example 5.4')
axis([0 4 -2 18])
