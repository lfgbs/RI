function H=DrawFrames(AA,P,F)
  
  H=cell(1, size(AA, 3))
  h=patch('Vertices', P(1:3:)', 'Faces', F, 'FaceColor', 'w')
  
  T=eye(4)
  
  for n=1:size(AA,3)
    
    T=T*AA(:,:,n)
    P1=T*P
    h=patch('Vertices', P1(1:3)', 'Faces', F, 'FaceColor', 'g')
    
    H{n}=h
  endfor
end