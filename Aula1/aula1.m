%% Initial configurations
clc % Clear all text from command window
close all % Close all figures previously opened
clear % Clear previous environment variables
addpath RI/lib/
%addpath('../lib') % Update yout matlab path (the folder must exist)

list_of_exercises = { 
   %'Ex1'
   %'Ex2'
   %'Ex2mod'
   %'Ex3'
   'Ex4'

  }; %Defines the exercise to be executed (one or more at a time).


%% Ex1 -------------------------------------------------------------------

exercise = 'Ex1'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    P1=[-1 0]';
    P2=[1 0]';
    P3=[0 2]';
    
    A1=[P1 P2 P3];
    
    
    fill(A1(1,:),A1(2,:), 'g')
    axis equal
    axis([-10 10 -10 10])
    grid on
    
    v=[5 0]';
    A2=A1+v;
    
    hold on
    
    h=fill (A2(1,:), A2(2,:), 'r');

end

%% Ex2 -------------------------------------------------------------------

exercise = 'Ex2'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    P1=[-1 0]';
    P2=[1 0]';
    P3=[0 2]';
    
    A1=[P1 P2 P3];

    fill(A1(1,:),A1(2,:), 'g')
    axis equal
    axis([-10 10 -10 10])
    grid on
    
    v=[5 0]';
    A2=A1+v;
    
    hold on
    
    h=fill (A2(1,:), A2(2,:), 'r');

    a=30*pi/180; %conversão de 30º para radianos
    rota=[ cos(a) -sin(a); sin(a) cos(a)];
   
    A3=rota*A2;
   
    fill(A3(1,:),A3(2,:), 'b')
    
    n=10;
    a=linspace(60, 350, n);
    
    for i=a

        ii=i*pi/180;
        rota=[ cos(ii) -sin(ii); sin(ii) cos(ii)];
        
        A3=rota*A2;
        
        fill(A3(1,:),A3(2,:), 'b')
    
    end

end

%% Ex2mod -------------------------------------------------------------------

exercise = 'Ex2mod'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    P1=[-1 0]';
    P2=[1 0]';
    P3=[0 2]';
    
    A1=[P1 P2 P3];

    fill(A1(1,:),A1(2,:), 'g')
    axis equal
    axis([-10 10 -10 10])
    grid on
    
    v=[5 0]';
    A2=A1+v;
    
    hold on
    
    h=fill (A2(1,:), A2(2,:), 'r');

    n=50;
    for a=linspace(60, 350, n)*pi/180
        A4=rot(a)*A2;
        set(h, 'XData', A4(1,:), 'YData', A4(2,:))
        pause(0.03)
    end

end


%% Ex3 -------------------------------------------------------------------

exercise = 'Ex3'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars


    P1=[-1 0]';
    P2=[1 0]';
    P3=[0 2]';
    
    A1=[P1 P2 P3];
    %padding 
    A1 = [A1; ones(1,size(A1,2))];

    axis equal
    axis([-10 10 -10 10])
    grid on

    hold on

    h=fill (A1(1,:), A1(2,:), 'r');

    n=50;
    increments=linspace(0,1,n);

    %transformations
    vec1=[3 4]';
    vec2=[2 -5]';
    ang=80*pi/180;

    %translação [3 4]'
    for increment=increments
        t1=transGeom(vec1(1,1)*increment,vec1(2,1)*increment,0*increment);
        A2=t1*A1;
        set(h, 'XData', A2(1,:),'YData', A2(2,:))
        pause(0.05)
    end

    %rotação 80º
    for increment=increments
        r1=transGeom(0*increment,0*increment,ang*increment);
        A3=r1*A2;
        set(h, 'XData', A3(1,:),'YData', A3(2,:))
        pause(0.05)
    end

    %translação [2 -5]'
    for increment=increments
        t2=transGeom(vec2(1,1)*increment,vec2(2,1)*increment,0*increment);
        A4=t2*A3;
        set(h, 'XData', A4(1,:),'YData', A4(2,:))
        pause(0.05)
    end

end




%% Ex4 -------------------------------------------------------------------

exercise = 'Ex4'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
    disp(['Executing ' exercise ':'])
    clearvars -except list_of_exercises % Delete all previously declared vars

    P1=[0 -1/2]';
    P2=[2 0]';
    P3=[0 1/2]';
    
    A1=[P1 P2 P3];
    %padding 
    A1 = [A1; ones(1,size(A1,2))];

    axis equal
    axis([-20 20 -20 20])
    grid on

    hold on

    h=fill (A1(1,:), A1(2,:), 'r');

    n=50;

    M=[0 -4 -6 -4
       0 2 0 -2
       154*pi/180 pi 3*pi/2  2*pi];

    AnimateSimple2D(h, A1, M, n)

end






