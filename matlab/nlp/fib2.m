function [fn time] = fib2(n)
%
% Computes the Fibonacci number F(n) and time taken
%
time = cputime;
fn = fibonacci2(n);
time = cputime-time;



