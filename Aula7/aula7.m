%% Initial configurations
clc % Clear all text from command window
close all % Close all figures previously opened
clear % Clear previous environment variables
addpath RI/lib/
%addpath('../lib') % Update yout matlab path (the folder must exist)

list_of_exercises = { 
   %'Ex1'
   'Ex2'
   %'Ex3'
   %'Ex6'

  }; %Defines the exercise to be executed (one or more at a time).


%% Ex1 -------------------------------------------------------------------

exercise = 'Ex1'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    L1=3;
    L2=2;

    invkinRR(2,2,L1,L2);

end

%% Ex2 -------------------------------------------------------------------

exercise = 'Ex2'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    axis equal; hold on; grid on;
    axis([-5 5 -1 6])

    
    L1=3;
    L2=2;

    DH=[0 L1 0 0 
        0 L2 0 0];

    p1=[4 0]';
    p2=[-1 1]';

    Q1=invkinRR(p1(1),p1(2),L1,L2);
    Q2=invkinRR(p2(1),p2(2),L1,L2);

    %cotovelo em baixo
%     redund=1;
% 
%     Qi=Q1(:,redund);
%     Qf=Q2(:,redund);

    %cotovelo em cima

%     redund=2;
% 
%     Qi=Q1(:,redund);
%     Qf=Q2(:,redund);

    %sai em baixo e chega em cima
%     Qi=Q1(:,1);
%     Qf=Q2(:,2);

    %sai em cima e chega em baixo
    Qi=Q1(:,1);
    Qf=Q2(:,2);

    MQ=linspaceVect(Qi, Qf, 100);
    t=[0 0]; %both rotational
    MDH=GenerateMultiDH(DH, MQ, t);
    AAA=CalculateRobotMotion(MDH);

    AA=Tlinks(DH);
    Org=LinkOrigins(AA);
    [P,F]=seixos3(0.5);
    h=DrawLinks(Org);
    H=DrawFrames(AA, P, F);

    AnimateRobot(H, AAA, P, h, 0.03)

end

%% Ex3 -------------------------------------------------------------------

exercise = 'Ex3'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    axis equal; hold on; grid on;
    axis([-5 5 -1 6])
    
    L1=3;
    L2=2;

    DH=[0 L1 0 0 
        0 L2 0 0];

    p1=[4 0]';
    p2=[-1 1]';

    Q1=invkinRR(p1(1),p1(2),L1,L2);
    Q2=invkinRR(p2(1),p2(2),L1,L2);

    QQ=[Q1(:,2) Q2(:,2)];

    [H, h, P, AAA]=InitRobot(QQ, 100, DH, [0,0], 0.5);
    AnimateRobot(H, AAA, P, h, 0.03)

end


%% Ex6 -------------------------------------------------------------------

exercise = 'Ex6'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    axis equal; hold on; grid on;
    axis([-5 5 -1 6])
    
    L1=2;
    L2=1;
    L3=1;

    DH=[0 L1 0 0 
        0 L2 0 0
        0 L3 0 0];

    p1=[2 -1]';
    p2=[2 5/2]';

    phi1=0;
    phi2=pi/2;

    Q1=invkinRRR(p1(1),p1(2), phi1, L1,L2, L3);
    Q2=invkinRRR(p2(1),p2(2), phi2, L1,L2, L3);

    QQ=[Q1(:,1) Q2(:,1)];

    [H, h, P, AAA]=InitRobot(QQ, 100, DH, [0,0,0], 0.5);
    AnimateRobot(H, AAA, P, h, 0.03)

end