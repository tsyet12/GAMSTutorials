%	Curvefit using Bezier curves
%	By P.Venkataraman
%	Dec 1998
%
%	data must be available in an equal interval ascii File
%	that is a single column of numeric data starting from the first row
%	this will be selected through a file selection box
%
%
%	A new(/next) data point will be predicted
global nBez A XX YY 
global xv1 yv1 xv2 yv2

[file,path] = uigetfile('C:*.txt','File of type text .txt ',200,200);

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
%nData = 0;
nBez = 0;

nTotal = length(XX);
NTOTAL = num2str(nTotal);

%Prompt =strcat('Enter the number of data points out of:  ', NTOTAL,'  to track');
%Title='Data Window for Tracking';
%Lineno = 1;
%ok = 1;
%while (ok)
   %answer = inputdlg(Prompt,Title,Lineno);
   %NDATA = answer{1,1};
   %nData = str2num(NDATA);
	%if (nData > 0)
   %   break;
   %end
%end

%nD1 = nData + 1;
%clear Prompt Title answer

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

A = coeff(nBez);

%  In this program we will start from the first data and use a 
%  window of data points (nD1) to predict the value of stock at
%	the nD1 + 1 point.  
% 	This process continues again using the next nD1 data to predict 
%	value at nD1 + 2 point - in a loop on all the data points read
%	initially

%nLoop = nTotal - nD1;
%ML = 0;

for iL = 1:1
% external loop starts
   
   %for i = 1:nD1
    %  j = ML + i;
    %  XX(i) = (i - 1)*DX;
    %  YY(i) = stockData(j);
   %end
   % scale the stock value between 0 and 1 for better fit
  % miny = min(AYY);
  % maxy = max(AYY);
   
   %for i = 1:nD1
   %   YY(i) = (AYY(i) - miny)/(maxy - miny);
   %end
   %plot(XX,YY)
   
   % guess vertices.  Note that the first and last vertex are known
   
   XV(1) = XX(1);
   xv1 = XV(1);
   XV(nBez+1) = XV(nTotal);
   xv2 = XV(nBez+1);
   YV(1) = YY(1);   yv1 = YV(1);
   YV(nBez+1) = YY(nTotal);
   yv2 = YV(nBez+1);
   
   for i = 2:nBez
      ii = round((i-1)*(nTotal/nBez));
      XV(i) = XX(ii);
      XVO(i)=XV(i);
      YV(i) = YY(ii)*1.1;
      YVO(i) = YV(i);
   end
   
   
   %  call the curve_fit routine
   [VX,VY]= Curve_Fit(XV,YV);
   
 DX = 1.0/nTotal;     
   for i = 1:nTotal+1
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
	plot(XX,YY,'r-',XF,YF,'b--')
   %ML = ML + 1;
% external loop end   
end


  
   