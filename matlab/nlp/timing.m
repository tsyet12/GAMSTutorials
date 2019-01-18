time = cputime;
[xmin,fmin,evals,epsilo] = DFPsearch_show([-2 2]',1e-5,-2,2,0.05,-1,3,0.05,40,'banana','nabla_banana')
time = cputime - time
