function AnimateRobot(H, AAA, P, h, sd)

    %H - handles gráficos dos objetos a animar (desenhados por
    %DrawFrames);
    %AAA - superhipermatriz que contém a sequência temporal de
    %hipermatrizes calculadas por CalculateRobotMotion;
    %P - objeto a representar (sistema coordenadas: seixos3). É passado
    %aqui para se recalcular dinamicamente a sua postura para fazer a
    %representação;
    %h - handle gráfico dos elos do robô (vem de DrawLinks);
    %sd - indicador do nı́vel de pausa entre passos da animação (controla a
    %velocidade da animação).

    for n=1:size(AAA,4)

        %update links positions
        AA=AAA(:,:,:,n); %current position
        Org=LinkOrigins(AA); %origins of links

        h.XData=Org(1,:);
        h.YData=Org(2,:);
        h.ZData=Org(3,:);

        %upadte frames positions

        T=eye(4);

        for j=1:size(AAA,3) %num of links

            T=T*AAA(:,:,j,n);  % accumulated geom transf
            Q=T*P; % new position of P

            H{j}.Vertices=Q(1:3,:)'; %update patch vertices

        end

        pause(sd)


    end


end 