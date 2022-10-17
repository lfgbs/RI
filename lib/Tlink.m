function A=Tlink(theta, l, d, alpha)
   %Transformação associada a um elo. Devolve a matriz respetiva e aceita
    %os 4 parâmetros de D-H 

    if nargin==1
        l=theta(2);
        d=theta(3);
        alpha=theta(4);
        theta=theta(1);

    end

    A=rotz(theta)*trans(l,0,d)*rotx(alpha);

end