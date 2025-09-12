clear;
clc;

FEM=DYNAMIC("Dynamic_study_1");	    % Define a new dynamic study
FEM.ReadMesh("strip_tri.msh");      % Mesh File Input
FEM.Mat(1)=MATDat("Mat.dat.txt");   % Material file name input

t=linspace(0,10,10001);             
w=40;
x=1*sin(w*t);				    

FEM.T=FEMTime(0.01,1);	%Solution time 1s,Time step size 0.01 
FEM.TS=TimeSeries(t,x);    %To define Time series

FEM.Pc(1) =  ProbeOnCod([0.5,10],[1 0 0]);
 % Probe(1) defined on coordinate (0.5,10) for w disp

FEM.Up(1)=DirichletOnPhyEn(FEM, [11], [1 0 0], 0  );
FEM.Up(2)=DirichletOnPhyEn(FEM, [12], [1 0 0], 0  );
 % 0 displacement of Physical Entities 11 and 12

FEM.Fp(1)=NeumannOnPhyEn(FEM, [21 22 23 24], [1 0 0], 1000);
  % 1000 N/m^-2 on Physical Entities 21, 22, 23 and 24

  %%% To set loads, displacement and to describe domain
FEM.ApplyF(FEM. Fp(1)*FEM.TS     )
FEM.ImposeU( FEM. Up(1)*FEM.TS  )
FEM.ImposeU( FEM. Up(2)  )
FEM.SetDomain([1 21 22 23 24],[1],'BCIZ2');

 %% To set intial displacement and velocity zero
FEM.InitialX('zero');
FEM.InitialV('zero');

 %% To solve using newmark algorithm
FEM.SolveLU();
 %% To write .POS file
FEM.WritePos();
 %% To write probe data into a file
FEM.WriteProbe();