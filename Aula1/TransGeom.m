function t = TransGeom(x,y,alpha)
  
    rotation = [cos(alpha), -sin(alpha), 0; sin(alpha), cos(alpha), 0; 0, 0 , 1];
    translation=[1 0 x; 0, 1, y; 0, 0, 1]
    
    t=translation*rotation
  
end
