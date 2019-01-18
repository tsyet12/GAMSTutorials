%
% Optimization with MATLAB
% copyright Dr. P.Venkataraman
%
% Chapter 7. Sec 7.2.2
% Augmented Lagrange Multiplier Method
%
%	An  Indirect Method for Constrained Optinmization 
%
%	Problem is described as
%_______________________________________________________________
%	Minimize   	Ofun(X)        :			[X] -> n x 1 vector             
%	Subject to	Gfun(X) <= 0.0	:		[Gfun] -> m x 1 vector          
% 	Subject to	Hfun(X) =  0.0 :		[Hfun] -> leq x 1 vector          
%               xl <= x  <= xu : i = 1...n    
%                                               
% Ofun.m , Gfun.m, Hfun.m, and FALM.m   must exist in the path 
% for the program to work
%______________________________________________________________
%
% The program uses DFP method for Unconstrained minimization
%						 golden section for 1 D minimization and requires
% the following files
%								DFP.m
%								Gold_Section_nVar,m
%								UpperBound_nVar.m
%								gradfunction.m
%
%____________________________________________________________


% some default values are found in the prompt (usually)
% some may need to be changed in the code
%
global lamda beta
global n m leq
global rh rg

format compact
format short e
warning off
ok = 1;
while(ok)   
   string1 = ['Input the starting design vector' ... 
    '\nThis is mandatory as there is no default vector setup' ...
    '\nThe length of your vector indicates the number of unknowns (n)' ...
    '\nPlease enter it now and hit return : for example [ 1 2 3 ...]\n'] ;
   
	xbegin = input(string1);
	fprintf('\n')
	      
 	if (isempty(xbegin) == 0)
      break;
   end
   fprintf('\n You need to input the starting values for the design tp proceed:\n')
end 

%fprintf('\n')
fprintf(' The initial design vector:\n');
disp(xbegin);
n = length(xbegin);

% Define the side constraints for the problem.
% the default values are 3 times the starting value on either side of the initial guess
%
clear string1;

ok = 1;
while(ok)
	string1 = ['\nInput the minimum values for the design vector. .' ...
      '\nThese are input as a vector. The default values are ' ...
      '\n3 * start value below the start value unless it is zero. '...
      '\nIn that case it is -5:\n'];
	Xmin = input(string1);
   
   if isempty(Xmin)==0 & n ==length(Xmin)
      for ix = 1:n
         if Xmin(ix) > xbegin(ix)
            fprintf('\n--Minimum value for %3i element exceeds starting value ',ix)
            fprintf('\n--Minimum value reset to starting value')
            Xmin(ix) = xbegin(ix)
         end
      end   
      break;
   elseif   isempty(Xmin) == 0 & n > length(Xmin) | n < length(Xmin)
      fprintf('\nLength for minimum values does not match the original length. Try again \n');
   elseif	isempty(Xmin) == 1
         for i = 1:n
            if xbegin(i) ~= 0.0, Xmin(i) = xbegin(i) - 3.0*abs(xbegin(i)); 
            else Xmin(i) = -5.0;
            end
         end
      	break;
    else
    end
end

fprintf('\nThe minimum values for the design variables are : ')
disp(Xmin)
fprintf('\n')

clear string1;

ok = 1;
while(ok)
	string1 = ['Input the maximum  values for the design vector.' ...
      '\nThese are input as a vector.  The default values are' ...
      '\n3 * start value above the start value.'...
      '\nIf start value is 0 then it is +5:\n'];
	Xmax = input(string1);
   
   if isempty(Xmax)==0 & n ==length(Xmax)
      for ix = 1:n
         if Xmax(ix) < xbegin(ix)
            fprintf('\n--Maximum value for %3i element is below starting value ',ix)
            fprintf('\n--maximum value reset to starting value')
            Xmax(ix) = xbegin(ix)
         end
      end 
      break;
   elseif   isempty(Xmax) == 0 & n ~= length(Xmax)
      fprintf('\nLength for maximum values does not match the original length. Try again \n');
   elseif	isempty(Xmax) == 1
         for i = 1:n
            if xbegin(i) ~= 0.0, Xmax(i) = xbegin(i) + 3.0*abs(xbegin(i)); 
            else Xmax(i) = 5.0;
            end
         end
      	break;
   else   
   end
end

fprintf('\nThe maximum values for the design variables are : ')
disp(Xmax)
fprintf('\n')
	
