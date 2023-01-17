function tangram(phi, theta)

    clc % Clear all text from command window
    close all % Close all figures previously opened 
    addpath '/lib'

    l=1;
    s=10;
    p_name={'square' 't1' 't2' 't3' 't4' 't5' 'pgram'};

    phi=deg2rad(phi);
    theta=deg2rad(theta);


    grid on
    axis equal
    axis([-5*l 5*l -5*l 5*l -5*l 5*l])
    view(3)
    hold on

    v = VideoWriter('tangram.avi');
    open(v);

    set(gcf, 'Position',  [1000, 150, 800, 700])

    xlabel('X')
    ylabel('Y')
    zlabel('Z')

    %criar base - talvez possa ser feito junto com as peças

    %criar peças
    pieces=createPieces(l, p_name);

    %formação inicial das peças sobre a base
    [pieces, angles]=setInitialPosition(phi, theta, pieces, l, s);

    %criar formações
    [formations, init]=createFormations(l, angles);
    f_names=fieldnames(formations);

    %mexer peças
    for f = 1:size(f_names,1)
        
        formation=f_names(f);
        name=formation{1};

        %mover para posição na formação
        pieces=moveToFormation(formations, name, pieces, s);

    end

    %voltar à posição horizontal
    resetBoard(init, pieces, phi, theta,s);

end

