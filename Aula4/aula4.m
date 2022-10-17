%% Initial configurations
clc % Clear all text from command window
close all % Close all figures previously opened
clear % Clear previous environment variables
addpath RI/lib/
%addpath('../lib') % Update yout matlab path (the folder must exist)

list_of_exercises = { 
   %'Extra'
   %'Ex1'
   %'Ex2'
   %'Ex3'
   %'Ex4'
   'Ex5'
   %'Ex2mod'
   %'Ex3'
   %'Ex4'

  }; %Defines the exercise to be executed (one or more at a time).


%% Extrasyms -------------------------------------------------------------------

exercise = 'Extra'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    syms th l d al

    A=Tlink(th, l, d, al)
    str=latex(A) %CODIGO LATEX DE A

end

%% Ex1 -------------------------------------------------------------------

exercise = 'Ex1'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    DH=[0 3 0 0
        0 1.5 0 0];

    AA=Tlinks(DH)

end

%% Ex2 -------------------------------------------------------------------

exercise = 'Ex2'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    DH=[-pi/4 1 0 0
        pi/2 1.5 0 0
        -pi/3 0.5 0 0];

    AA=Tlinks(DH);            
    Org=LinkOrigins(AA)

end

%% Ex3 -------------------------------------------------------------------

exercise = 'Ex3'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    DH=[-pi/4 1 0 0
        pi/2 1.5 0 0
        -pi/3 0.5 0 0];

    AA=Tlinks(DH);            
    Org=LinkOrigins(AA);
    DrawLinks(Org)

end

%% Ex4 -------------------------------------------------------------------

exercise = 'Ex4'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    [P,F]=seixos3(0.25);

    DH=[-pi/4 1 0 0
        pi/2 1.5 0 0
        -pi/3 0.5 0 0];

    AA=Tlinks(DH);            
    Org=LinkOrigins(AA);
    DrawLinks(Org);

    grid on
    axis equal
    hold on

    DrawFrames(AA, P, F);

end

%% Ex5 -------------------------------------------------------------------

exercise = 'Ex5'; % Define the name of the current exercise

if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    [P,F]=seixos3(0.75);

    L1=3;
    L2=3;
    L3=2;

    DH_RR=[0 L1 0 0
           0 L2 0 0];

    DH_RRR=[0 L1 0 0
            0 L2 0 0
            0 L3 0 0];

    DH_RR3D=[0 0 L1 pi/2
             0 L2 0 0];

    DH_RRA=[0 0 L1 pi/2
            0 L2 0 0
            0 L3 0 0];

    DH_all=cell(1,4);

    Dh_all{1}=DH_RR;
    Dh_all{2}=DH_RRR;
    Dh_all{3}=DH_RR3D;
    Dh_all{4}=DH_RRA;

    for n=1:size(Dh_all, 2)
        subplot(2,2,n)

        AA=Tlinks(Dh_all{n});            
        Org=LinkOrigins(AA);
        DrawLinks(Org);
    
        grid on
        axis equal
        hold on
    
        H=DrawFrames(AA, P, F);
        view(3)
    end



end
