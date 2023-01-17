function Q = invkinRRR(x, y, phi, L1, L2, L3)

    pwx=x-L3*cos(phi);
    pwy=y-L3*sin(phi);

    QA=invkinRR(pwx, pwy, L1, L2);

    q3=phi-sum(QA);

    Q=[QA; q3];

end