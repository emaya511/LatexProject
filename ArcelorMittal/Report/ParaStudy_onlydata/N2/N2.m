%% Strip with hormonic load
clear;
clc;
Ni=["0E1","1E2","1E3","1E4","1E5","1E6","1E7","3E7"];
%Ni=["0E1"];

%Ni=["3E7"];

for i = 1 : numel(Ni)
    
    
    name=strcat(Ni(i),'\Static_strip_');
    %FEM=DYNAMIC("7000\Dynamic");
    FEM=STATIC(name);
    FEM.lg.lgit(sprintf('** Solving for Rho : %s',Ni(i)))
    FEM.ReadMesh("meshes\strip.msh");
    name=strcat(Ni(i),"\Mat.dat.txt");
    FEM.Mat(1)=MATDat(name);

    
    t=linspace(0,10,2001);





     t=linspace(0,20,1001);

    x1=ones(1,numel(t));

 
    TS1=TimeSeries(t,x1);

    FEM.U(1)=Dirichlet(FEM, [12], [1 0 0], 0 );
    FEM.U(2)=Dirichlet(FEM, [11], [0 0 1], 0 );
    FEM.U(3)=Dirichlet(FEM, [11], [0 1 0], 1 );
    FEM.Un(1)=DirichletOnNode(FEM, [27], [1 0 0], 0 );
    
    FEM.ImposeU( FEM. U(1)  );
    FEM.ImposeU( FEM. U(2)  );
    FEM.ImposeU( FEM. U(3)  );
    FEM.ImposeU( FEM. Un(1) * TS1  );











    % 

    % 
     FEM.SetDomain([1 21 22 23 24],[1],'MITC4');
    % 

    % 
     tic;
     FEM.Solve();
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