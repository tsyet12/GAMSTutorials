% Optimization Using MATLAB, Chapter 9
% Dr. P.Venkataraman
% Chapter: 9, Section 9.3
% Genetic Algorithm
%	
% An m-file for Calling the  Genetic Algorithm Program
%************************************************
% requires:     	GeneticAlgorithm.m	
%					populator.m
%                   SimpleCrossover.m
%                   ArithmeticCrossover.m
%                   DirectionalCrossover.m
%                   Mutation.m
%                   DrawCurve.m
%*************************************************
%*********************
% Problem/Example Dependent
%       coeef.m
%       Factorial.m
%       Combination.m
%       Bez_Sq_Error.m
%**********************

global nBez A XX YY 
global xv1 yv1 xv2 yv2
clc
format compact
format long

%********************************
% Example Specific Information
% create data for Example 9.3
% this is the data to be fitted
for i = 1:100
	XX(i)=i*0.02;
   YY(i)=1 +0.25*XX(i) + 2*cos(3*XX(i))*exp(-XX(i));
end

% nBez : order of the Bezier Curve
nBez= 5;

% A : containsthe coefficients of the curve 
% this is a one time calculation
% it is  done here as preprocessing
A = coeff(nBez);

% set up vertices
% the first and last vertex are the same as the first
% and last data point
nData = length(XX);
xv1 = XX(1);
xv2 = XX(nData);
yv1 = YY(1);
yv2 = YY(nData);
nDes = 8;

%number of design variables
%******Example Specific Information over
%****************************************

%**** GA parameters
nG = 50;    % total number of  generation
nPi= 10;	  % population during the start of the generation
nP =  2;    % population for each generation   
nSC = 1;	  % number of simple crossover - each yields 2 children
nAC = 1;   % number of arithmetic crossover - each yields 2 children
nDC = 1;   % number directional crossover
nI  = 6;	  % number of immigrants

%--------------------------------------
[Xbest] = GeneticAlgorithm(nDes, nG, nPi, nP, nSC, nAC, nDC, nI);
%--------------------------------------
[n m] = size(Xbest);
Xbest(:,m)'