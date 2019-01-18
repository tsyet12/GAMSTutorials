function y = empiricalc(x,fx,u)
% (c) jskl UoM
%
% Generator of random numbers with empirical distribution
% To obtain the arguments you may use the function ecdf
% Continuous generation by linear interpolation
% Fast version without testing the arguments
%
% Arguments:
% x = sorted vector of x values (equal pair = discontinuity)
% fx = sorted vector of F(x) values (first 0, last 1)
% u ~ U[0,1]
%
% Returns:
% y = F^-1(u) = max{x|F(x)<u} + linear interpolation with next point
%
% Example use: 
% for i=1:50000
% y(i) = empiricalc(x,fx,rand);
% end
% hist(y,...)
%
i = 1;
while fx(i)<u     % find first entry such that F(x) >= u
  i = i + 1;
end
x1 = x(i-1);      % linear interpolation: (f2-f1)/(x2-x1) = (u-f1)/d
%x2 = x(i);
f1 = fx(i-1);
%f2 = fx(i);
y = x1 + (x(i)-x1)*(u-f1)/(fx(i)-f1);   % y = x1 + d;




