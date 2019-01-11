
$Title Linear Program



set j   /1*4/ , i /1*2/;
Parameter b(i) / 1 80, 2 100/, c(j) / 1 -3, 2 -2 /;

table a(i,j)
    1 2 3 4
1   1 1 1 0
2   2 1 0 1;

Variable z; positive variable x(j);
equations objfunc, constr(i);
objfunc.. z =E= sum(j, c(j)*x(j));
constr(i)..sum(j,a(i,j)*x(j)) =E= b(i);

model linprogram / objfunc, constr/;
solve linprogram using lp min z;
                