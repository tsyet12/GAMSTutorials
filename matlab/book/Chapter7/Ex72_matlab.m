% Ex. 7.2
% using MATLAB fmincom unction
%
x0 = [0.55 0.5];
lb = [0.02 0.02];
ub = [1.0 1.0];
%x = fmincon('Ofun_741',x0,[],[],[],[],lb,ub,'Con_741_matlab')
x = constr('Con_741_matlab',x0)