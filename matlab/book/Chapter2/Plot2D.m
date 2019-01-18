% Script file to go with Contour plotting
% Dr. P.Venkataraman,  Applied Optimization Using MATLAB
%  Ch. 2, Sec 2.4
%
% script M file for 2D Contour Plotting of functions involved 
% in optimization.  All functions are expected to be
% available as MATLAB function m-files
% Functions will be selected through the input selection box
% Funtion input parameters will be meshed matrices based 
% on the range of parameters available from GUI 
%
% The Number of plots and range for the plot
% are obtained from running the 
% user interface script GUI2_4 prior 
% to the call to Plot2D.m
%


GUI2_4	% call the GUI 

% XInfo, YInfo are introduced for introducing default 
% values
Xinfo = [x1min x1max x1inc];
if isempty(Xinfo)
   Xinfo = [-4 4 0.05]; % default
end
fprintf('\n')

Yinfo = [x2min x2max x2inc];
if isempty(Yinfo)
   Yinfo = [-4 4 0.05];
end
fprintf('\n')
xvar = Xinfo(1):Xinfo(3):Xinfo(2); % x1 vector
yvar = Yinfo(1):Yinfo(3):Yinfo(2);  % x2 vector
[X1, X2]= meshgrid(xvar,yvar);     % matrix mesh
   
% set default number of plots to 1     
if isempty(Np)
   Nplot = 1;
end
clf;    % clear figure
for Mplot = 1:Np
        
	text1 = ['The function which is being plotted must be a MATLAB' ... 
         '\nfunction M - File.  Given a meshed matrix input' ...
         '\nit must return a Matrix' ...
         '\nPlease select function name in the dialog box and hit return : \n '];
 
              
	fprintf(text1)  
	% using the uigetfile dialog box
	[file, path] = uigetfile('c:\*.m','Files of type MATLAB m-file',300,300);

	% check if file is string
	% strip the .m extension from the file so it can be called
	% by the program
	if isstr(file)
   	functname = strrep(file,'.m','');
	else     
   	fprintf('\n\n');
   	text2 = [' You have chosen CANCEL or the file was not acceptable ' ...
         	'\nThe program needs a File to Continue' ...
            '\nPlease call Plot2D again and choose a file  OR ' ...
            '\npress the up-arrow button to scroll through previous commands \n\n' ...
            'Bye !'];
      error(text2);
      
      
	end
   clear text1 text2; % clears the variables text1 and text2 for reuse
   clear Fun maxval minval strcon convalue onevalue labcont labcontU
   
   Fun = feval(functname,X1,X2);  
   maxval = max(max(Fun));
   minval = min(min(Fun));
   
   fprintf('The contour ranges from MIN:  :%12.3f   MAX. : %12.3f  ',minval,maxval);
   fprintf('\n');
   strcon = input('Do you want to set contour values ?[ no]:','s');
   strconU = upper(strcon);
   if strcmp(strconU,'YES') | strcmp(strconU,'Y')
      fprintf(' Input a vector of contour levels ');
      fprintf('\n')
      fprintf('between %10.2f and %10.2f ',minval,maxval); 
      fprintf('\n')
      convalue = input(' Input contour level as a Vector  :');
         labcont = input('Do you want labelled contours ? [ no]:','s');
         labcontU = upper(labcont);
            if strcmp(labcontU,'YES')| strcmp(labcontU,'Y')
               [C,h] = contour(xvar,yvar,Fun,convalue);
               clabel(C,h);
            else
               contour(xvar,yvar,Fun,convalue);
            end

   else
      ncon = input('Input number of contours [20]  :');
      if isempty(ncon)
         ncon = 20;
         labcont = input('Do you want labelled contours ? [ no]:','s');
         labcontU = upper(labcont);
         if strcmp(labcontU,'YES')| strcmp(labcontU,'Y')
            [C,h] = contour(xvar,yvar,Fun,ncon);
            clabel(C,h);
         else
            contour(xvar,yvar,Fun,ncon);
         end
      elseif ncon == 1
         onevalue = input('Input the single contour level : ');
         labcont = input('Do you want labelled contours ? [ no]:','s');
         labcontU = upper(labcont);
            if strcmp(labcontU,'YES')| strcmp(labcontU,'Y')
               [C,h] = contour(xvar,yvar,Fun,[onevalue,onevalue]);
               clabel(C,h);
            else
               contour(xvar,yvar,Fun,[onevalue,onevalue]);

            end
      else
         labcont = input('Do you want labelled contours ? [ no]:','s');
         labcontU = upper(labcont);
         if strcmp(labcontU,'YES')| strcmp(labcontU,'Y')
            [C,h] = contour(xvar,yvar,Fun,ncon);
            clabel(C,h);
         else
               contour(xvar,yvar,Fun,ncon);
         end


      end
   end
   if Np > 1
   	hold on;
	end
		Hf = gcf;
end

figure(Hf);
grid
hold off
dbquit