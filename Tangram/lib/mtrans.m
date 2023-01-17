function TT=mtrans(x,y,z)
    %função para obter multiplas matrizes de translação
    %x y e z são vetores
    %TT- hipermatriz de translações

    m=max([length(x) length(y) length(z)]);

    x(end:m)=x(end);
    y(end:m)=y(end);
    z(end:m)=z(end);
    
    TT=zeros(4,4,m);

    for n=1:m
        TT(:,:,n)=trans(x(n), y(n), z(n));
    end


end