function y = newsboy(x,ps,ksis,c,d)
% (c) jskl UoM
%
% newsboy(x,ps,ksis,c,d) returns expected profit for Discrete Newsboy Problem
%
% x = number of bought papers
% ksis = vector of demands. Ex: ksis=[0 1 3 4 6 10]'
% ps = vector of their probabilities. Ex: ps=[.1 .2 .4 .2 .05 .05]'
% c = selling price. Ex: c=2
% d = buying price (d<c). Ex: d=1
%
% To visualize:   fshow(0,10,0.05,'newsboy',ps,xs,c,d);
% To optimize:    [xmax zmax] = fminsearch(@(x) -newsboy(x,ps,xs,c,d),0)
% Example result: xmax = 3.0000, zmax = -1.6000 (ignore "-")
%
z = 0;
i = 1;
le = length(ksis);  % no checks
while ksis(i)<x
    z = z + (x-ksis(i))*ps(i);
    i=i+1;
    if i>le
        break
    end
end
y = (c-d)*x - c*z;  % z = expected number of unsold papers
