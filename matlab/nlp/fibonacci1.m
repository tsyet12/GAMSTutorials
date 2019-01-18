function fn = fibonacci1(n)
%
% Computes the Fibonacci number F(n)
%
if n<=0 fn = 0;
elseif n==1 fn = 1;
else
    f(1) = 0; f(2) = 1;
    for i=2:n
        f(i+1) = f(i)+f(i-1);
    end
    fn = f(n+1);
end


