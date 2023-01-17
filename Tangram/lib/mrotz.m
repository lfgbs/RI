function T=mrotz(a)
    %function to obtain rotation around zz
    %a - vetor com angulos
    %T- hiper matriz de transformações geométricas

    T=zeros(4, 4, length(a));

    for n=1:length(a)
        T(:,:,n)=rotz(a(n));
    end

end