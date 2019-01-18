% Script generating SP minimizers and minima
for i=1:10000
  [x(i) z(i)]=fminsearch('SPf2',0.5,[],a + randn*b);
end