%	Default Values
%	m = 0; 	leq = 0;

leq = input('Number of equality constraints [0] :  ');
if isempty(leq)
   leq = 0;
else
   if leq ~= 0
      lamda = input('Initial values for lambda  :  ');
      end
end
fprintf('\n')

m = input('Number of inequality constraints [0] :  ');
if isempty(m)
   m = 0;
else
   if m ~= 0
      beta = input('Initial values for beta :  ');
      end
end
fprintf('\n')

% By default the function names are the ones defined at the outset of this file
% Objective function is found in OFun  
% Equality constraints will be found in Hfun vector
% Inequality constraints will be found in Gfun vector
% The unconstrained function is constructed in FALM

NS = 20; NU = 20; % SUMT and DFP iterations

% set some epsilon values for control
EPSXDIF = 1.0e-08; EPSFDIF = 1.0E-06; EPSGDIF = 1.0e-08; EPSHDIF = 1.0e-08;

% inputs for golden section and upper bound calculation
TOL = 1.0e-06; ALPHAL = 0; ASTEP = 1.0; NSTEP = 20;

% scaling factors for multipliers
ch = 10; cg = 10;


% initial estimate  for rh
rh =  1; rg = 1;


% calculate and store the starting values

fbegin = Ofun(xbegin);
if m > 0
   gVbegin = Gfun(xbegin);
   gAstore(1,:) = gVbegin;
   for j = 1:m
      g(j) = max(gVbegin(j),0);  
   end
   
   gError = g*g';
   gErr(1) = gError;
   if (gError ~= 0)
      rg = fbegin/gError;
   end
 end;
   

if leq> 0
   hVbegin = Hfun(xbegin);
   hAstore(1,:) = hVbegin;
   hError = hVbegin*hVbegin';
   hErr(1) = hError;
   if (hError ~= 0)
      rh = fbegin/hError;
   end
end;


% store values   
iter = 1;  
xstore(iter,:) = xbegin;
lamstore(iter,:) =lamda;
bstore(iter,:)=beta;
rhstore(iter) = rh;
rgstore(iter) = rg;
fVstore(iter) = fbegin;
FALMstore(iter)=FALM(xbegin);


% method starts here
xdes = xbegin;
COUNTLOOP = 0;
 fprintf('\nALM iteration number: '),disp(COUNTLOOP)
 fprintf('Design Vector (X) :  '),disp(xdes);
 fprintf('Objective function : '),disp(fbegin)
 fprintf('Square Error in constraints(h, g) : '),disp([hError gError])
 fprintf('Lagrange Multipliers (lamda beta): '),disp([lamda beta]);
 fprintf('Penalty Multipliers (rh rg): '),disp([rh rg]);
 fprintf('\n')

