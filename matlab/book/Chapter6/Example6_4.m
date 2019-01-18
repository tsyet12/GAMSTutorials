%Ch 6: Numerical Techniques for Unconstrained Optimization
% Optimzation with MATLAB, Section 6.5.3
% copyright (code) Dr. P.Venkataraman
%
% Example 6.5.3 - Curfitting using Bezier curves
%	
% 
%************************************
% requires:       DFP.m	
%						UpperBound_nVar.m
%						GoldSection_nVar.m
%
% The example  m-file: Example6_4.m
%
% This is run as a stand alone program
% The Bezier calculations are handles in
%						Curve_fit.m
%						Bez_Sq_Err.m
% Coefficient in  coeff.m			which requires
%								Combination.m
%								Factorial.m
% 
%***************************************
%	data must be available in an ascii File in which is 
%	two column of numeric data starting from the first row
%	this file will be will be selected through a file selection box
%

global nBez A XX YY 
global xv1 yv1 xv2 yv2
%********************************
% use a file selection box
%***********************************
[file,path] = uigetfile('*.txt','File of type text .txt ',200,200);

if isstr(file)
   loadpathfile= ['load ',path,file];
   eval(loadpathfile);
   newname = strrep(file,'.txt','');
   Data = eval(newname);
   XX=Data(:,1);
   YY=Data(:,2);
   clear path loadpathfilename newname
end

nTotal =0;
nBez = 0;

nTotal = length(XX);
NTOTAL = num2str(nTotal);

%***************************************
% use an input dialg box to obtain order of curve
% String input must be converted to number
%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Prompt ={'Enter the order of Bezier curve (between 2 and 10) used to track data'};
Title='Order of the Bezier curve';
Lineno = 1;
ok = 1;
while (ok)
   answer = inputdlg(Prompt,Title,Lineno);
   NBEZ = answer{1,1};
   nBez = str2num(NBEZ);
   if (nBez > 2) &  (nBez < 10)
      break;
   else
     Prompt ={'Please enter an order between 2 and 10'};
 
   end
end

clear Prompt Title Lineno

%	calculate Bezier Coeffifient matrix
%  this depends on order and will not change for the rest of the calculations


A = coeff(nBez);

%*******************************************
% The design variables are the vertices of the 
% Bezier polygons (except for the first and last vertices)
% Automatically guess the initial design using curve data
%***************************************** 
XV(1) = XX(1);
xv1 = XV(1);  % first vertex used elsewhere
XV(nBez+1) = XX(nTotal);
xv2 = XV(nBez+1); % last vertex - useful elsewhere
YV(1) = YY(1);   
yv1 = YV(1);
YV(nBez+1) = YY(nTotal);
yv2 = YV(nBez+1);
   
for i = 2:nBez
  ii = round((i-1)*(nTotal/nBez));
  XV(i) = XX(ii);
  %XVO(i)=XV(i);
  YV(i) = YY(ii)*1.1;
  %YVO(i) = YV(i);
end

%  call the curve_fit routine
%   this will call the DFP method
%
[VX,VY]= Curve_Fit(XV,YV);
   
DX = 1.0/(nTotal-1);     
   for i = 1:nTotal
      gam = (i - 1)*DX;
      for j = 1:nBez+ 1
         k = nBez+1 - j;
         GAM(j) = gam^k;
      end
      XYVert=[VX;VY]';
      Xfit = GAM*A*XYVert;
      XF(i) = Xfit(1);
      YF(i) = Xfit(2);
      
   end
   plot(XX,YY,'ro',XF,YF,'b--')
   title('Example 6-4: Curfit using Bezier curves')
   xlabel('x - data (read from file)')
   ylabel('y - data (read from file)')
   grid
   
   

  
   