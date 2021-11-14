%%ex2
%Arrow1
P4 = [ 0.5, 0, 0]'
P5=[0.5, 2, 0]'
P6=[1, 2, 0]'
P7=[0, 3, 0]'
P8=[-1, 2, 0]'
P9=[-0.5, 2, 0]'
P10=[-0.5, 0, 0]'

axis([-5 5 -5 5])

xlabel('x')
ylabel('y')
zlabel('z')
axis equal
grid on
hold on

A=[P4, P5, P6, P7, P8, P9, P10]

%generic arrow used for transformations
arrow=patch('XData', A(1,:) ,'YData', A(2,:),'ZData', A(3,:), 'FaceColor', 'interp')

A1=arrow
A2=arrow
A3=arrow

%padding para possibilitar a multiplicação de nGeom(4*4) por AX(3*7)
A = [A; ones(1,size(A,2))];
A1 = [A1; ones(1,size(A1,2))];
A2 = [A2; ones(1,size(A2,2))];
A3 = [A3; ones(1,size(A3,2))];

value_start=0
value_end=1
smoothness=100
%array of size smoothness, evenly spaced values between 0 and 1 
array = linspace(value_start, value_end, smoothness);

%animate rotation yy
for elem=array
    nGeom = roty((pi/2)*elem)
    transformation=nGeom*A
    set(arrow, 'XData', transformation(1,:),'YData',  transformation(2,:), 'ZData', transformation(3,:));
    pause(1/25);
end

A1=arrow

%animate rotation zz A2
for elem=array
    nGeom= rotz((pi/2)*elem)
    transformation=nGeom*A1
    set(arrow, 'XData', transformation(1,:),'YData',  transformation(2,:), 'ZData', transformation(3,:));
    pause(1/25);
end

A2=arrow

%reset arrow position
arrow=patch('XData', A(1,:) ,'YData', A(2,:),'ZData', A(3,:))

%animate rotation xx
for elem=array
    nGeom = rotx((pi/2)*elem)
    transformation=nGeom*A
    set(arrow, 'XData', transformation(1,:),'YData',  transformation(2,:), 'ZData', transformation(3,:));
    pause(1/25);
end

A3=arrow

arrow1=patch('XData', A1.XData ,'YData', A1.YData,'ZData', A1(3,:))
arrow2=patch('XData', A2(1,:) ,'YData', A2(2,:),'ZData', A2(3,:))
arrow2=patch('XData', A3(1,:) ,'YData', A3(2,:),'ZData', A3(3,:))

for elem=array
    nGeomA1 = roty((20*pi)*elem)
    transformation=nGeom*A1
    nGeom= rotz((pi/2)*elem)
    transformation=nGeom*A2
    nGeom = rotx((pi/2)*elem)
    transformation=nGeom*A3
    set(arrow3, 'XData', transformation(1,:),'YData',  transformation(2,:), 'ZData', transformation(3,:));
    set(arrow2, 'XData', transformation(1,:),'YData',  transformation(2,:), 'ZData', transformation(3,:));
    set(arrow1, 'XData', transformation(1,:),'YData',  transformation(2,:), 'ZData', transformation(3,:));
    pause(1/25);
end


