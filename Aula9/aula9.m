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


%% Ex1 -------------------------------------------------------------------

exercise = 'Ex1'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
  disp(['Executing ' exercise ':'])
  clearvars -except list_of_exercises % Delete all previously declared vars

  L1=3;
  L2=2;

  DH=[0 L1 0 0 
      0 L2 0 0];

  A=[4 0]';
  B=[-3 1]';

  grid on; hold on

  Qi=invkinRR(A(1),A(2),L1,L2);
  Qf=invkinRR(B(1),B(2),L1,L2);

  N=100;

  dQ=(Qf(:,1)-Qi(:,1))/N;

  Qn=Qi(:,1);

  for n=1:N

      J=jacobianRR(Qn, L1, L2);
      dr=J*dQ;

      plot(n, dr(1), 'r+', n, dr(2), 'b*')

      Qn=Qn+dQ;

  end

end


%% Ex2 -------------------------------------------------------------------

exercise = 'Ex2'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
  disp(['Executing ' exercise ':'])
  clearvars -except list_of_exercises % Delete all previously declared vars

  L1=3;
  L2=2;

  DH=[0 L1 0 0 
      0 L2 0 0];

  A=[4 0]';
  B=[-3 1]';

  subplot(1,2,1)
  grid on; hold on

  subplot(1,2,2)
  hold on; grid on; axis equal

  Qi=invkinRR(A(1),A(2),L1,L2);
  Qf=invkinRR(B(1),B(2),L1,L2);

  N=100;
  redund=2;
  dQ=(Qf(:,redund)-Qi(:,redund))/N;

  Qn=Qi(:,redund);

  [H,h,P, w]=InitRobot([Qi(:,redund), Qf(:,redund)], 1, DH, [0,0], 0.5);

  for n=1:N

      J=jacobianRR(Qn, L1, L2);
      dr=J*dQ;

      subplot(1,2,1)
      plot(n, dr(1), 'r+', n, dr(2), 'b*')

      subplot(1,2,2)

      MDH= GenerateMultiDH(DH, Qn, [0,0]);
      AAA=CalculateRobotMotion(MDH);
      AnimateRobot(H, AAA, P, h, 0.03);

      Qn=Qn+dQ;

  end

end


%% Ex3 -------------------------------------------------------------------

exercise = 'Ex3'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
  disp(['Executing ' exercise ':'])
  clearvars -except list_of_exercises % Delete all previously declared vars

  L1=3;
  L2=2;

  DH=[0 L1 0 0 
      0 L2 0 0];

  A=[4 0]';
  B=[-4 3]';

  subplot(1,2,1)
  grid on; hold on

  subplot(1,2,2)
  hold on; grid on; axis equal

  Qi=invkinRR(A(1),A(2),L1,L2);
  Qf=invkinRR(B(1),B(2),L1,L2);

  N=100;
  redund=2;

  dQ=(Qf(:,redund)-Qi(:,redund))/N;

  Qn=Qi(:,redund);

  [H,h,P, ~]=InitRobot([Qi(:,redund), Qf(:,redund)], 1, DH, [0,0], 0.5);

  dr=(B-A)/N;

  for n=1:N

      Jinv=jacobianRRInv(Qn, L1,L2);
      dQ=Jinv*dr;

      subplot(1,2,1)
      plot(n, dQ(1), 'r+', n, dQ(2), 'b*')

      subplot(1,2,2)

      MDH= GenerateMultiDH(DH, Qn, [0,0]);
      AAA=CalculateRobotMotion(MDH);
      AnimateRobot(H, AAA, P, h, 0.03);

      Qn=Qn+dQ;

  end

end