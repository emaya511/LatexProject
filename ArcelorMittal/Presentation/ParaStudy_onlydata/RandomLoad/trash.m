load("er.mat")



t1=tSimu(1:1001)';
x1=DisturbanceOFF(1:1001)';

t2=tSimu(1:1001)';
x2=DisturbanceOFF(501:1501)';

t3=tSimu(1:1001)';
x3=DisturbanceOFF(2001:3001)';

           fileID = fopen('Load1.txt','wt');
           fprintf(fileID,'T X\n'); 
           for i = 1 : numel (t1)
                fprintf(fileID,'%d %d\n',t1(i),x1(i)); 
           end
           fclose(fileID);
           
           
           fileID = fopen('Load2.txt','wt');
           fprintf(fileID,'T X\n'); 
           for i = 1 : numel (t2)
                fprintf(fileID,'%d %d\n',t2(i),x2(i)); 
           end
           fclose(fileID);
           
           
           fileID = fopen('Load3.txt','wt');
           fprintf(fileID,'T X\n'); 
           for i = 1 : numel (t3)
                fprintf(fileID,'%d %d\n',t3(i),x3(i)); 
           end
           fclose(fileID);