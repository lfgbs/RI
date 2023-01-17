function Tlast=manimate(h, P, Tcurr, Tset, ord)
    %h – handle gráfico do objeto a animar (movimentar);
    %P – matriz de pontos do objeto (no formato homogéneo);
    %Tcurr – Matriz de transformação da posição inicial do objeto (inı́cio da
    %animação);
    %Tset – hipermatriz de transformações geométricas com o conjunto dos
    %passos intermédios para a animação (sucessivas posições do objeto P).
    %ord – indicador se as transformações presentes na hipermatriz são para
    %ser feitas no referencial local (ord=1) ou no referencial global (ord=0);
    %Tlast – última posição (matriz de transformação) onde foi deixado o
    %objeto no fim da animação.


    m=size(Tset,3);

    if nargin < 5
        ord=zeros(1, m);
    end

    %padding se o vetor for muito pequeno
    ord(end:m)=ord(end);

    for n=1:m

        if ord(n)==1 %local
            TT=Tcurr*Tset(:,:,n);

        else%global
            TT=Tset(:,:,n)*Tcurr;
        end

        Pn=TT*P;
        set(h, 'Vertices', Pn(1:3,:)')
        pause(0.05)
    end

    Tlast=TT;

end