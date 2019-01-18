function y = empiricald(x,fx,u)
% (c) jskl UoM
%
% Generator of random numbers with empirical distribution
% To obtain the arguments you may use the function ecdf
% Discrete generation (returns only values from x)
% Fast version without testing the arguments
%
% Arguments:
% x = sorted vector of x values
% fx = sorted vector of F(x) values (first 0, last 1)
% u ~ U[0,1]
%
% Returns:
% y = F^-1(u) = min{x|F(x)>=u}
%
% Example use: 
% for i=1:50000
% y(i) = empiricald(x,fx,rand);
% end
% hist(y,...)
%
i = 1;
while fx(i)<u     % find first entry such that F(x) >= u
  i = i + 1;
end
y = x(i);




