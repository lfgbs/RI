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

  }; %Defines the exercise to be executed (one or more at a time).


%% Ex1 -------------------------------------------------------------------

exercise = 'Ex1'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
  disp(['Executing ' exercise ':'])
  clearvars -except list_of_exercises % Delete all previously declared vars


    P1=[-1 0 0 0]';
    P2=[1 0 0 0]';
    P3=[0 2 0 0]';
    
    A1=[P1 P2 P3];

    h=fill3(A1(1,:), A1(2,:), A1(3,:), 'b');

    grid on
    axis equal
    axis([-5 5 -5 5 -5 5])

    xlabel('X')
    ylabel('Y')
    zlabel('Z')

    N=100;

    a=linspace(0, 4*pi, N);

    while 1
        for n=1:N
            T=roty(a(n))*rotz(a(n));
            Q=T*A1;
    
            set(h, 'XData', Q(1,:), 'YData', Q(2,:), 'ZData', Q(3,:))
            pause(0.05)
        end
        pause(1)
    end
    

end


%% Ex2 -------------------------------------------------------------------

exercise = 'Ex2'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
  disp(['Executing ' exercise ':'])
  clearvars -except list_of_exercises % Delete all previously declared vars

  P=[0.5 0.5 1 0 -1 -0.5 -0.5
     0 2 2 3 2 2 0 
     0 0 0 0 0 0 0
     1 1 1 1 1 1 1];

  h=fill3(P(1,:), P(2,:), P(3,:), 'b');

  grid on
  axis equal
  axis([-5 5 -5 5 -5 5])

  xlabel('X')
  ylabel('Y')
  zlabel('Z')

  N=100;
  a=linspace(0, 8*pi, N);

  for n=1:N
        T=rotz(a(n));
        Q=T*P;
    
        set(h, 'XData', Q(1,:), 'YData', Q(2,:), 'ZData', Q(3,:))
        pause(0.05)
  end


end

%% Ex3 -------------------------------------------------------------------

exercise = 'Ex3'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
      disp(['Executing ' exercise ':'])
      clearvars -except list_of_exercises % Delete all previously declared vars
    
      P=[0.5 0.5 1 0 -1 -0.5 -0.5
         0 2 2 3 2 2 0 
         0 0 0 0 0 0 0
         1 1 1 1 1 1 1];
    
      h1=fill3(P(1,:), P(2,:), P(3,:), 'b'); %plno XY
    
      grid on
      axis equal
      axis([-5 5 -5 5 -5 5])
      hold on
    
      xlabel('X')
      ylabel('Y')
      zlabel('Z')
    
      Q=rotz(pi/2)*rotx(pi/2)*P; %plano zy
      h2=fill3(Q(1,:), Q(2,:), Q(3,:), 'm');

      R=rotx(pi/2)*rotz(-pi/2)*P;
      h3=fill3(R(1,:), R(2,:), R(3,:), 'y');

      N=500; %plano xz
      a=linspace(0,20*pi, N);

      for n=1:N
            T1=roty(a(n));
            P1=T1*P;
            set(h1, 'XData', P1(1,:), 'YData', P1(2,:), 'ZData', P1(3,:))
        
            T2=rotz(a(n));
            P2=T2*Q;
            set(h2, 'XData', P2(1,:), 'YData', P2(2,:), 'ZData', P2(3,:))

            T3=rotx(a(n));
            P3=T3*R;
            set(h3, 'XData', P3(1,:), 'YData', P3(2,:), 'ZData', P3(3,:))

            pause(0.05)
      end

end

%% Ex4 -------------------------------------------------------------------

exercise = 'Ex4'; % Define the name of the current exercise
if ismember(exercise, list_of_exercises) %... if exer. in list_of_exercises
      disp(['Executing ' exercise ':'])
      clearvars -except list_of_exercises % Delete all previously declared vars
    
      P=[0.5 0.5 1 0 -1 -0.5 -0.5
         0 2 2 3 2 2 0 
         0 0 0 0 0 0 0
         1 1 1 1 1 1 1];

      Q=rotz(pi/2)*rotx(pi/2)*P; %plano zy
      h=fill3(Q(1,:), Q(2,:), Q(3,:), 'm');

      grid on
      axis equal
      axis([-8 8 -8 8 -8 8])

      view(120, 20)
    
      xlabel('X')
      ylabel('Y')
      zlabel('Z')

      pInicial=eye(4);
      
      positions=[
                 0 0 5 0 0 0
                 0 0 0 -pi/2 0 0
                 0 0 5 0 0 0
                 0 0 0 0 pi/2 0
                 0 0 5 0 0 0
                 0 0 0 -pi/2 0 0
                 0 0 5 0 0 0
                 0 0 0 0 pi/2 0
                 0 0 5 0 0 0
                 0 0 0 -pi/2 0 0
                 0 0 5 0 0 0
                 0 0 0 0 pi/2 0
                ];
      while 1
          for n=1:size(positions,1)
                pInicial=Animate(h, Q, pInicial, positions(n,:), 50);
          end
      end

end