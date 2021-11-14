%triangulo1
P1 = [-1,0]';
P2 = [1, 0]';
P3 = [0, 2]';
A1 = [P1, P2, P3];

u1 = [3,4]'
rotation_angle=80*pi/180
u2=[2, -5]'

axis([-10 10 -10 10])

xlabel('x')
ylabel('y')
zlabel('z')
axis equal
grid on
hold on

triangle = fill(A1(1,:),A1(2,:),'g');

%padding para possibilitar a multiplicação de nGeom(3*3) por A1(2*3)
A1 = [A1; ones(1,size(A1,2))];

%array of size 50, values between 0 and 1 
value_start=0
value_end=1
smoothness=50
array = linspace(value_start, value_end, smoothness);

%animate translation followed by a rotation followed by another translation
for elem=array
    nGeom = TransGeom(u1(1,1)*elem,u1(2,1)*elem,0)
    transformation=nGeom*A1
    set(triangle, 'XData', transformation(1,:),'YData',  transformation(2,:));
    pause(1/25);
end

%Establishes A1 in the current position before moving to the next transformation

A1=transformation


for elem=array
    nGeom = TransGeom(0,0,rotation_angle*elem)
    transformation=nGeom*A1
    set(triangle, 'XData', transformation(1,:),'YData',  transformation(2,:));
    pause(1/25);
end

A1=transformation

for elem=array
    nGeom = TransGeom(u2(1,1)*elem,u2(2,1)*elem,0)
    transformation=nGeom*A1
    set(triangle, 'XData', transformation(1,:),'YData',  transformation(2,:));
    pause(1/25);
end
