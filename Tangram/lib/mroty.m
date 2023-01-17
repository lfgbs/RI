function T=mroty(a)
    %function to obtain rotation around yy
    %a - vetor com angulos
    %T- hiper matriz de transformações geométricas

    T=zeros(4, 4, length(a));

    for n=1:length(a)
        T(:,:,n)=roty(a(n));
    end
end