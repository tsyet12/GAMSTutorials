% Script generating SP minimizers and minima
for i=1:10000
  [x(i) z(i)]=fminsearch('SPf1',0,[],unifrnd(a,b));
end