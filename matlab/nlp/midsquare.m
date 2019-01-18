function y = midsquare(seed,n)
%
% Generator of random numbers by the mid-square method
% Right 4 digits removed, next 8 digits returned and normalized
%
% Ex: y = midsquare(123456789,10000);
%
x = seed;
for i=1:n
    x = mod(floor(x*x/10000),100000000);
    y(i) = x/100000000;
end
