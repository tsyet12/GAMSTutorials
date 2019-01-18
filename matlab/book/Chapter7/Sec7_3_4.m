%  Applied Optimization with MATLAB
%  Dr. P.Venkataraman
%  Chapter 7, Section 7.3.4
%  Sequential Gradient Restoration Algorithm
%  Example 7.1
%  
% The Gradient phase needs a feasible starting point
% 
%
format compact
format short e
%****************************************************************
%*  define analytical functions
%*	 remember to use vectors for g and h if more than one of them
%*	 and modify code to handle vectors
%**************************************************************
syms f g x1 x2 gradx1 gradx2 
syms p1 p1x1 p1x2 p2 p2x1 p2x2 
% the functions
f = x1^4 -2*x1*x1*x2 + x1*x1 + x1*x2*x2 - 2*x1 + 4;
p1 = x1*x1 + x2*x2 -2;
p2 = 0.25*x1*x1 + 0.75*x2*x2 - 1 ;

% active constraint strategy uses p2 only if active or violated

%*****************************************************************
%  input the design vector
string1 = ['Input the feasible design chosen for evaluation.\n'] ;

xs = input(string1);
fprintf('\nThe design vector [%10.4f  %10.4f]\n',xs);


% the gradients
gradx1 = diff(f,x1);
gradx2 = diff(f,x2);

p2x1 = diff(p2,x1);
p2x2 = diff(p2,x2);

p1x1 = diff(p1,x1);
p1x2 = diff(p1,x2);


% evaluate the function, gradients 
fv = double(subs(f,{x1,x2},{xs(1),xs(2)}));
p1v = double(subs(p1,{x1,x2},{xs(1),xs(2)}));
p2v = double(subs(p2,{x1,x2},{xs(1),xs(2)}));
fprintf('\nfunction and constraints(f h1 h2):\n '),disp([fv p1v p2v])

dfx1 = double(subs(gradx1,{x1,x2},{xs(1),xs(2)}));
dfx2 = double(subs(gradx2,{x1,x2},{xs(1),xs(2)}));

dp2x1 = double(subs(p2x1,{x1,x2},{xs(1),xs(2)}));
dp2x2 = double(subs(p2x2,{x1,x2},{xs(1),xs(2)}));

dp1x1 = double(subs(p1x1,{x1,x2},{xs(1),xs(2)}));
dp1x2 = double(subs(p1x2,{x1,x2},{xs(1),xs(2)}));

%*********************
% gradient phase
%*********************
fprintf('***********************');
fprintf('\n Gradient Phase     \n');
fprintf('***********************');

% set up the phi vector based on constraint values

if abs(p2v) <= 1.0e-04	
   phi = [p1v; p2v];
else 
   phi = [p1v];
end

% set up the phix matrix
if abs(p2v) <= 1.0e-04
   phix = [dp1x1 dp2x1; dp1x2 dp2x2];
else
   phix = [dp1x1 ; dp1x2];
end

% solve for lambda from the linear equations

A = phix'*phix;
b = phix'*[dfx1 dfx2]';
lamda = -inv(A)*b;

fprintf('\nThe Lagrange multipliers\n'),disp(lamda)
   
% gradient of the Lagrangian
gradF = [dfx1 dfx2]' + phix*lamda ;  

% quadratic interpolation (not cubic)
FX(1) = gradF'*gradF
al(1) = 0;
% seek user input for alpha to use for scanning
string1 = ['\nInput the stepsize for evaluation.\n'] ;
alpha = input(string1);

