function rotationy = roty(alpha)
  
    %matriz de rotação sobre yy
    rotationy=[cos(alpha) 0 -sin(alpha) 0 ;0, 1, 0, 0; sin(alpha), 0, cos(alpha), 0; 0, 0, 0, 1]
  
end