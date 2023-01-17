function Q = invkinRR(x, y, L1, L2)

        q2A=acos((x^2+y^2-L1^2-L2^2)/(2*L1*L2));

        if ~isreal(q2A)
            Q=nan(2,2);
            return
        end

        q2=[q2A -q2A];

        q1=atan2( (y*(L1+L2*cos(q2)) - x*L2*sin(q2)) ,  (x*(L1+L2*cos(q2)) + y*L2*sin(q2)) );

        Q = [q1(1) q1(2); q2(1) q2(2)];
end