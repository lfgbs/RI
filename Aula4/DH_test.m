DH =  [ -pi/4, 1 , 0, 0; pi/2, 1.5, 0, 0; -pi/3, 0.5, 0, 0]

AA=Tlinks(DH)
Org=LinkOrigins(AA)

%[P,F]=seixos3(0.5)
%H=DrawFrames(AA,P, F) 