function fn = fibonacci2(n)
%
% Computes the Fibonacci number F(n)
%
if n<=0
    fn = 0;
elseif n==1
    fn = 1;
else
    fn = fibonacci2(n-1)+fibonacci2(n-2);
end


