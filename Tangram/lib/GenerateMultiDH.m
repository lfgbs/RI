function MDH=GenerateMultiDH(DH, MQ, t)
    %MDH - hipermatriz de matrizes DH definidas para os diversos vetores
    %coluna de MQ.
    %DH - A matriz base de Denavit-Hartenberg que corresponde à posição
    %zero do robô (juntas no valor de home position)
    %MQ - dado por Linespacevect(Qi, Qf, N)
    %t - vetor de 1s ou 0s que indica para cada junta se esta é
    %rotacional(0) ou prismatica(1)

    if nargin<3
        t=zeros(1,size(DH,1));
    end

    MDH=zeros(size(DH,1), 4, size(MQ,2));
    
    for n=1:size(MQ,2)
        
        MDH(:,:,n)=DH;

        for j=1:size(DH,1)
            if t(j)==0
                MDH(j,1,n)=MDH(j,1,n)+MQ(j,n);
            else
                MDH(j,3,n)=MDH(j,1,n)+MQ(j,n);
            end
        end

    end

end