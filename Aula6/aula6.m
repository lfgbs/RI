%% Initial configurations
clc % Clear all text from command window
close all % Close all figures previously opened
clear % Clear previous environment variables
addpath RI/lib/
%addpath('../lib') % Update yout matlab path (the folder must exist)

list_of_exercises = { 
   'Ex1'
   %'Ex2'
   %'Ex3'
   %'Ex4'
   %'Ex5'
   %'Ex6
  }; %Defines the exercise to be executed (one or more at a time).


%% Ex1 -------------------------------------------------------------------

exercise = 'Ex1'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    L1=3;
    L2=2;

    DH=[ 0 L1 0 0
         0 L2 0 0];

    Qi=[0 0]';
    Qf=[pi/2 pi/2]';

    MQ=linspaceVect(Qi, Qf, 100);
    t=[0 0]; %both rotational
    MDH=GenerateMultiDH(DH, MQ, t);
    AAA=CalculateRobotMotion(MDH);

    AA=Tlinks(DH);
    Org=LinkOrigins(AA);
    [P,F]=seixos3(0.5);
    h=DrawLinks(Org);
    hold on;
    grid on;
    axis equal
    axis([-5 6 .1 5])
    H=DrawFrames(AA, P, F);

    AnimateRobot(H, AAA, P, h, 0.02)


end



%% Ex2 -------------------------------------------------------------------

exercise = 'Ex2'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars


end