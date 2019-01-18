%  Curve fit chores handled here
function [XVt,YVt] = Curve_Fit(XVert,YVert)

global nBez A XX YY WT

% construct the design vector using the guessed vertices
for i = 2: nBez
   xo(i-1) = XVert(i);
   xo(nBez+i-2) = YVert(i);
end

x = DFP('Bez_Sq_Err',xo,10,1.0e-08,0,1,20);

%  set the vertices

for i = 2:nBez
   XVt(i) = x(i - 1);
   YVt(i) = x(nBez + i - 2);
end
XVt(1) = XVert(1);
YVt(1) = YVert(1);
XVt(nBez+1) = XVert(nBez+1);
YVt(nBez+1) = YVert(nBez+1);
