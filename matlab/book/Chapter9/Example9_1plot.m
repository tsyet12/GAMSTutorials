function ret = Example9_1plot(X,Y)
%
% generating values for plotting 
% faster then using Example9_1.m
% 
R = sqrt((X-4).^2 + (Y-4).^2 + 0.1); 
ret = -20*sin(R)./R;
% 
% this is not actually the sinc function
