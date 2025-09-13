%% Strip with hormonic load
clear;
clc;


load("er.mat")

FEM=DYNAMIC("Dynamic_Rad1");
FEM.ReadMesh("meshes\strip.msh");
FEM.Mat(1)=MATDat("Mat.dat.txt",FEM.lg);


t1=tSimu(1:end)';
x1=DisturbanceOFF(1:end)';

t2=tSimu(1:end-500)';
x2=DisturbanceOFF(501:end)';

t3=tSimu(1:end-2000)';
x3=DisturbanceOFF(2001:end)';


%FEM.Pn(1)=ProbeOnNode(12,[1 0 0]);
FEM.P(1)=ProbeOnPhyEn(21,[1 0 0]);
FEM.P(2)=ProbeOnPhyEn(22,[1 0 0]);
FEM.P(3)=ProbeOnPhyEn(23,[1 0 0]);
FEM.P(4)=ProbeOnPhyEn(24,[1 0 0]);

FEM.Pn(1)=ProbeOnNode(4,[1 0 0]);
FEM.Pn(2)=ProbeOnNode(83,[1 0 0]);
FEM.Pn(3)=ProbeOnNode(3,[1 0 0]);


FEM.T=FEMTime(0.005,10);
FEM.TS(1)=TimeSeries(t1,x1);
FEM.TS(2)=TimeSeries(t2,x2);
FEM.TS(3)=TimeSeries(t3,x3);
%FEM.TS(4)=TimeSeries(t,x4);

FEM.Un(1)=DirichletOnNode(FEM, [1], [1 0 0], 0.001 );
FEM.Un(2)=DirichletOnNode(FEM, [27], [1 0 0], 0.001 );
FEM.Un(3)=DirichletOnNode(FEM, [2], [1 0 0], 0.001 );
FEM.U(1)=Dirichlet(FEM, [12], [1 0 0], 0 );

%FEM.U(2)=Dirichlet(FEM, [11], [1 0 0], 1 );
%FEM.For(1)=Neumann(FEM, [21], [1 0 0], 1000 );
%FEM.For(2)=Neumann(FEM, [22], [1 0 0], 1000 );
%FEM.For(3)=Neumann(FEM, [23], [1 0 0], 1000 );
%FEM.For(4)=Neumann(FEM, [24], [1 0 0], 1000 );
%
%FEM.ImposeU( FEM. U(2) * FEM.TS(1)  );

FEM.ImposeU( FEM. U(1)  );
FEM.ImposeU( FEM. Un(1) *  FEM.TS(1) );
FEM.ImposeU( FEM. Un(2) *  FEM.TS(2) );
FEM.ImposeU( FEM. Un(3) *  FEM.TS(3) );



%FEM.ApplyF(FEM.For(1)*FEM.TS(1));
%FEM.ApplyF(FEM.For(2)*FEM.TS(2));
%FEM.ApplyF(FEM.For(3)*FEM.TS(3));
%FEM.ApplyF(FEM.For(4)*FEM.TS(4));









% 

% 
 FEM.SetDomain([1 21 22 23 24],[1],'MITC4');
% 
 FEM.InitialX('zero');
 FEM.InitialV('zero');
% 
 tic;
 FEM.SolveLU();
 toc;
% 
 FEM.WritePos();
 FEM.WriteProbe();
 FEM.PlotProbe();
 %FEM.WriteX();

X=FEM.X;
name = sprintf('%s_X.mat',FEM.StudyName);
save(name,'X')



 
load gong
sound(y,Fs)

 disp("done!!!  :-)")