for outloop = 1:NS;				% outermost loop - based on NS (SUMT iteration)
 
   COUNTLOOP = COUNTLOOP + 1;
   xcur = xdes ;			% current x vector
   
   functname = char('FALM');
   fresult = DFP(functname,xcur,NU,TOL,ALPHAL,ASTEP,NSTEP);
   
   for ix = 1:n
      xnew(ix) = fresult(ix);
   end
   Fnew = fresult(n+1);
   
   fend = Ofun(xnew);
      if leq > 0,	hVend = Hfun(xnew);	end;
         
        
   iter = iter + 1;
   xstore(iter,:) = xnew;
   fVstore(iter) = fend;
   FALMstore(iter) = Fnew;
   if m > 0
      gVend = Gfun(xnew);
      gAstore(iter,:) = gVend;
      for j = 1:m
         g(j) = max(gVend(j),0);  
      end
   
      gError = g*g';
      gErr(iter) = gError;
   end;
   
   if leq > 0
     	hVend = Hfun(xnew);
      hAstore(iter,:) = hVend;
      hError = hVend*hVend';
      hErr(iter) = hError;
   end;
      
   xcur = xnew;
      
   % check for stopping and convergence
   
   fdiff = Fnew - FALMstore(iter - 1);;
   if m > 0,	gdiff = gErr(iter) - gErr(iter -1);	end;
   if leq > 0,	hdiff = hErr(iter) - hErr(iter -1);	end;
   
   
   % stop if irearations are exceeded
   if outloop == NS
   fprintf('maximumum number of iterations reached : %6i \n',NS);
     	if m > 0 & leq > 0 
      	fprintf('\n The values for x and f and g and h are : \n');
         disp([xstore fVstore' gErr' hErr']);
         
         fprintf('\n The values for lamda and beta are : \n');
         disp([lamstore' bstore']);

         
      elseif m > 0 
         fprintf('\n The values for x and f and g are : \n');
         disp([xstore fVstore' gErr']);
         
         fprintf('\n The values for beta are : \n');
         disp([bstore']);

         
      elseif leq > 0 
         fprintf('\n The values for x and f and h are : \n');
         disp([xstore fVstore' hErr']);
         
         fprintf('\n The values for lamda are : \n');
         disp([lamstore']);

      else
         fprintf('\n The values for x and f are : \n');
         disp([xstore fVstore']);
		end         
         
         
         
   break;
	end

   
   % convergence in changes in x      
   xdiff = (xnew-xdes)*(xnew-xdes)';
   if xdiff < EPSXDIF
      fprintf('X not changing : % 12.3E  reached in %6i iterations \n', ...
         xdiff, outloop);
           
      if m > 0 & leq > 0 
         fprintf('\n The values for x and f and g and h are : \n');
         disp([xstore fVstore' gErr' hErr']);
         
         fprintf('\n The values for lamda and beta are : \n');
         disp([lamstore bstore]);

         
      elseif m > 0 
         fprintf('\n The values for x and f and g are : \n');
         disp([xstore fVstore' gErr']);
         
         fprintf('\n The values for beta are : \n');
         disp([bstore']);

         
      elseif leq > 0
      	fprintf('\n The values for x and f and h are : \n');
         disp([xstore fVstore' hErr']);
         
         fprintf('\n The values for lamda and beta are : \n');
         disp([lamstore']);

         
      else 
         fprintf('\n The values for x and f are : \n');
         disp([xstore fVstore']);
      end        
   break;
	end
   
   if m > 0 & leq > 0
      if abs(fdiff) < EPSFDIF & abs(gdiff) <EPSGDIF & abs(hdiff) < EPSHDIF
        	fprintf('Convergence in f : % 14.3E  reached in %6i iterations \n', ...
         	abs(fdiff), outloop);
      	fprintf('\n The values for x and f and g are :\n');      
         disp([xstore fVstore' gerr' herr']);
         break;
      else
         fprintf('\nALM iteration number: '),disp(COUNTLOOP)
         fprintf('Design Vector (X) :  '),disp(xcur);
         fprintf('Objective function: '),disp(fend);
         fprintf('Error in constraints (h, g) : '),disp([hError gError])
         fprintf('Lagrange Multipliers (lamda beta): '),disp([lamda beta]);
         fprintf('Penalty Multipliers (rh rg): '),disp([rh rg]);
         fprintf('\n')
      end

    elseif m > 0      
       if abs(fdiff) < EPSFDIF & abs(gdiff) <EPSGDIF
        	fprintf('Convergence in f : % 14.3E  reached in %6i iterations \n', ...
         	abs(fdiff), outloop);
         fprintf('\n The values for x and f and g are :\n');      
         disp([xstore fVstore' gErr' ]);
         break;
      else
         disp([xcur fend gError beta rg]);
      end
      
   elseif leq > 0 
      
      if abs(fdiff) < EPSFDIF & abs(hdiff) <EPSHDIF
        	fprintf('Convergence in f : % 14.3E  reached in %6i iterations \n', ...
         	abs(fdiff), outloop);
            	fprintf('\n The values for x and f and h are :\n');      
         disp([xstore fVstore' hErr']);
         break;
      else
         disp([xcur fend hError ]);
      end

      
      
   else 
      if abs(fdiff) < EPSFDIF
         fprintf('Convergence in f : % 14.3E  reached in %6i iterations \n', ...
         	abs(fdiff), outloop);
      	fprintf('\n The values for x and f are :\n');      
         disp([xstore fVstore']);
         break;
      else
         %disp([xcur fend outloop]);
      end

           
   end
   xdes = xcur; 
   if leq >0
      lamda = lamda * 2*rh*hVend;
   end
   if m > 0
      for j = 1:m;
         beta(j) = beta(j) + 2*rg*max(gVend(j),-beta(j)/(2*rg));
      end
   end
   lamstore(iter,:) =lamda;
   bstore(iter,:)= beta;

   rh = rh*ch;
   rg = rg*cg;
   rhstore(iter) = rh;
	rgstore(iter) = rg;

   
end
  