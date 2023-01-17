function J=jacobianRR(Q, L1, L2)
    %Q " rq1, q2sT é o vetor das juntas
    %L1 e L2 são os comprimentos dos elos

    
    S1=sin(Q(1));
    C1=cos(Q(1));
    S12=sin(Q(1)+Q(2));
    C12=cos(Q(1)+Q(2));

    J=[-L1*S1-L2*S12 -L2*S12
        L1*C1+L2*C12 L2*C12];
    

end