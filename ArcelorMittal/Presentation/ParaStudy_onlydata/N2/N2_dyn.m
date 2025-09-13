%% Strip with hormonic load
clear;
clc;
%Ni=["0E1","1E2","1E3","1E4","1E5","1E6","1E7","3E7"];
%Ni=["0E1"];

Ni=["3E7"];

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
    
        FEM.T=FEMTime(0.01,2);
    FEM.TS(1)=TimeSeries(t,x1);
    FEM.TS(2)=TimeSeries(t,x2);
    FEM.TS(3)=TimeSeries(t,x3);
    FEM.TS(4)=TimeSeries(t,x4);

    FEM.U(1)=Dirichlet(FEM, [12], [1 0 0], 0 );
    FEM.U(2)=Dirichlet(FEM, [11], [0 0 1], 0 );
    FEM.U(3)=Dirichlet(FEM, [11], [0 1 0], 1 );
    FEM.Un(1)=DirichletOnNode(FEM, [27], [1 0 0], 0 );
    
    FEM.ImposeU( FEM. U(1)  );
    FEM.ImposeU( FEM. U(2)  );
    FEM.ImposeU( FEM. U(3)  *  FEM.TS(1) );
    FEM.ImposeU( FEM. Un(1) *  FEM.TS(1) );











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

    %X=FEM.X;
    %name = sprintf('%s_X.mat',FEM.StudyName);
    %save(name,'X')
    

end
 
load gong
sound(y,Fs)

 disp("done!!!  :-)")