function config=createPieces(l, p_name)
    %config - Vector contendo as peças criadas
    %l - lado do quadrado, usado como referência para o resto das pepieceças
    %p_name - array com a nomenclatura das peças, vai ser usado para criar
    %e referenciar os campos respetivos a cada peça

    %thickness constante
    t=0.2;

    %criar peças
    for i=1:size(p_name,2)
        name=p_name(i);
        piece=name{1};

        if strcmp(piece, 'square')
            [P,F]=create_square(l,t);
            config.(piece).object=P;
            config.(piece).color='b';

        elseif strcmp(piece, 't1')
            [P,F]=create_small_triangle(l,t);
            config.(piece).object=P;
            config.(piece).color='r';

        elseif strcmp(piece, 't2')
            [P,F]=create_small_triangle(l,t);
            config.(piece).object=P;
            config.(piece).color='g';

        elseif strcmp(piece, 't3')
            [P,F]=create_medium_triangle(l,t);
            config.(piece).object=P;
            config.(piece).color='m';

        elseif strcmp(piece, 't4')
            [P,F]=create_large_triangle(l,t);
            config.(piece).object=P;
            config.(piece).color='y';

        elseif strcmp(piece, 't5')
            [P,F]=create_large_triangle(l,t);
            config.(piece).object=P;
            config.(piece).color='c';

        elseif strcmp(piece, 'pgram')
            [P,F]=create_pgram(l,t);
            config.(piece).object=P;
            config.(piece).color='k';

        else
            error("Piece not recognized.")
        end

        config.(piece).pI=eye(4); %matriz identidade para retratar que ainda não se moveu
        config.(piece).handle=patch('Vertices', P(1:3,:)', 'Faces', F, 'Facecolor', config.(piece).color);
    end

end

%criar quadrado
function [P, F]=create_square(l, t)
    P=[0 l l 0 0 l l 0
       0 0 l l 0 0 l l
       0 0 0 0 t t t t
       1 1 1 1 1 1 1 1];

    F=[1 2 3 4
       5 6 7 8
       1 4 8 5
       2 3 7 6
       1 2 6 5 
       3 4 8 7];
end

%criar t1 e t2
function [P, F]=create_small_triangle(l,t)
    P=[0 l 0 0 l 0
       0 0 l 0 0 l
       0 0 0 t t t
       1 1 1 1 1 1];

    F=[1 2 3 nan
       4 5 6 nan
       1 2 5 4
       1 3 6 4
       2 3 6 5];
end

%criar t3 
function [P,F]=create_medium_triangle(l,t)
    P=[0 l*sqrt(2) 0 0 l*sqrt(2) 0
       0 0 l*sqrt(2) 0 0 l*sqrt(2)
       0 0 0 t t t
       1 1 1 1 1 1];

    F=[1 2 3 nan
       4 5 6 nan
       1 2 5 4
       1 3 6 4
       2 3 6 5];
end

%criar t4 e t5
function [P,F]=create_large_triangle(l,t)
    P=[0 2*l 0 0 2*l 0
       0 0 2*l 0 0 2*l 
       0 0 0 t t t
       1 1 1 1 1 1];

    F=[1 2 3 nan
       4 5 6 nan
       1 2 5 4
       1 3 6 4
       2 3 6 5];
end

%criar paralelogramo
function [P, F]=create_pgram(l,t)
    P=[0 0 l*(sqrt(2)/2) l*(sqrt(2)/2) 0 0 l*(sqrt(2)/2) l*(sqrt(2)/2)
       0 sqrt(2)*l (3*l*sqrt(2))/2 l*(sqrt(2)/2) 0 sqrt(2)*l (3*l*sqrt(2))/2 l*(sqrt(2)/2)   
       0 0 0 0 t t t t 
       1 1 1 1 1 1 1 1];

    %P=[]

    F=[1 2 3 4
       5 6 7 8
       1 4 8 5
       2 3 7 6
       1 2 6 5 
       3 4 8 7];
end

%move peças para a posição inicial
function [pieces, angles]=setInitialPosition(phi, theta, pieces,l,s)
    %%P_struct - Vector contendo as peças criadas
    fields=fieldnames(pieces);

    %definir posições iniciais
    angles=linspace(0,2*pi-2*pi/size(fields,1), size(fields,1));

    angles=angles(randperm(length(angles)));

    angles_theta=linspace(0, theta ,s);
    angles_phi=linspace(0, phi ,s);

    %para cada peça definir a posição
    for i=1:size(fields,1)
        name=fields(i);
        piece=name{1};

        T(:,:,:,1)=mrotx(angles_theta); 
        T(:,:,:,2)=mroty(angles_phi);
        T(:,:,:,3)=mrotz(linspace(0, angles(i), s));
        T(:,:,:,4)=mtrans(linspace(0,3*l, s), 0, 0);

        order=[0, 0, 1, 1];

        %depois de definir as transformações necessárias para chegar à
        %posiçao, animar
        for n=1:size(T,4)
            pieces.(piece).pI=manimate(pieces.(piece).handle, pieces.(piece).object, pieces.(piece).pI, T(:,:,:,n), order(n));
        end

    end
end

function [formations, init]=createFormations(l, angles)
    %devolve uma estrutura que define as rotações e translações locais de cada peça dentro de
    %cada formação para ficar na posição certa

    %%%%%%%%%%%%%%%%%%%%%%FORMAÇÃO QUADRADO%%%%%%%%%%%%%%%%%%%%%
    formations.quadrado.square.pos1=[-3*l,0,0];
    formations.quadrado.square.pos2=[0,0,0];
    formations.quadrado.square.rot1=0;
    formations.quadrado.square.rot2=-angles(1);
    formations.quadrado.square.rot3=0;

    formations.quadrado.t1.pos1=[-3*l, 0, 0];
    formations.quadrado.t1.pos2=[l, l, 0];
    formations.quadrado.t1.rot1=0;
    formations.quadrado.t1.rot2=-angles(2);
    formations.quadrado.t1.rot3=-pi/2;

    formations.quadrado.t2.pos1=[-3*l,0,0];
    formations.quadrado.t2.pos2=[0, l, 0];
    formations.quadrado.t2.rot1=0;
    formations.quadrado.t2.rot2=-angles(3);
    formations.quadrado.t2.rot3=pi;

    formations.quadrado.t3.pos1=[-3*l,0,0];
    formations.quadrado.t3.pos2=[l, -l, 0];
    formations.quadrado.t3.rot1=0;
    formations.quadrado.t3.rot2=-angles(4);
    formations.quadrado.t3.rot3=pi/4;

    formations.quadrado.t4.pos1=[-3*l,0,0];
    formations.quadrado.t4.pos2=[l, l, 0];
    formations.quadrado.t4.rot1=0;
    formations.quadrado.t4.rot2=-angles(5);
    formations.quadrado.t4.rot3=pi/2;

    formations.quadrado.t5.pos1=[-3*l,0,0];
    formations.quadrado.t5.pos2=[l, l, 0];
    formations.quadrado.t5.rot1=0;
    formations.quadrado.t5.rot2=-angles(6);
    formations.quadrado.t5.rot3=0;

    formations.quadrado.pgram.pos1=[-3*l,0,0];
    formations.quadrado.pgram.pos2=[l, 0, 0];
    formations.quadrado.pgram.rot1=0;
    formations.quadrado.pgram.rot2=-angles(7);
    formations.quadrado.pgram.rot3=-pi/4;

    %%%%%%%%%%%%%%%%%%%%%%%FORMAÇÃO CAT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    formations.cat.square.pos1=-formations.quadrado.square.pos2;
    formations.cat.square.pos2=[0,0,0];
    formations.cat.square.rot1=-formations.quadrado.square.rot3;
    formations.cat.square.rot2=0;
    formations.cat.square.rot3=pi/4;

    formations.cat.t1.pos1=-formations.quadrado.t1.pos2;
    formations.cat.t1.pos2=[-sin(pi/4)*l, cos(pi/4)*l, 0];
    formations.cat.t1.rot1=-formations.quadrado.t1.rot3;
    formations.cat.t1.rot2=0;
    formations.cat.t1.rot3=-3*pi/4;

    formations.cat.t2.pos1=-formations.quadrado.t2.pos2;
    formations.cat.t2.pos2=[-sin(pi/4)*l, cos(pi/4)*l, 0];
    formations.cat.t2.rot1=-formations.quadrado.t2.rot3;
    formations.cat.t2.rot2=0;
    formations.cat.t2.rot3=pi/4;

    formations.cat.t3.pos1=-formations.quadrado.t3.pos2;
    formations.cat.t3.pos2=[cos(pi/4)*l, l+cos(pi/4)*l, 0];
    formations.cat.t3.rot1=-formations.quadrado.t3.rot3;
    formations.cat.t3.rot2=0;
    formations.cat.t3.rot3=pi/4;

    formations.cat.t4.pos1=-formations.quadrado.t4.pos2;
    formations.cat.t4.pos2=[cos(pi/4)*l-l+sqrt(2)*l, 2*l+cos(pi/4)*l+l^2*sqrt(2), 0];
    formations.cat.t4.rot1=-formations.quadrado.t4.rot3;
    formations.cat.t4.rot2=0;
    formations.cat.t4.rot3=-3*pi/4;

    formations.cat.t5.pos1=-formations.quadrado.t5.pos2;
    formations.cat.t5.pos2=[cos(pi/4)*l-l+sqrt(2)*l+2*l, 2*l+cos(pi/4)*l+l^2*sqrt(2) , 0];
    formations.cat.t5.rot1=-formations.quadrado.t5.rot3;
    formations.cat.t5.rot2=0;
    formations.cat.t5.rot3=pi;

    formations.cat.pgram.pos1=-formations.quadrado.pgram.pos2;
    formations.cat.pgram.pos2=[cos(pi/4)*l*l, cos(pi/4)*l,0];
    formations.cat.pgram.rot1=-formations.quadrado.pgram.rot3;
    formations.cat.pgram.rot2=0;
    formations.cat.pgram.rot3=pi/4;

    %%%%%%%%%%%%%%%%%%%%%%%FORMAÇÃO HOUSE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    formations.house.square.pos1=-formations.cat.square.pos2;
    formations.house.square.pos2=[0,0,0];
    formations.house.square.rot1=-formations.cat.square.rot3;
    formations.house.square.rot2=0;
    formations.house.square.rot3=0;

    formations.house.t1.pos1=-formations.cat.t1.pos2;
    formations.house.t1.pos2=[l+l^2+sqrt(2)*l/2, l+sqrt(2)*l/2, 0];
    formations.house.t1.rot1=-formations.cat.t1.rot3;
    formations.house.t1.rot2=0;
    formations.house.t1.rot3=3*pi/4;

    formations.house.t2.pos1=-formations.cat.t2.pos2;
    formations.house.t2.pos2=[l+l^2+sqrt(2)*l/2, l+sqrt(2)*l/2, 0];
    formations.house.t2.rot1=-formations.cat.t2.rot3;
    formations.house.t2.rot2=0;
    formations.house.t2.rot3=pi/4;

    formations.house.t3.pos1=-formations.cat.t3.pos2;
    formations.house.t3.pos2=[l+l^2, l-l^2*sqrt(2), 0];
    formations.house.t3.rot1=-formations.cat.t3.rot3;
    formations.house.t3.rot2=0;
    formations.house.t3.rot3=0;

    formations.house.t4.pos1=-formations.cat.t4.pos2;
    formations.house.t4.pos2=[l+l^2-sqrt(2)*l, l*sqrt(2), 0];
    formations.house.t4.rot1=-formations.cat.t4.rot3;
    formations.house.t4.rot2=0;
    formations.house.t4.rot3=-pi/4;

    formations.house.t5.pos1=-formations.cat.t5.pos2;
    formations.house.t5.pos2=[l+l^2, l , 0];
    formations.house.t5.rot1=-formations.cat.t5.rot3;
    formations.house.t5.rot2=0;
    formations.house.t5.rot3=-pi/4;

    formations.house.pgram.pos1=-formations.cat.pgram.pos2;
    formations.house.pgram.pos2=[l, l, 0];
    formations.house.pgram.rot1=-formations.cat.pgram.rot3;
    formations.house.pgram.rot2=0;
    formations.house.pgram.rot3=-3*pi/4;

    %%%%%%%%%%%%%RESET BOARD%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    init.square.pos1=-formations.house.square.pos2;
    init.square.pos2=[-3*l,0,0];
    init.square.rot1=-formations.house.square.rot3;
    init.square.rot2=angles(1);
    init.square.rot3=0;
    
    init.t1.pos1=-formations.house.t1.pos2;
    init.t1.pos2=[-3*l, 0, 0];
    init.t1.rot1=-formations.house.t1.rot3;
    init.t1.rot2=angles(2);
    init.t1.rot3=0;
    
    init.t2.pos1=-formations.house.t2.pos2;
    init.t2.pos2=[-3*l, 0, 0];
    init.t2.rot1=-formations.house.t2.rot3;
    init.t2.rot2=angles(3);
    init.t2.rot3=0;
    
    init.t3.pos1=-formations.house.t3.pos2;
    init.t3.pos2=[-3*l, 0, 0];
    init.t3.rot1=-formations.house.t3.rot3;
    init.t3.rot2=angles(4);
    init.t3.rot3=0;

    init.t4.pos1=-formations.house.t4.pos2;
    init.t4.pos2=[-3*l, 0, 0];
    init.t4.rot1=-formations.house.t4.rot3;
    init.t4.rot2=angles(5);
    init.t4.rot3=0;
    
    init.t5.pos1=-formations.house.t5.pos2;
    init.t5.pos2=[-3*l, 0, 0];
    init.t5.rot1=-formations.house.t5.rot3;
    init.t5.rot2=angles(6);
    init.t5.rot3=0;
    
    init.pgram.pos1=-formations.house.pgram.pos2;
    init.pgram.pos2=[-3*l, 0, 0];
    init.pgram.rot1=-formations.house.pgram.rot3;
    init.pgram.rot2=angles(7);
    init.pgram.rot3=-0;
    

end

function pieces=moveToFormation(formations, formation_name, pieces, s)
    %move peças para a posição de acordo com a formação desejada
    %formations- struct que contém todas as formações definidas e posições
    %de peças associadas
    %formation_name - indica qual é a formação a considerar
    %pieces - struct que contém peças do jogo
    %s - step, usado no linsapce

    disp(formation_name)

    %movimento das peças 
    fields=fieldnames(pieces);

    for i=1:size(fields,1)
        name=fields(i);
        piece=name{1};

        %transf para pôr a peça na posiçao definida pela formação em
        %questão, é só por uma questão de conveniencia
        transf_vector1=formations.(formation_name).(piece).pos1;
        transf_vector2=formations.(formation_name).(piece).pos2;
        
        T(:,:,:,1)=mrotz(linspace(0,formations.(formation_name).(piece).rot1 ,s));
        T(:,:,:,2)=mtrans(linspace(0, transf_vector1(1), s), linspace(0, transf_vector1(2), s), linspace(0, transf_vector1(3), s)); 
        T(:,:,:,3)=mrotz(linspace(0,formations.(formation_name).(piece).rot2 ,s));
        T(:,:,:,4)=mtrans(linspace(0, transf_vector2(1), s), linspace(0, transf_vector2(2), s), linspace(0, transf_vector2(3), s));
        T(:,:,:,5)=mrotz(linspace(0, formations.(formation_name).(piece).rot3,s));

        order=[1,1,1,1,1];

        %depois de definir as transformações necessárias para chegar à
        %posiçao, animar
        for n=1:size(T,4)
            pieces.(piece).pI=manimate(pieces.(piece).handle, pieces.(piece).object, pieces.(piece).pI, T(:,:,:,n), order(n));
        end
    end
    
    displayCompleted(pieces)
    
end

function displayCompleted(pieces)

    %movimento das peças 
    fields=fieldnames(pieces);

    for n=1:3

        for i=1:size(fields,1)
            name=fields(i);
            piece=name{1};
        
            set(pieces.(piece).handle, 'Facecolor', "#808080")
        end

        pause(0.25)

        for i=1:size(fields,1)
            name=fields(i);
            piece=name{1};
        
            set(pieces.(piece).handle, 'Facecolor', pieces.(piece).color)
        end

        pause(0.25)
    end
end

function resetBoard(init, pieces, phi, theta, s)
    %retorna o tabuleiro à posição original
    %pieces - struct devolvida que contém peças do jogo

    %pieces_in - struct passada como argumento que contém peças do jogo

    %deve usar a tranformação guardada no struct para reverter a mesma

    %depois de o tabuleiro voltar à posição inicial acho que posso usar o
    %set_initial_position de novo para repor as peças e depois começar
    %então outro ciclo de montagem de formação

    angles_theta=linspace(0, theta ,s);
    angles_phi=linspace(0, phi ,s);

    fields=fieldnames(pieces);


    for i=1:size(fields,1)

        name=fields(i);
        piece=name{1};

        T(:,:,:,1)=mrotz(linspace(0,init.(piece).rot1 ,s));
        T(:,:,:,2)=mtrans(linspace(0, init.(piece).pos1(1), s), linspace(0, init.(piece).pos1(2), s), linspace(0, init.(piece).pos1(3), s)); 
        T(:,:,:,3)=mrotz(linspace(0, init.(piece).rot2 ,s));
        T(:,:,:,4)=mtrans(linspace(0, init.(piece).pos2(1), s), linspace(0, init.(piece).pos2(2), s), linspace(0, init.(piece).pos2(3), s));
        T(:,:,:,5)=mroty(-angles_phi);
        T(:,:,:,6)=mrotx(-angles_theta); 

        order=[1,1,1,1,0,0];

        %depois de definir as transformações necessárias para chegar à
        %posiçao, animar
        for n=1:size(T,4)
            pieces.(piece).pI=manimate(pieces.(piece).handle, pieces.(piece).object, pieces.(piece).pI, T(:,:,:,n), order(n));
        end

        
    end
  
end