% Optimization Using MATLAB, Chapter 9
% Dr. P.Venkataraman
% Chapter: 9, Section 9.3
% Genetic Algorithm

function ret = GeneticAlgorithm(nDes, nG, nPi, nP, nSC, nAC, nDC, nI)

global nBez A XX YY   % problem dependent
global xv1 yv1 xv2 yv2  % problem dependent

%----Storage Parameters
% Xinit(nP,nDes); Finit(nP)  -holds initial population
% Xgen(nP+2*nSC+2*AC+nDC+NI,nDes); Fgen(nP+2*nSC+2*AC+nDC+NI,nDes)
%  generated values - currently allows nSc= nAC = nDc = 1
% Xfinal(nP,nDes); Ffinal(nP);
% Xbest(nG,nDes); Fbest(nG)
%------------------------------------------------------------
fprintf('\nEntered Genetic Algorithm')
iG = 1;
% Generate initial population
for j = 1:nPi
   Vect = populator(nDes);
   %length(Vect);
   Xvect = [xv1 yv1 Vect xv2 yv2];
   fin = Bez_Sq_Err(Vect);
   Xdummy(j,:)=Vect;
   Fdummy(j)=fin;
end

fprintf('\nfinished initial population')
[Yvect,Ip]=sort(Fdummy);  % MATLAB sort function sorts in ascending order
% and returns indices too

% store starting population set
% store the same set as parents for the generation
for i = 1:nP
   Xinit(i,:)=Xdummy(Ip(i),:);
   Finit(i)= Yvect(i);
   Xgen(i,:) = Xinit(i,:);
   Fgen(i)=Finit(i);
end
Xbest(iG,:)=Xinit(1,:);
Fbest(iG)=Finit(1);
dvect = Xinit(1,:);
DrawCurve(dvect,1);
pause(2)

for iG = 1:nG
% start generating children and immigrants
% ***************
% Simple crossover
%*****************
fprintf('\nGeneration number :'), disp(iG)
	[XChild] = SimpleCrossover(nDes, nP,nSC,Xgen);

	for i=1:2*nSC
   	Xgen(nP+i,:) = XChild(i,:);
	end
	fprintf('\nfinished Simple Crossover')
%size(Xgen)
% ***************
% Arithmetic crossover
%*****************

	[XAChild] = ArithmeticCrossover(nDes, nP,nAC,Xgen);
	for i=1:2*nAC
   	Xgen(nP+2*nSC+i,:) = XAChild(i,:);
	end
%size(Xgen)
	fprintf('\nfinished Arithmetic Crossover')

% ***************
% Directional crossover
%*****************

	[XDChild] = DirectionalCrossover(nDes,nP,nDC,Xgen,Fgen);

%XDChild

	for i=1:nDC
   	Xgen(nP+2*nSC+2*nAC+i,:) = XDChild(i,:);
	end
	fprintf('\nfinished Directional Crossover')
	[n1 m1] = size(Xgen);


%**********************
%  Mutation
%*************************
	[n1 m1] = size(Xgen);
	[XMu]= Mutation(nDes,Xgen);

	for i=1:n1
   	Xgen(nP+2*nSC+2*nAC+nDC+i,:) = XMu(i,:);
	end
	fprintf('\nfinished Mutation')

%************************
%  Immigrants
%***********************

	[n2 m2] = size(Xgen);
	for j = 1:nI
   	Vect = populator(nDes);
   	Xgen(n2+j,:) = Vect;
	end
	fprintf('\nfinished Immigrants\n')

	clear Fdummy Xdummy Yvect Ip
	[n3 m3] = size(Xgen);
	for i = 1:n3
   	Vect = Xgen(i,:);
   	fin = Bez_Sq_Err(Vect);
   	Xdummy(i,:)=Vect;
   	Fdummy(i)=fin;
	end


	[Yvect,Ip]=sort(Fdummy); 
%Yvect
	Xbest(iG+1,:)=Xdummy(Ip(1),:);
	Fbest(iG+1)=Yvect(1);
dvect =Xdummy(Ip(1),:);
DrawCurve(dvect,iG+1);
pause(2)
% return best value

% clear Xgen values and repopulate for the next generation
	clear Xgen Fgen XChild XAChild XDChild XMu
	for i = 1:nP
   	Xinit(i,:)=Xdummy(Ip(i),:);
   	Finit(i)= Yvect(i);
   	Xgen(i,:) = Xinit(i,:);
   	Fgen(i)=Finit(i);
	end

	
end
ret = [Xbest Fbest'];