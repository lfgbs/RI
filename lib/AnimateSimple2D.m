function AnimateSimple2D(h, P, M, N)

    %h - handle do objeto
    %P - objeto
    %M - Matriz de transformações
    %N - n de iterações da animação

    increments=linspace(0,1,N);

    MM=[0;0;0];
    MM=[MM, M];

    P1=P;
    
    for i=1:size(M,2)

        transf_vec=M(:,i);
        tP=transGeom(transf_vec(1,1), transf_vec(2,1), transf_vec(3,1));
        P=tP*P;
        
        %{
        for increment=increments
            transf=transGeom(transf_vec(1,1)*increment,transf_vec(2,1)*increment,transf_vec(3,1)*increment);
            P1=transf*P;
            set(h, 'XData', P1(1,:),'YData', P1(2,:))
            pause(0.03)
        end
        %}

        for increment=increments
            transf=transGeom(transf_vec(1,1)*increment,transf_vec(2,1)*increment,transf_vec(3,1)*increment);
            P1=transf*P;
            set(h, 'XData', P1(1,:),'YData', P1(2,:))
            pause(0.5)
        end
        
 

    end

end