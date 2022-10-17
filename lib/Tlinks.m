function AA=Tlinks(DH)
    %Aceita uma matriz de Denavit-Hartenberg (DH) e devolve uma
    %matriz de transformação para cada elo (linha de DH) dispostas ao
    %longo da 3ª dimensão da hipermatriz AA.
    %Invoca a função Tlink() anterior.

    AA=zeros(4,4,size(DH,1));

    for n=1:size(DH,1)
        AA(:,:,n)=Tlink(DH(n,1), DH(n,2), DH(n,3), DH(n,4));
    end

end