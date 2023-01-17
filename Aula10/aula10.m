%% Initial configurations
clc % Clear all text from command window
close all % Close all figures previously opened
clear % Clear previous environment variables
addpath RI/lib/ % Update yout matlab path (the folder must exist)

list_of_exercises = { 
   'Ex2'
   %'Ex4'

  }; %Defines the exercise to be executed (one or more at a time).


%% Ex2 -------------------------------------------------------------------

exercise = 'Ex2'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
  disp(['Executing ' exercise ':'])
  clearvars -except list_of_exercises % Delete all previously declared vars
    
  L1=3; L2=2;

  A=[2 0]';
  B=[-4 2]';

  DH=[0 L1 0 0 
      0 L2 0 0];

  QA=invkinRR(A(1),A(2),L1,L2);
  QB=invkinRR(B(1),B(2),L1,L2);

  redund_i=2;
  redund_f=1;

  qi=QA(:, redund_i);
  qf=QB(:, redund_f);

  N=100;

  Qv0=[0 0]';
  Qvf=Qv0;
  t0=0; tf=4;

  subplot(1,2,1)
  grid on; hold on

  subplot(1,2,2)
  hold on; grid on; axis equal

  [Qm, t]=PolyTrajV(qi, qf, Qv0, Qvf, N, t0 ,tf);

  subplot(1,2,1)
  plot(t, Qm(1,:), t, Qm(2,:))

  subplot(1,2,2)
  [H,h,P, AAA]=InitRobot(Qm, 1, DH, [0,0], 0.5);
  AnimateRobot(H, AAA, P, h, 0.03)


end

%% Ex4 -------------------------------------------------------------------

exercise = 'Ex4'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
  disp(['Executing ' exercise ':'])
  clearvars -except list_of_exercises % Delete all previously declared vars
    
  L1=1; L2=3;

  A=[4 0]';
  B=[0 3]';
  C=[1 4]';
  D=[4 2]';
  E=[2 2]';
  F=[-3 3]';

  DH=[0 L1 0 0 
      0 L2 0 0];

  Qm=[];

  red=1;

  Qt=invkinRR(A(1), A(2), L1,L2); Qm=[Qm Qt(:,red)];
  Qt=invkinRR(B(1), B(2), L1,L2); Qm=[Qm Qt(:,red)];
  Qt=invkinRR(C(1), C(2), L1,L2); Qm=[Qm Qt(:,red)];
  Qt=invkinRR(D(1), D(2), L1,L2); Qm=[Qm Qt(:,red)];
  Qt=invkinRR(E(1), E(2), L1,L2); Qm=[Qm Qt(:,red)];
  Qt=invkinRR(F(1), F(2), L1,L2); Qm=[Qm Qt(:,red)];

  N=100;

  Qv0=[0 0]';
  Qvf=Qv0;
  tt=[0 0.5 1.2 2 2.6 4];

  subplot(1,2,1)
  grid on; hold on

  subplot(1,2,2)
  hold on; grid on; axis equal

  [QQ, t]=MultiPolyTrajV(Qm, N, tt);

  subplot(1,2,2)
  [H,h,P, AAA]=InitRobot(Qm, 1, DH, [0,0], 0.5);
  AnimateRobot(H, AAA, P, h, 0.03)


end