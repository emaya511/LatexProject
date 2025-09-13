%% Strip with hormonic load
clear;
clc;



    FEM=DYNAMIC('Dynamic_WC1');
    FEM.ReadMesh('strip.msh');
    FEM.Mat(1)=MATDat("Mat.dat.txt");


    t=linspace(0,10,2001);

    x1=sin(25*t);    

    x2=ones(1,2001);
    x2(1:401)=0;


    
    FEM.Pp(1)=ProbeOnPhyEn([21 22 23 24],[1 0 0]);

 


    FEM.T=FEMTime(0.01,3);
    
    FEM.TS(1)=TimeSeries(t,x1);
    FEM.TS(2)=TimeSeries(t,x2);

    FEM.Up(1)=DirichletOnPhyEn(FEM, [12], [1 0 0], 0 );
    FEM.Up(2)=DirichletOnPhyEn(FEM, [11], [1 0 0], 0.01 );
    
    FEM.Fp(1)=NeumannOnPhyEn(FEM, [22 23 24 21], [1 0 0], 20000 );
  
    %FEM.For(2)=Neumann(FEM, [22], [1 0 0], 1000 );
    %FEM.For(3)=Neumann(FEM, [23], [1 0 0], 1000 );
    %FEM.For(4)=Neumann(FEM, [24], [1 0 0], 1000 );
    %
    FEM.ImposeU( FEM. Up(2)  *  FEM.TS(1)  );
    FEM.ImposeU( FEM. Up(1)   );
    %FEM.ImposeU( FEM. Un(1)  * FEM.TS(1)  );
    K1=10;
    K2=2;
    K3=10;
    
    P1 = K1 * FEM.Pp(1).forT(0);
    P2 = K2 *(FEM.Pp(1).forT(0)-FEM.Pp(1).forT(-1))/(FEM.T.forT(0)-FEM.T.forT(-1));
    P3 = K3 * Int(FEM.Pp(1));
    
    %P1=( P2  + P ); %+ K3*Int(FEM.Pp(1))
    %FEM.ApplyF( -1 *  FEM.Fp(1)  * (P1 + P2 + P3) );
    
    %FEM.ApplyF( -1 *  FEM.Fp(1)  * (P1 ) );
    
    
    
    
    %FEM.ApplyF(FEM.For(2)*FEM.TS(2));
    %FEM.ApplyF(FEM.For(3)*FEM.TS(3));
    %FEM.ApplyF(FEM.For(4)*FEM.TS(4));









    % 
    % FEM.U(1)=Dirichlet(FEM, [11], [1 0 0], 1 );
    % FEM.U(2)=Dirichlet(FEM, [12], [1 0 0], 0 );
    % FEM.U(3)=Dirichlet(FEM, [101], [1 0 0], 1 );
    % FEM.U(4)=Dirichlet(FEM, [102], [1 0 0], 1.25 );
    % FEM.U(5)=Dirichlet(FEM, [11], [0 1 1], 0 );

    % 
    % 
    % FEM.ImposeU( FEM. U(1)*FEM.TS(1)  )
    % FEM.ImposeU( FEM. U(2)  )
    % %FEM.ImposeU( FEM. U(3)*FEM.TS(2)  )
    % %FEM.ImposeU( FEM. U(4)*FEM.TS(1)  )
    % %FEM.ImposeU( FEM. U(5)  )
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
     FEM.PlotF();
     FEM.WriteF();


    



load gong
sound(y,Fs)

 disp("done!!!  :-)")