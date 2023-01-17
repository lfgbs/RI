function T=mrotx(a)
    %function to obtain rotation around xx
    %a - vetor com angulos
    %T- hiper matriz de transformações geométricas

    T=zeros(4, 4, length(a));

    for n=1:length(a)
        T(:,:,n)=rotx(a(n));
    end
end