%% Initial configurations
clc % Clear all text from command window
close all % Close all figures previously opened
clear % Clear previous environment variables
addpath RI/lib/
%addpath('../lib') % Update yout matlab path (the folder must exist)

list_of_exercises = { 
   %'Ex1'
   %'Ex2'
   %'Ex3'
   'Ex4'
   %'Ex5'
   %'Ex6
  }; %Defines the exercise to be executed (one or more at a time).


%% Ex1 -------------------------------------------------------------------

exercise = 'Ex1'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    Qi=[1 3 -2]';
    Qf=[4 0 -8]';

    N=4;

    MQ=linspaceVect(Qi, Qf, N)

end

%% Ex2 -------------------------------------------------------------------

exercise = 'Ex2'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    Qa=[1 3 -2]';
    Qb=[4 0 -4]';
    Qc=[3 5 0]';
    Qd=[6 -1 3]';

    N=4;

    MMQ=[];

    MMQ=[MMQ linspaceVect(Qa, Qb, N)];
    MMQ=[MMQ linspaceVect(Qb, Qc, N)];
    MMQ=[MMQ linspaceVect(Qc, Qd, N)];

    subplot(1,2,1)
    plot(MMQ')
    legend('J1', 'J2', 'J3')
    grid;

    idx=find(sum(abs(diff(MMQ')'))==0);

    MMQ2=MMQ;

    MMQ2(:,idx)=[];

    subplot(1,2,2)
    plot(MMQ2')
    legend('J1', 'J2', 'J3')
    grid;

end


%% Ex4 -------------------------------------------------------------------

exercise = 'Ex4'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    [P,F]=seixos3(0.25);

    grid on;
    axis equal; hold on;

    L1=2;
    L2=1;

    Qi=[0 0]';
    Qf=[pi pi/3]';
    N=20;

    DH=[0 L1 0 0 
        0 L2 0 0];

    MQ=linspaceVect(Qi, Qf, N);

    MDH=GenerateMultiDH(DH, MQ);

    for n=1:size(MDH,3)
    
        AA=Tlinks(MDH(:,:,n));
        Org=LinkOrigins(AA);
        DrawLinks(Org);
        DrawFrames(AA, P, F);

    end

end

%% Ex5 -------------------------------------------------------------------

exercise = 'Ex5'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

end