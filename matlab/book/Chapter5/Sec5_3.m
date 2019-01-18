syms f x1 x2 x3 gradx1 gradx2 gradx3 hess

f = (x1 - x2)^2+ + 2*(x2 - x3)^2 + 3*(x3 - 1)^2;

gradx1 =diff(f,x1);gradx2 = diff(f,x2); gradx3 = diff(f,x3);

xs = solve(gradx1,gradx2,gradx3,'x1,x2,x3')