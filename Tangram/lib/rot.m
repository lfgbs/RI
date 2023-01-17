function M=rot(a)
    %returns rotation matrix
    %M - matrix
    %a - angle of rotation
    
    M=[ cos(a) -sin(a); sin(a) cos(a)];
end