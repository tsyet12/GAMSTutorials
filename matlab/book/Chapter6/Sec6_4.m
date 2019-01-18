% Modified Newtons Method
% Symbolic calculations
%

tol = 0.0001; lowbound = 0; intvl = 1; ntrials = 20;


syms x1 x2 f g1 g2 h
f = 3 + (x1 - 1.5*x2)^2 +(x2 - 2)^2;
g1 = diff(f,x1);
g2 = diff(f,x2);

h = jacobian([g1;g2],[x1,x2]);

x1 = 0.5; x2= 0.5;
f1 = subs(f)
g11 = subs(g1)
g21 = subs(g2)
h1 = subs(h)
s = -inv(h1)*[g11 g21]';
s11 = s(1), s21 = s(2)
x(1) = x1; x(2) = x2;

syms a fa
x1 = x1 + a*s(1)
x2 = x2 + a*s(2)
fa = subs(f);
a = solve(diff(fa))

x1 =subs(x1)
x2 =subs(x2)
f2 = subs(f)



   