for kk = 1:2
% start scanning
j = 1;
for i = 1:10
   xn = xs' - alpha*gradF;
   dfx1n = double(subs(gradx1,{x1,x2},{xn(1),xn(2)}));
	dfx2n = double(subs(gradx2,{x1,x2},{xn(1),xn(2)}));

	dp2x1n = double(subs(p2x1,{x1,x2},{xn(1),xs(2)}));
	dp2x2n = double(subs(p2x2,{x1,x2},{xs(1),xs(2)}));

	dp1x1n = double(subs(p1x1,{x1,x2},{xn(1),xn(2)}));
	dp1x2n = double(subs(p1x2,{x1,x2},{xn(1),xn(2)}));

	% set up the phix matrix
	if p2v >= 0
   	phixn = [dp1x1n dp2x1n; dp1x2n dp2x2n];
	else
   	phixn = [dp1x1n ; dp1x2n];
   end
   
   if kk == 2
      fn = double(subs(f,{x1,x2},{xn(1),xn(2)}));
		p1n = double(subs(p1,{x1,x2},{xn(1),xn(2)}));
		p2n = double(subs(p2,{x1,x2},{xn(1),xn(2)}));
	
		if p2v >= 0	
      	phi = [p1n; p2n];
      	
		else 
   		phi = [p1n];
      end
      P = phi'*phi;
	end
   gradFn = [dfx1n dfx2n]' + phixn*lamda ;
   gF2 = gradFn'*gradFn
   
   if kk == 2; break; end
   
   if gF2 < FX(j)
      if j == 1
      	al(j+1) =alpha;
      	FX(j+1) = gF2;
         j=j+1;
         alpha = 2*alpha;
      end
   else
      if j > 1
         al(j + 1) = alpha;
         FX(j+1) = gF2;
         j = j+1;
         
         if j == 3;
            break
         end
         alpha = 2*alpha;
      else
         if j == 1
            alpha = 0.5*alpha;
            if(i == 10)
               fprintf('\n cannot decrease function - chooses another point\n')
            end
            
         end
         
      end
   end
end
% quadratic interpoltion
kk
i
if kk == 2, break; end
if (i < 10)
   
	amat = [1 0 0; 1 al(2) al(2)^2; 1 al(3) al(3)^2];
	rhs=FX';
	xval = inv(amat)*rhs;
	alpha = -xval(2)/(2*xval(3));
end

end
fprintf('\nalpha for quadratic interpolation\n'),disp(al)
fprintf('\nfunction values for quadratic interpolation\n'),disp(FX)
fprintf('\noptimum alpha:  '),disp(alpha)
fprintf('\nThe design vector [%10.4f  %10.4f]\n',xn);
fprintf('\nfunction and constraints(f h1 h2):\n '),disp([fn p1n p2n])
fprintf('\nThe performance indices Q, P):\n '),disp([gF2 P])


%********************************
%	Restoration phase
%********************************8
% set up the phi vector based on constraint values
fprintf('***********************');
fprintf('\n Restoration Phase     \n');
fprintf('***********************');

p2nn = p2n;
P2 = sqrt(P);
for i = 1:30
   dfx1n = double(subs(gradx1,{x1,x2},{xn(1),xn(2)}));
	dfx2n = double(subs(gradx2,{x1,x2},{xn(1),xn(2)}));

	dp2x1n = double(subs(p2x1,{x1,x2},{xn(1),xs(2)}));
	dp2x2n = double(subs(p2x2,{x1,x2},{xs(1),xs(2)}));

	dp1x1n = double(subs(p1x1,{x1,x2},{xn(1),xn(2)}));
	dp1x2n = double(subs(p1x2,{x1,x2},{xn(1),xn(2)}));

	% set up the phix matrix
	if p2nn >= 0
   	phixn = [dp1x1n dp2x1n; dp1x2n dp2x2n];
	else
   	phixn = [dp1x1n ; dp1x2n];
   end
   
   fn = double(subs(f,{x1,x2},{xn(1),xn(2)}));
   p1n = double(subs(p1,{x1,x2},{xn(1),xn(2)}));
	p2n = double(subs(p2,{x1,x2},{xn(1),xn(2)}));
	
	if p2nn >= 0	
      phi = [p1n; p2n];	
	else 
   	phi = [p1n];
   end
   P = phi'*phi;
   if P <= 1.0e-08, break; end
	

	sigma =0.5*inv(phixn'*phixn)*phi;
   xn = xn - phixn'*sigma;

end
fprintf('\n Number of Restoration iterations: '),disp(i);
fprintf('\nThe design vector [%10.4f  %10.4f]\n',xn);
fprintf('\nfunction and constraints(f h1 h2):\n '),disp([fn p1n p2n])
fprintf('\nThe performance index P):\n '),disp([P])