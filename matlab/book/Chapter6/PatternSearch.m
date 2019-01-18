% 	
% Ch 6: Numerical Techniques for Unconstrained Optimization
% Optimzation with MATLAB, Section 6.2.2
% Pattern Search Method 
% copyright (code) Dr. P.Venkataraman
%	
% A script file for minimun of a function using 
%		
%			Pattern Search
%		With golden section for 1D alpha

%************************************
% requires:     	UpperBound_nVar.m
%						GoldSection_nVar.m
%	and the problem m-file: Example6_1.m
%**********************************
% This is a stand alone program
% The function to be minimized is set up as a MATLAB function
% with a vector input and returning a scalar output
%*******************************************************
% **IMPORTANT****
% An initial vector guess for the starting solution is necessary
% The remaining entries can be ignored if default values are acceptable
%

% default value for lowbound = 0.0
% default value for intvl = 1.0
% default value for tol = 1.0e-04

lowbound = 0; intvl = 1; ntrials =20; tol = 0.001;
text1 = ['The function for which the minimum is sought must be a MATLAB' ... 
   	   '\n function M - File.  Given a vector dependent variable it must return' ...
      	'\na scalar value.  This is the  function to be MINIMIZED ' ...
         '\nPlease select function name in the dialog box and hit return : \n '];
         
fprintf(text1)  % displaying prompt
% using the uigetfile dialog box
[file, path] = uigetfile('c:\opt_book\ch6\code\*.m','File of type MATLAB Script',300,300);

   if isstr(file)
      functname = strrep(file,'.m',''); % strip .m from file name
   else
      
      fprintf('\n\n');
      text2 = ['You have chosen CANCEL or the file was not acceptable ' ...
         	'\nThe program needs a File to Continue' ...
            '\nPlease call FpatternMain again and choose a file  OR ' ...
            '\npress the up-arrow button to scroll through previous commands \n' ...
         '\nBYE'];
      fprintf(text2);   
    end

clear text1 text2;
fprintf('\n');
string1 = strcat('The function you have chosen is ::   ',functname);
fprintf(string1);
clear string1;

fprintf('\n');
% below default values are used if user does not enter any values
Nmaxd = 1000;	epsfdifd = 1.0e-8;	epsxdifxd = 1.0e-8;
Nmax = input(' maximum number of cycles [1000] :  ');
if isempty(Nmax)
   Nmax = Nmaxd;
end
fprintf('\n')
epsfdif = input(' convergence tolerance for difference in f[1e-8] :  ');
if isempty(epsfdif)
   epsfdif = epsfdifd;
end
fprintf('\n')
epsxdif = input(' convergence tolerance on change in design x [1e-8] :  ');
if isempty(epsxdif)
   epsxdif = epsxdifxd;
end  
ok = 1;
while(ok)   
   string1 = ['Input the starting design vector. This is mandatory' ...
    '\nas there is no default vector setup. The length of your vector indicates'...
    '\nthe the number of unknowns. Please enter it now and hit return  :  ' ...
    '\n'] ;
   
	xdes = input(string1);
	fprintf('\n')
	fprintf(' The initial design vector [ %6.2f  %6.2f ]',xdes);
   fprintf('\n')
   
 	if (isempty(xdes) == 0)
      break;
   end
end   

n = length(xdes);% length of design vector

% initialize the search vector  to zero
for i = 1:n;
   searchi(i) = 0.0;
end

% start the search for Nmax iterations -------------------------------
% In this method for each iteration there will be n + 1 iterations
% the  first n iterations correspond to the unit vector search directions
% the n+1 iteration correspond to the summ of the previous displacements
%-------------------------------------------------------------------------
iders = 1;  % iteration counter
idersall = 0;  % iteration counter

% store values
xstore(iders,:) = xdes;
fstore(iders) = feval(functname,xdes);
astore(iders) = lowbound;

