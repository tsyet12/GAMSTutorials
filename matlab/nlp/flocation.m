function f = flocation(x)
%
% returns the objective of the Location Problem (NLP)
%
a = [3 8 6];
b = [2 5 8];
X = x(1:2);
Y = x(3:4);
for i=1:2
    for j=1:3
        d(i,j)=norm([X(i) Y(i)] - [a(j) b(j)]);
    end
end
w = [x(5:7)'; x(8:10)'];
f = sum(sum(d.*w));
