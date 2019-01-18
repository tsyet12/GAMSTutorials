% Optimization Using MATLAB, Chapter 9
% Dr. P.Venkataraman
% Chapter: 9, Section 9.2
% Simulated Annealing
%	
% An m-file for Calling the  Simulated Annealing Program
%************************************************
% requires:     	SimulatedAnnealing.m	
%						UpperBound_nVar.m
%						GoldSection_nVar.m
%	and the problem m-file: Example9_1.m  (for example)
%  the problem file for plotting Example9_1plot.m (for example)
%  Example9_1plot must be changed to the appropriate example 
% prior to running Call_SA
%*************************************************
%-----------------------------------------------------------

miter = 10000;  % number of iterations
xinit = [-4 4];
tol = 0.001;	% tolerance for golden section search
astart = 0;		% starting alpha for scanning
step = 1;		% scanning step
msteps = 10;	% max steps for scanning
%-----------------------------------
format compact;
clf % clear figure
clc
%**************************************************
% Please check the function name to ensure which problem is solved
% User needs to make changes in the plotting segment
% of SimulatedAnnealing.m for 2 variable problem
% so that the corresponding function is also plotted
%****************************************************
SimulatedAnnealing('Example9_2',xinit,miter, tol, astart,step ,msteps)

