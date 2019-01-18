function [fn time] = fib1(n)
%
% Computes the Fibonacci number F(n) and time taken
%
time = cputime;
fn = fibonacci1(n);
time = cputime-time;



