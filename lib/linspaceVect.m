function MQ=linspaceVect(Qi, Qf, N)
    %A função deve emular a operação de linspace sobre vetores.
    %Qi - vetor dos valores iniciais
    %Qf - vetor dos valores finais
    %N - número de elementos dos linspace
    %MQ - matriz com todos os vetores — cada linha será o linspace dos
    %elementos correspondentes de Qi até Qf.

    MQ=zeros(numel(Qi), N);

    for n=1:numel(Qi)

        MQ(n,:)=linspace(Qi(n), Qf(n), N);

    end

end