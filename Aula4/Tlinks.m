function AA = Tlinks(DH)
  
    AA=zeros(4,4, size(DH, 1))
    
    for n = 1:size(DH,1)
      AA(:,:,n)=Tlink(DH(n,:))
    endfor
    
end
