function Q = invkinRRRantro(x,y,z,L1,L2,L3)
    % L1,L2,L3 - os comprimentos dos elos
    % x,y,z - coordenadas da ponta (ou o mesmo que: Pwx ,Pwy ,Pwz )
    % devem ser retornadas as 4 redundâncias

    theta3 = acos( (x^2+y^2+(z-L1)^2-L2^2-L3^2) / (2*L2*L3) );

    if ~isreal(theta3)
        Q=nan;
        return
    end

    q3=[theta3 -theta3];

    theta2a=2*atan( ( (L3*cos(q3)+L2) + sqrt( L3^2*sin(q3).^2 + (L3*cos(q3)+L2).^2 - (z-L1)^2 ) ) ./ (L3*sin(q3)+z-L1) );
    theta2b=2*atan( ( (L3*cos(q3)+L2) - sqrt( L3^2*sin(q3).^2 + (L3*cos(q3)+L2).^2 - (z-L1)^2 ) ) ./ (L3*sin(q3)+z-L1) );

    q3=[q3 q3];
    q2=[theta2a theta2b];

    k=L3*cos(q2+q3)+L2*cos(q2);

    q1=atan2(y*sign(k), x*sign(k));

    Q=[q1; q2; q3];
end