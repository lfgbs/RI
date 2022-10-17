function pFinal = Animate(h, P, pInicial, D, N)
    %pFinal - matriz da posição final do objeto
    %h - handle gráfico do objeto
    %P - Matriz pontos do objeto
    %pInicial - transformação da posição inicial
    %D - vetor dos incrementos
    %N - n de passis da animação

    x=linspace(0, D(1), N);
    y=linspace(0, D(2), N);
    z=linspace(0, D(3), N);
    phi=linspace(0, D(4), N);
    theta=linspace(0, D(5), N);
    psi=linspace(0, D(6), N);

    for n=1:N
        
        %Ainda está na origem
        M=trans(x(n), y(n), z(n)) * rotx(phi(n)) * roty(theta(n)) * rotz(psi(n)) ;

        %mexer para o sitio de partida. Aplicar a pInicial
        T=pInicial*M;
        P1=T*P;

        set(h, 'XData', P1(1,:), 'YData', P1(2,:), 'ZData', P1(3,:))
        pause(0.03)
    end

    pFinal=T;

end