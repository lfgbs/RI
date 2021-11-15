function Org=LinkOrigins(AA)
  %AA result of tlinks
  
  Org=zeros(3, size(AA, 3)+1)%soma-se 1 para se acomodar a introdução da origem (0,0,0)
  
  T=eye(4)
  
  for n=1:size(AA,3)
    T=T*AA(:,:,n)
    Org(:,n+1)=T(1:3,4)
  endfor
  
end