function [QQ, t] = PolyTrajV(Q0, Qf, Qv0, Qvf, N, t0, tf)

    if (tf==t0)
        QQ=nan;
        return
    end

    if Qv0==0
        Qv0=zeros(size(Q0));
    end

    if Qvf==0
        Qvf=zeros(size(Qvf));
    end

    t=linspace(t0, tf, N);

    a0=Q0;
    a1=Qv0;
    a2=3/(tf-t0)^2 * (Qf-Q0) - 2/(tf-t0)*Qv0 - 1/(tf-t0)*Qvf;
    a3=-2/(tf-t0)^3 * (Qf-Q0) + 1/(tf-t0)^2 * (Qvf+Qv0);

    QQ=a0+a1*(t-t0) + a2*(t-t0).^2 + a3*(t-t0).^3;


end