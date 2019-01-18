function ret = populator(nDes)

% generates a random design vector
% since the Bezier curve is in the Convex hull of the vertices
% the random variables will lie between the max and min values
% of the vertices

%global nBez A XX YY
global xv1 yv1 xv2 yv2
dxv = xv2 - xv1;
delx = 0.1 ; % for stability of the Bezier error calculations
% the Newton-Raphson gets trapped if interval is too small
yyv2 = 4;
yyv1 = -2;
dyv = yyv2 - yyv1;
xcur = xv1;
frac = 0.25;
for i = 1:2:nDes-1
   x(i) = xcur+ delx + (xv2 - xcur)*frac*rand(1,1);
   x(i+1) =  yyv1 + dyv*rand(1,1);
   xcur = x(i);
   frac = 1;
end
ret =x;