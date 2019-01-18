%  Applied Optimization with MATLAB
%  Dr. P.Venkataraman
%  Chapter 7, Section 7.3.3
%  Generalized Reduced Gradient Method
%  Example 7.1
%  
% The input is the current design vector
% and two values of alpha to perform a quadratic interpolation
%
format compact
format short e
%****************************************************************
%*  define analytical functions
%*	 remember to use vectors for g and h if more than one of them
%*	 and modify code
%**************************************************************
syms f g x1 x2 x3 gradx1 gradx2 gradx3 
syms h2 h2x1 h2x2  h2x3 h1 h1x1 h1x2 h1x3
% the functions
f = x1^4 -2*x1*x1*x2 + x1*x1 + x1*x2*x2 - 2*x1 + 4;
g = 0.25*x1*x1 + 0.75*x2*x2 - 1 ;
h2 = g + x3;
h1 = x1*x1 + x2*x2 -2;
%*****************************************************************
%  input the design vector
string1 = ['Input the feasible design chosen for evaluation.\n'] ;

xs = input(string1);
xs(3) = -subs(g,{x1,x2},{xs(1),xs(2)});
fprintf('\nThe design vector [%10.4f  %10.4f %10.4f]\n',xs);


% the gradients
gradx1 = diff(f,x1);
gradx2 = diff(f,x2);
gradx3 = diff(f,x3);
h2x1 = diff(h2,x1);
h2x2 = diff(h2,x2);
h2x3 = diff(h2,x3);
h1x1 = diff(h1,x1);
h1x2 = diff(h1,x2);
h1x3 = diff(h1,x3);

% evaluate the function, gradients , and hessian at the current design
fv = double(subs(f,{x1,x2,x3},{xs(1),xs(2),xs(3)}));
h1v = double(subs(h1,{x1,x2,x3},{xs(1),xs(2),xs(3)}));
gv = double(subs(g,{x1,x2,x3},{xs(1),xs(2),xs(3)}));
h2v = double(subs(h2,{x1,x2,x3},{xs(1),xs(2),xs(3)}));
fprintf('\nfunction and constraints(f h1 h2):\n '),disp([fv h1v h2v])

dfx1 = double(subs(gradx1,{x1,x2,x3},{xs(1),xs(2),xs(3)}));
dfx2 = double(subs(gradx2,{x1,x2,x3},{xs(1),xs(2),xs(3)}));
dfx3 = double(subs(gradx3,{x1,x2,x3},{xs(1),xs(2),xs(3)}));

dh2x1 = double(subs(h2x1,{x1,x2,x3},{xs(1),xs(2),xs(3)}));
dh2x2 = double(subs(h2x2,{x1,x2,x3},{xs(1),xs(2),xs(3)}));
dh2x3 = double(subs(h2x3,{x1,x2,x3},{xs(1),xs(2),xs(3)}));

dh1x1 = double(subs(h1x1,{x1,x2,x3},{xs(1),xs(2),xs(3)}));
dh1x2 = double(subs(h1x2,{x1,x2,x3},{xs(1),xs(2),xs(3)}));
dh1x3 = double(subs(h1x3,{x1,x2,x3},{xs(1),xs(2),xs(3)}));

%matrix A and B
A = [dh1x1; dh2x1]
B = [dh1x2 dh1x3; dh2x2 dh2x3]

C = inv(B)*A;
Gr = dfx1 - C'*[dfx2 ;dfx3];

for jj = 1:3
S = -Gr
	if (jj < 3)
		string1 = ['\nInput the stepsize for evaluation.\n'] ;
		alpha = input(string1)
		aa(jj+1) = alpha;
%******************
%  for a given stepsize - Y calculation
%***************
	end

	dz = alpha*S;
	xn1 = xs(1) + dz;
	yn = [xs(2) xs(3)]';
	dy = -C*dz;
	for i = 1: 40
  		yn = yn + dy;
  		xn = [xn1 yn(1) yn(2)];
  		h1n = double(subs(h1,{x1,x2,x3},{xn(1),xn(2),xn(3)}));
  		h2n = double(subs(h2,{x1,x2,x3},{xn(1),xn(2),xn(3)}));
  		hsq = h1n*h1n + h2n*h2n;
  		if hsq <= 1.0e-08
    		 break
  		else
     		dy = inv(B)*[-h1n -h2n]';
  		end
	end
	fprintf('\nNo. of iterations and constraint error: '),disp(i),disp([alpha hsq]);
	fprintf('\ndesign vector: '),disp(xn)
	h1n = double(subs(h1,{x1,x2,x3},{xn(1),xn(2),xn(3)}));
	h2n = double(subs(h2,{x1,x2,x3},{xn(1),xn(2),xn(3)}));
   fn = double(subs(f,{x1,x2,x3},{xn(1),xn(2),xn(3)}));
   fprintf('\nfunction and constraints (f h1 h2)\n '),disp([fn h1n h2n])

  
  	ff(jj+1)=fn;  
  
  	if (jj == 2)
     aa(1) = 0; rhs(1) = fv;
     amat = [1 0 0; 1 aa(2) aa(2)^2; 1 aa(3) aa(3)^2];
     rhs=[fv ff(2) ff(3)]';
     xval = inv(amat)*rhs;
     alpha = -xval(2)/(2*xval(3))
  end
     
end
