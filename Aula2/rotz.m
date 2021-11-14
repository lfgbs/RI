function rotationz = rotz(alpha)
  
    %matriz de rotação sobre zz
    rotationz=[cos(alpha) sin(alpha) 0 0; -sin(alpha), cos(alpha), 0, 0; 0, 0, 1, 0; 0, 0, 0, 1]
  
end