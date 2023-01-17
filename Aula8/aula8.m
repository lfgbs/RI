%% Initial configurations
clc % Clear all text from command window
close all % Close all figures previously opened
clear % Clear previous environment variables
addpath RI/lib/ % Update yout matlab path (the folder must exist)

list_of_exercises = { 
   %'Ex1'
   %'Ex2'
   'Ex3'

  }; %Defines the exercise to be executed (one or more at a time).


%% Ex2 -------------------------------------------------------------------

exercise = 'Ex2'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
  disp(['Executing ' exercise ':'])
  clearvars -except list_of_exercises % Delete all previously declared vars

  L1=2;
  L2=3;
  L3=1;

  A=[3 -1 0]';
  B=[-1 1 4]';

  DH=[0 0 L1 pi/2
      0 L2 0 0 
      0 L3 0 0];

  view(3); hold on; grid on;
  axis([-2 6 -2 6 -2 6])

  Q1=invkinRRRantro(A(1), A(2), A(3), L1, L2, L3);
  Q2=invkinRRRantro(B(1), B(2), B(3), L1, L2, L3);

  %cotovelo em baixo - cotovelo em baixo
  %QQ=[Q1(:,1) Q2(:,1)];

  %cotovelo em cima - cotovelo em cima
  %QQ=[Q1(:,2) Q2(:,2)];

  %cotovelo em baixo - cotovelo em cima
  %QQ=[Q1(:,1) Q2(:,2)];

  %cotovelo em baixo - cotovelo em cima
  QQ=[Q1(:,2) Q2(:,1)];

  [H, h, P, AAA]=InitRobot(QQ, 100, DH, [0,0,0], 0.5);
  AnimateRobot(H, AAA, P, h, 0.03)

end


%% Ex3 -------------------------------------------------------------------

exercise = 'Ex3'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
  disp(['Executing ' exercise ':'])
  clearvars -except list_of_exercises % Delete all previously declared vars

  L1=2;
  L2=2;
  L3=2;
  L4=0.3;

  jTypes=[0 0 0 1 0];

  DH=[0 0 L1 pi/2
      0 L2 0 pi/2 %junta imaginaria para que a representação fique similar ao robô 
      0 L3 0 0
      0 0 0 0
      0 0 L4 0];

  Qi=[0 0 0 0 0]';
  Qf=[pi/2 0 -pi/2 0.5 pi/4]';

  QQ=[Qi, Qf];

  hold on; axis equal; grid on; axis([-5 5 -5 5 -1 5 ])
  view(3)

  [H, h, P, AAA]=InitRobot(QQ, 100, DH, jTypes, 0.5);
  AnimateRobot(H, AAA, P, h, 0.03)

end