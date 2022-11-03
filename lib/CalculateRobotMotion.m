function AAA=CalculateRobotMotion(MDH)

    N=size(MDH,1); %num of lnks (lines of Dh)
    M=size(MDH,3); %num of positions

    AAA=zeros(4, 4, N, M);

    for n=1:M
        AAA(:,:,:,n)=Tlinks(MDH(:,:,n));
    end

end