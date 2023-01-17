function H=DrawFrames(AA, P, F)

    H=cell(1,size(AA,3));

    T=eye(4); %initial transformation

    patch('Vertices', P(1:3, :)', 'Faces', F, 'FaceColor', 'w')

    for n=1:size(AA,3)

        T=T*AA(:,:,n);
        Q=T*P;

        h=patch('Vertices', Q(1:3, :)', 'Faces', F, 'FaceColor', 'g');

        H{n}=h;
    
    end
end