%% Initial configurations
clc % Clear all text from command window
close all % Close all figures previously opened
clear % Clear previous environment variables
addpath RI/lib/
%addpath('../lib') % Update yout matlab path (the folder must exist)

list_of_exercises = { 
   %'Ex1'
   %'Ex1matglob'
   %'Ex1matloc'
   'Ex5'
   %'Ex2mod'
   %'Ex3'
   %'Ex4'

  }; %Defines the exercise to be executed (one or more at a time).


%% Ex1 -------------------------------------------------------------------

exercise = 'Ex1'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    %6 configurações 
    [P,F]=seixos3(1);

    %representar objeto
    h=patch('Vertices', P(1:3, :)', 'Faces', F, 'Facecolor', 'g');

    grid on; axis on; hold on;
    xlabel('x'); ylabel('y'); zlabel('z')
    axis([-1 6 -1 7 -1 6])
    view(110, 15)
    
    %objeto 1 - trans Z e rotação local de -90 em xx
    T1=trans(0,0,5)*rotx(-pi/2);

    P1=T1*P;
    h1=patch('Vertices', P1(1:3, :)', 'Faces', F, 'Facecolor', 'b');

    %objeto 2
    T2=trans(0,6,5)*rotx(-pi/2)*roty(pi/2);
    P2=T2*P;
    h2=patch('Vertices', P2(1:3, :)', 'Faces', F, 'Facecolor', 'b');

end

%% Ex1 -------------------------------------------------------------------
%Transformações usando o referencial global - pré multiplicação

exercise = 'Ex1matglob'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    %6 configurações 
    [P,F]=seixos3(1);

    %representar objeto
    h=patch('Vertices', P(1:3, :)', 'Faces', F, 'Facecolor', 'g');

    grid on; axis on; hold on;
    xlabel('x'); ylabel('y'); zlabel('z')
    axis([-1 6 -1 7 -1 6])
    view(110, 15)
    
    T(:,:,1)=trans(0,0,5)*rotx(-pi/2);
    T(:,:,2)=trans(0,6,5)*rotx(-pi/2)*roty(pi/2);
    T(:,:,3)=trans(4,6,5)*rotx(-pi/2)*roty(pi/2)*rotx(-pi/2);
    T(:,:,4)=trans(4,6,0)*rotx(-pi/2)*roty(pi/2)*rotx(-pi/2)*roty(pi/2);
    T(:,:,5)=trans(4,0,0)*rotx(-pi/2)*roty(pi/2)*rotx(-pi/2)*roty(pi/2)*rotx(-pi/2);


    for n=1:size(T,3)

        TT=T(:,:,n);
        Pn=TT*P;
        patch('Vertices', Pn(1:3, :)', 'Faces', F, 'Facecolor', 'b');

    end

end


%% Ex1 -------------------------------------------------------------------
%Transformaçoes usando o referencial local - pós-multiplicação

exercise = 'Ex1matloc'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    %6 configurações 
    [P,F]=seixos3(1);

    %representar objeto
    h=patch('Vertices', P(1:3, :)', 'Faces', F, 'Facecolor', 'g');

    grid on; axis on; hold on;
    xlabel('x'); ylabel('y'); zlabel('z')
    axis([-1 6 -1 7 -1 6])
    view(110, 15)
    
    T(:,:,1)=trans(0,0,5)*rotx(-pi/2);
    T(:,:,2)=trans(0,0,6)*roty(pi/2);
    T(:,:,3)=trans(0,0,4)*rotx(-pi/2);
    T(:,:,4)=trans(0,0,5)*roty(pi/2);
    T(:,:,5)=trans(0,0,6)*rotx(-pi/2);


    TT=eye(4);

    for n=1:size(T,3)

        TT=TT*T(:,:,n);
        Pn=TT*P;
        patch('Vertices', Pn(1:3, :)', 'Faces', F, 'Facecolor', 'b');

    end

end



%% Ex5 -------------------------------------------------------------------
%Testar manimate

exercise = 'Ex5'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars
    
    [P,F]=seixos3(1);
    h=patch('Vertices', P(1:3, :)', 'Faces', F, 'Facecolor', 'g');

    grid on; axis on; hold on;
    xlabel('x'); ylabel('y'); zlabel('z')
    axis([-1 6 -1 7 -1 6])
    view(110, 15)

    NN=10;

    T(:,:,:,1)=mtrans(0,0,linspace(0, 5, NN));
    T(:,:,:,2)=mrotx(linspace(0, -pi/2,NN));
    T(:,:,:,3)=mtrans(0, linspace(0,6,NN),0);
    T(:,:,:,4)=mroty(linspace(0, pi/2, NN));
    T(:,:,:,5)=mtrans(linspace(0,4,NN), 0, 0);
    T(:,:,:,6)=mrotx(linspace(0, -pi/2, NN));

    order=[0 1 0 1 0 1];
    Tcurr=eye(4,4);

    for n=1:size(T,4)
        manimate(h, P, Tcurr, T(:,:,:,n), order(n));
    end

end