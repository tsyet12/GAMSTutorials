%  Applied Optimization with MATLAB
%  Dr. P.Venkataraman
%  Chapter 7, Section 7.3.2
%  Sequential Quadratic Prgramming
%  Example 7.1
%  
%	The input is the current design vector
% output to the Command Window is the result of
% applying the KT conditions analytically
% to the QP subproblem. Results for 2 casea
% Case (a) : beta = 0 g < 0
% Case (b) : beta ~= 0, g = 0
% select the right one and rerun the program
% (after all this is a Sequential program)
%
format compact
format short e
%****************************************************************
%*  define analytical functions
%*	 remember to use vectors for g and h if more than one of them
%**************************************************************
syms f x1 x2 gradx1 gradx2 x1d x2d hess
syms g gx1 gx2 h hx1 hx2
% the functions
f = x1^4 -2*x1*x1*x2 + x1*x1 + x1*x2*x2 - 2*x1 + 4;
g = 0.25*x1*x1 + 0.75*x2*x2 - 1;
h = x1*x1 + x2*x2 -2;
%*****************************************************************
%  input the design vector
% enter the value for design vector scanned from command window
string1 = ['Input the design vector chosen for evaluation.\n'] ;


xs = input(string1);
fprintf('\nThe design vector [ %10.4f  %10.4f]\n',xs);


% the gradients
gradx1 = diff(f,x1);
gradx2 = diff(f,x2);
gx1 = diff(g,x1);
gx2 = diff(g,x2);
hx1 = diff(h,x1);
hx2 = diff(h,x2);

% the hessian
hess = [diff(gradx1,x1), diff(gradx1,x2); diff(gradx2,x1), diff(gradx2,x2)];

% evaluate the function, gradients , and hessian at the current design
fv = double(subs(f,{x1,x2},{xs(1),xs(2)}));
hv = double(subs(h,{x1,x2},{xs(1),xs(2)}));
gv = double(subs(g,{x1,x2},{xs(1),xs(2)}));
dfx1 = double(subs(gradx1,{x1,x2},{xs(1),xs(2)}));
dfx2 = double(subs(gradx2,{x1,x2},{xs(1),xs(2)}));
dgx1 = double(subs(gx1,{x1,x2},{xs(1),xs(2)}));
dgx2 = double(subs(gx2,{x1,x2},{xs(1),xs(2)}));
dhx1 = double(subs(hx1,{x1,x2},{xs(1),xs(2)}));
dhx2 = double(subs(hx2,{x1,x2},{xs(1),xs(2)}));
hessv = double(subs(hess,{x1,x2},{xs(1),xs(2)}));

fprintf('The objective function: '),disp(fv);
fprintf('The equality constraint: '),disp(hv);
fprintf('The inequality constraint: '),disp(gv);
fprintf('The Hessian of the objective: \n'),disp(hessv);

% the QP subproblem
syms fquad glin hlin dx1 dx2
fquad = fv + [dfx1 dfx2]*[dx1; dx2] + 0.5*[dx1 dx2]*hessv*[dx1 ;dx2];
hlin = hv + [dhx1 dhx2]*[dx1; dx2];
glin = gv + [dgx1 dgx2]*[dx1; dx2];

% define Lagrangian for the QP problem
syms F lamda beta
F = fquad + lamda*hlin + beta*glin;

fprintf('\n Case a: beta = 0\n');
Fnobeta = fquad + lamda*hlin;

xcasea = solve(diff(Fnobeta,dx1),diff(Fnobeta,dx2),hlin);
sola = [double(xcasea.dx1) double(xcasea.dx2) double(xcasea.lamda)];
dx1a = double(xcasea.dx1);
dx2a = double(xcasea.dx2);
hlina = double(subs(hlin,{dx1,dx2},{dx1a,dx2a}));
glina = double(subs(glin,{dx1,dx2},{dx1a,dx2a}));

x1a = dx1a + xs(1);
x2a = dx2a + xs(2);
fv = double(subs(f,{x1,x2},{x1a,x2a}));
hv = double(subs(h,{x1,x2},{x1a,x2a}));
gv = double(subs(g,{x1,x2},{x1a,x2a}));
fprintf('Change in design vector: '),disp([dx1a dx2a]);
fprintf('New design vector: '),disp([x1a x2a]);
fprintf('The objective function: '),disp(fv);
fprintf('The equality constraint: '),disp(hv);
fprintf('The inequality constraint: '),disp(gv);

fprintf('\n Case b: g = 0\n');
xcaseb = solve(diff(F,dx1),diff(F,dx2),hlin,glin);
solb = [double(xcaseb.dx1) double(xcaseb.dx2) double(xcaseb.lamda) double(xcaseb.beta)];
dx1b = double(xcaseb.dx1);
dx2b = double(xcaseb.dx2);
hlinb = double(subs(hlin,{dx1,dx2},{dx1b,dx2b}));
glinb = double(subs(glin,{dx1,dx2},{dx1b,dx2b}));

x1b = dx1b + xs(1);
x2b = dx2b + xs(2);
fv = double(subs(f,{x1,x2},{x1b,x2b}));
hv = double(subs(h,{x1,x2},{x1b,x2b}));
gv = double(subs(g,{x1,x2},{x1b,x2b}));
fprintf('Change in design vector: '),disp([dx1b dx2b]);
fprintf('New design vector: '),disp([x1b x2b]);
fprintf('The objective function: '),disp(fv);
fprintf('The equality constraint: '),disp(hv);
fprintf('The inequality constraint: '),disp(gv);
fprintf('Multiplier beta: '),disp(double(xcaseb.beta));


%Fnobeta = fquad + lamda*hlin

%xcasea = solve(diff(Fnobeta,dx1),diff(Fnobeta,dx2),hlin);
%sola = [double(xcasea.dx1) double(xcasea.dx2) double(xcasea.lamda)]
