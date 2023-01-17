function [QQ, t]=MultiPolyTrajV(Q,N,tt)
    
    V=zeros(size(Q));
    QQ=[]; t=[];

    for i=size(Q,2)-1
        Qi=Q(:,i);
        Qf=Q(:,i+1);

        Vi=V(:,i);
        Vf=V(:,i+1);

        t0=tt(i);
        tf=tt(i+1);

        [q, ttt]=PolyTrajV(Qi, Qf, Vi, Vf, N, t0, tf);

        QQ=[QQ q];
        t=[t ttt];

    end
    

end