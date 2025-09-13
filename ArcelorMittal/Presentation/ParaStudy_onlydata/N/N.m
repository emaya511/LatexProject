%% Strip with hormonic load
clear;
clc;
%Ni=["0E1","1E2","1E3","1E4","1E5","1E6","1E7","3E7"];
Ni=["1E2","1E3","1E4","1E5","1E6","1E7"];
%Ni=["0E1","3E7"];
for i = 1 : numel(Ni)
    
    
    name=strcat(Ni(i),'\Dynamic');
    %FEM=DYNAMIC("7000\Dynamic");
    FEM=DYNAMIC(name);
    FEM.lg.lgit(sprintf('** Solving for Rho : %s',Ni(i)))
    FEM.ReadMesh("meshes\strip.msh");
    name=strcat(Ni(i),"\Mat.dat.txt");
    FEM.Mat(1)=MATDat(name);

    
    t=linspace(0,10,2001);

    w1=40;
    w2=10;
    w3=30;
    w4=20;
    x1=0.01*sin(w1*t);
    x2=0.01*sin(w2*t);
    x3=0.01*sin(w3*t);
    x4=0.01*sin(w4*t);

    %FEM.Pn(1)=ProbeOnNode(12,[1 0 0]);
    FEM.P(1)=ProbeOnPhyEn(21,[1 0 0]);
    FEM.P(2)=ProbeOnPhyEn(22,[1 0 0]);
    FEM.P(3)=ProbeOnPhyEn(23,[1 0 0]);
    FEM.P(4)=ProbeOnPhyEn(24,[1 0 0]);
    
    FEM.Pn(1)=ProbeOnNode(4,[1 0 0]);
    FEM.Pn(2)=ProbeOnNode(83,[1 0 0]);
    FEM.Pn(3)=ProbeOnNode(3,[1 0 0]);


    FEM.T=FEMTime(0.005,3);
    FEM.TS(1)=TimeSeries(t,x1);
    FEM.TS(2)=TimeSeries(t,x2);
    FEM.TS(3)=TimeSeries(t,x3);
    FEM.TS(4)=TimeSeries(t,x4);

    %FEM.Un(1)=DirichletOnNode(FEM, [1], [1 0 0], 0 );
    %FEM.Un(2)=DirichletOnNode(FEM, [10], [1 0 0], 0 );
    %FEM.Un(3)=DirichletOnNode(FEM, [2], [1 0 0], 0 );
    FEM.U(1)=Dirichlet(FEM, [12], [1 0 0], 0 );
    FEM.U(2)=Dirichlet(FEM, [11], [1 0 0], 1 );
    %FEM.For(1)=Neumann(FEM, [21], [1 0 0], 1000 );
    %FEM.For(2)=Neumann(FEM, [22], [1 0 0], 1000 );
    %FEM.For(3)=Neumann(FEM, [23], [1 0 0], 1000 );
    %FEM.For(4)=Neumann(FEM, [24], [1 0 0], 1000 );
    %
    FEM.ImposeU( FEM. U(2) * FEM.TS(1)  );
    FEM.ImposeU( FEM. U(1)  );

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
    

end
 
load gong
sound(y,Fs)

 disp("done!!!  :-)")