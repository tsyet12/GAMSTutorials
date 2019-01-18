%
% Broyden-Fletcher-Goldfarb-Shanno Method
%

% symbolic computation
format compact
Syms x1 x2  f gradx1 gradx2 s1 s2
syms y A B C

f = 3+(x1 -1.5*x2)^2 + (x2 - 2)^2;
gradx1 = diff(f,x1);
gradx2 = diff(f,x2);

A = eye(2)

x1 = 0.5; x2 = 0.5;
x11 = x1; x21 = x2;
f1 = subs(f);
g1 = subs(gradx1); g2 = subs(gradx2);
g11 = g1; g21 = g2;
c1 = g11*g11 + g21*g21;
s = -inv(A)*[g1 g2]';
s11=s(1); s21 = s(2);

syms a fa
x1 = x1 + a*s(1);
x2 = x2 + a*s(2);

fa =subs(f);

a1 = double(solve(diff(fa)));

a = a1;
x12 =subs(x1); x22 = subs(x2);
x1 = x12; x2 = x22;
f2 = subs(f);
g12 = subs(gradx1); g22 = subs(gradx2);
c2 = g12*g12 + g22*g22;
Y = [(g12 - g11) (g22 - g21)]';
delx =[(x12 -x11) (x22 - x21)]';

B = (Y*Y')/(Y'*delx);
C = ([g11 g21]'*[g11 g21])/([g11 g21]*[s(1) s(2)]');
A =A + B + C;
s = -inv(A)*[g12 g22]';
s12 = s(1); s22 = s(2);
syms a fa
x1 = x12 + a*s(1);
x2 = x22 + a*s(2);

fa =subs(f);

a2 = double(solve(diff(fa)));

a = a2;
x13 =subs(x1); x23 = subs(x2);
x1 = x13; x2 = x23;
f3 =subs(f);
g13 = subs(gradx1); g23 = subs(gradx2);
xit1=[x11 x21 f1 g11 g21 s11 s21 c1 a1];
disp(xit1)
dit1 = [delx(1), delx(2), Y(1) ,Y(2)];
disp(dit1)
B, C, A
xit2=[x12 x22 f2 g12 g22 s12 s22 c2 a2];
disp(xit2)
disp([x13 x23 f3 g13 g23])
