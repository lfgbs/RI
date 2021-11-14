%%ex1
clear

%triangulo1
P1 = [-1,0, 0]';
P2 = [1, 0, 0]';
P3 = [0, 2, 0]';
T1 = [P1, P2, P3];


axis([-5 5 -5 5])

xlabel('x')
ylabel('y')
zlabel('z')
axis equal
grid on
hold on

%octave currently doesnt implement the fill3 function so i have substituted it with the patch function
%fill3(A1,(1,:), A1, (2,:), A1, (3,:))
triangle=patch(P1, P2, P3, 'r')

%padding para possibilitar a multiplicação de nGeom(4*4) por t1(3*3)
T1 = [T1; ones(1,size(T1,2))];

value_start=0
value_end=1
smoothness=100
%array of size smoothness, envenly spaced values between 0 and 1 
array = linspace(value_start, value_end, smoothness);

%animate translation followed by a rotation followed by another translation
for elem=array
    nGeom = rotx(4*pi*elem)
    transformation=nGeom*T1
    set(triangle, 'XData', transformation(1,:),'YData',  transformation(2,:), 'ZData', transformation(3,:));
    pause(1/25);
end