countloop = 0;
for outloop = 1:Nmax;	% loop on cycles
   xbegin = xdes;
   fbegin = feval(functname,xdes);
   
   xcur = xdes ;
   for ider = 1:n; % for univariate iterations
      iders = iders + 1;
      
      search = searchi;		% coordinate search direction 
      search(ider) = 1.0;   
      
               
      solution1 = GoldSection_nVar(functname,tol,xcur, ...
         search,lowbound,intvl,ntrials); % 1D search
      idersall = idersall + 1;
      
      % if returned alpha is equal to lowerbound that 
      % direction was not useful
      % reverse the direction and check
      if solution1(1) <= lowbound;
      	search(ider) = -1.0; % reverse the search direction and 
           							% update x anyway
         solution1 = GoldSection_nVar(functname,tol,xcur, ...
                search,lowbound,intvl,ntrials); % 1D search
         for j = 3: n+2;  
           	xcur(j-2) =  solution1(j); %update design vector
         end
			idersall = idersall + 1;
      else							% search direction acceptable ;update x 
        	for j = 3: n+2;  
           	xcur(j-2) =  solution1(j);
        	end
      end
      %store the values for iteration 
      xstore(iders,:) = xcur;
      fstore(iders) = feval(functname,xcur);
		astore(iders) = solution1(1);
   end 
   
   % begin n+1 iteration.   The search is based on changes in x in the 
   % previous n iterations along the coordinate directions
   search = xcur - xbegin;
   
   % pause;
   solution2 = GoldSection_nVar(functname,tol,xcur, ...
         search,lowbound,intvl,ntrials); % 1D search
  
   if solution2(1) <= lowbound;
   	search = -search; % reverse the search direction
   	solution2 = GoldSection_nVar(functname,tol,xcur, ...
         search,lowbound,intvl,ntrials); % 1D search
      for j = 3: n+2;  	% update x even if not successful
      	xcur(j-2) =  solution2(j);
     	end
    	idersall = idersall + 1;    
    else
     	for j = 3: n+2;  	% update x
       	xcur(j-2) =  solution2(j);
       end
       idersall = idersall + 1;
   end
   iders = iders + 1;
   
   % store the value of x
   xstore(iders,:) = xcur;
   fstore(iders) = feval(functname,xcur);
   astore(iders) = solution2(1);
   countloop = countloop + 1;
   %  check convergence on f
   fdiff = feval(functname,xcur)-fbegin;
   if abs(fdiff) < epsfdif;
      fprintf('Convergence in f : % 14.3E  reached in %6i iterations \n', ...
         abs(fdiff), countloop);
      fprintf('Number of useful calls to the Golden Section Search Method :%6i \n',iders);
      fprintf('Total number of calls to the Golden Section Search Method :%6i \n',idersall);
      fprintf('\n The values for x and f are \n');      
      disp([xstore fstore' astore'])
      break;
   end
   % convergence in changes in x      
   xdiff = (xcur-xbegin)*(xcur-xbegin)';
   if xdiff < epsxdif
      fprintf('Convergence in x : % 12.3E  reached in %6i iterations \n', ...
         xdiff, countloop);
      fprintf('Number of useful calls to the Golden Section Search Method :%6i \n',iders);
      fprintf('Total number of calls to the Golden Section Search Method :%6i \n',idersall);
      fprintf('\n The values for x and f are \n')
      disp([xstore fstore' astore'])
      break;
   end
   xdes = xcur; 	% a single iteration over
   % update x and return to outloop iteration
end
if outloop == Nmax
   fprintf('maximumum number of iterations reached : %6i \n',Nmax);
   fprintf('Number of useful calls to the Golden Section Search Method :%6i \n',iders);
   fprintf('Total number of calls to the Golden Section Search Method :%6i \n',idersall);
   fprintf('\n The values for x and f are \n')
   disp([xstore fstore' astore'])
end
if (n == 2)
  % for 2 var problems the contour plot can be drawn
   x1 = -2:0.1:5;
   x2 = -1:0.1:5;
x1len = length(x1);
x2len = length(x2);
for i = 1:x1len;
   for j = 1:x2len;
      x1x2 =[x1(i) x2(j)];
      fun(j,i) = feval(functname,x1x2);
   end
end


c1 = contour(x1,x2,fun, ...
   [5 10 25 50 10 200 500],'b');  % example 6.2
  % [3.1 3.25 3.5 4 6 10 15 20 25],'b');  % example 6.1
%clabel(c1); % remove labelling to mark iteration
grid
xlabel('x_1')
ylabel('x_2')
% replacing _ by - in the function nane
funname = strrep(functname,'_','-');

% adding file name to the title
title(strcat('Pattern Search Using :',funname));

minp = min(9,length(fstore));
for i = 1:minp;
   if ((i == 1) | (i == 4) | (i == 7))
      line([xstore(i,1) xstore(i+1,1)],[xstore(i,2) xstore(i+1,2)], ...
            'LineWidth',2,'Color','r')
   elseif ((i == 2) | (i == 5) | (i == 8))
      line([xstore(i,1) xstore(i+1,1)],[xstore(i,2) xstore(i+1,2)], ...
            'LineWidth',2,'Color','g')
   elseif ((i == 3) | (i == 6) | (i == 9))
      line([xstore(i,1) xstore(i+1,1)],[xstore(i,2) xstore(i+1,2)], ...
            'LineWidth',2,'Color','k')

	end
end
end

