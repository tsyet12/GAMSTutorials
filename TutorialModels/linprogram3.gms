set j /1*100/, i/1*10/;
parameter b(i), c(j); b(i)=uniform(80,100); c(j)=uniform(-5,-1);
parameter a(i,j); a(i,j)=uniform(1,2);

variable z; positive variable x(j);
equations objfunc, constr(i);
objfunc..z =E= sum(j,c(j)*x(j));
constr(i)..sum(j, a(i,j)*x(j))=E= b(i);

model linprogram /all/;
solve linprogram using lp min z;
display c,a,b, z.l, x.l;
file out / "out.txt"/; put out; put "Results"/;
put "z_min", z.L:10:2/; loop(j, put j.TL:3, x.L(j):10:2/);
