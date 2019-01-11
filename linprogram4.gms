set j /1*10/, i/1*10/;parameter b(i), c(j); parameter a(i,j);

variable z; positive variable x(j), y(i);
equations objfunc, constr(i);
objfunc..z =E= sum(j,c(j)*x(j));
constr(i)..sum(j, a(i,j)*x(j))+y(i)=E= b(i);

model linprogram /all/;
file out / "out.txt"/; put out; put "Results"//;
set k /1*3/; loop(k, b(i)=uniform(10,80);
c(j)=uniform(-5,-1); a(i,j)=uniform(1,2);
a(i,j)=uniform(1,2);

solve linprogram using lp min z; display c,a,b, z.l, x.l;

put k.TL:3, z.L:8:2;loop(j,put x.L(j):8:2); put /;);
