%%ex1
P1 = [-1,0]';
P2 = [1, 0]';
P3 = [0, 2]';
A1 = [P1, P2, P3];
A2 = A1 + [5, 0]';

%concatenar fill(A2(1,:),A2(2,:),'b') e fill(A1(1,:),A1(2,:),'r'); 
fill(A1(1,:),A1(2,:),'y', A2(1,:),A2(2,:),'r' );
axis([-10 10 -10 10])

grid on
hold on
xlabel('x')
ylabel('y')
axis equal
grid on

%%ex2
%angulo de 50º
rot_angle=-50*pi/180
rotation=[cos(rot_angle), sin(rot_angle); -sin(rot_angle), cos(rot_angle)]
A3=rotation*A2

fill(A3(1,:), A3(2,:), 'b');

xlabel('x')
ylabel('y')
zlabel('z')
axis equal
grid on
hold on

%drawing multiple triangles
triangle=fill(A3(1,:), A3(2,:), 'c');

start_angle=60
end_angle=350
step=100

angles = linspace(start_angle, end_angle, step)*pi/180;

for angle=angles
    rotation2 = [cos(angle) -sin(angle)
    sin(angle) cos(angle)];
    A3 = rotation2*A2;
    set(triangle, 'XData', A3(1,:),'YData',A3(2,:));
    pause(1/25);
end




