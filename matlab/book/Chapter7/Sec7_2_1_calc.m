% 
% Optimization with MATAB; Dr P.Venkataramana=
% Chapter 7 Section 7.2.1
% External Penalty Function Method
% Symbolic Calculations (partial)
% Example 7.1

format compact

% define the functions
syms x1 x2 rh rg f g h F grad1 grad2

f = x1^4 - 2*x1*x1*x2 + x1*x1 + x1*x2*x2 - 2*x1 + 4;
h = x1*x1 + x2*x2 - 2;
g = 0.25*x1*x1 +0.75*x2*x2 -1;

% the unconstrained function
F = f + rh*h*h + rg*g*g;

% gradients of the unconstrained function
grad1 = diff(F,x1);
grad2 = diff(F,x2);


% choose values for rh and rg
fprintf('\n')
rh = input('enter value for rh [default = 1] :  ');
if isempty(rh)
   rh = 1;
end

fprintf('\n')
rg = input('enter value for rg [default = 1] :  ');
if isempty(rg)
   rg = 1;
end

% solve for x1 and x2
sol = solve(subs(grad1), subs(grad2));

%display all the solutions to choose 1
[double(sol.x1) double(sol.x2)] 

% enter the value for design vector scanned from command window
string1 = ['Input the design vector chosen for evaluation.\n'] ;

xs = input(string1);
fprintf('\nThe design vector [ %10.4f  %10.4f ]',xs);

fv = subs(f,{x1,x2},{xs(1),xs(2)});
hv = subs(h,{x1,x2},{xs(1),xs(2)});
gv = subs(g,{x1,x2},{xs(1),xs(2)});
fprintf('\nobjective function:  '), disp(fv)
fprintf('\nequality constraint:  '), disp(hv)
fprintf('\ninequality constraint:  '), disp(gv)

   



