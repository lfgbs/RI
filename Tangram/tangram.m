function tangram()

    clc % Clear all text from command window
    close all % Close all figures previously opened
    clear % Clear previous environment variables
    clearvars 
    addpath RI/lib/

    l=1;
    s=20;
    p_name={'square' 't1' 't2' 't3' 't4' 't5' 'pgram'};

    grid on
    axis equal
    axis([-5*l 5*l -5*l 5*l -5*l 5*l])
    view(130, 20)
    hold on

    set(gcf, 'Position',  [1000, 150, 800, 700])

    xlabel('X')
    ylabel('Y')
    zlabel('Z')

    %criar base - talvez possa ser feito junto com as peças

    %criar peças
    pieces=create_pieces(l, p_name);

    %criar formações
    formations=createFormations(l);
    f_names=fieldnames(formations);

    %formação inicial das peças sobre a base
    pieces=set_initial_position(pieces, l, s);

    %rodar para a posição - skip this for now - mas acho que vou fazer
    %uma função que vai ser chamada dentro do move to Formation

    %mexer peças
    for f = 1:size(f_names,1)-2 %REMOVER O "-2" QUANDO ACABAR A FASE DE TESTES
        formation=f_names(f);
        name=formation{1};
        pieces=moveToFormation(formations, name, pieces, s);
    end

end

function config=create_pieces(l, p_name)
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
          
        elseif strcmp(piece, 'square2')
            [P,F]=create_square(l,t);
            config.(piece).object=P;
            config.(piece).color='g';

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
    P=[0 sqrt(2)*l (3*l*sqrt(2))/2 l*(sqrt(2)/2) 0 sqrt(2)*l (3*l*sqrt(2))/2 l*(sqrt(2)/2)
      0 0 l*(sqrt(2)/2) l*(sqrt(2)/2) 0 0 l*(sqrt(2)/2) l*(sqrt(2)/2)
      0 0 0 0 t t t t 
      1 1 1 1 1 1 1 1];

    F=[1 2 3 4
       5 6 7 8
       1 4 8 5
       2 3 7 6
       1 2 6 5 
       3 4 8 7];
end

%move peças para a posição inicial
function pieces=set_initial_position(pieces,l,s)
    %%P_struct - Vector contendo as peças criadas
    fields=fieldnames(pieces);
    
    %uma posição para cada peça
    position=1:size(fields,1);

    %scramble positions para dar posição inicial random a cada uma das
    %peças
    idx = randperm(size(position,2)) ;
    b = position ;
    position(1,idx) = b(1,:);

    %definir posições iniciais
    angles=linspace(0,2*pi,size(fields,1)+1);

    %para cada peça definir a posição
    for i=1:size(fields,1)
        name=fields(i);
        piece=name{1};
        T(:,:,:,1)=mtrans(linspace(0,3*l, s), 0, 0);
        T(:,:,:,2)=mrotz(linspace(0, angles(position(i)), s));
        order=[0,0];
        %depois de definir as transformações necessárias para chegar à
        %posiçao, animar
        for n=1:size(T,4)
            pieces.(piece).pI=manimate(pieces.(piece).handle, pieces.(piece).object, pieces.(piece).pI, T(:,:,:,n), order);
        end

    end
end

function formations=createFormations(l)
    %devolve uma estrutura que define as posições de cada peça dentro de
    %cada formação

    %%%%%%%%%%%%%%%%%%%%%%FORMAÇÃO QUADRADO%%%%%%%%%%%%%%%%%%%%%
    formations.quadrado.square.pos=[0,0,0];
    formations.quadrado.square.rot=0;

    formations.quadrado.t1.pos=[0,0,0];
    formations.quadrado.t1.rot=pi;

    formations.quadrado.t2.pos=[0,0,0];
    formations.quadrado.t2.rot=pi/2;

    formations.quadrado.t3.pos=[0,0,0];
    formations.quadrado.t3.rot=pi/4;

    formations.quadrado.t4.pos=[0,0,0];
    formations.quadrado.t4.rot=pi/8;

    formations.quadrado.t5.pos=[0,0,0];
    formations.quadrado.t5.rot=0;

    formations.quadrado.pgram.pos=[0,0,0];
    formations.quadrado.pgram.rot=pi/6;

%     formations.quadrado.theta=2*pi*rand();
%     formations.quadrado.phi=(pi/2)*rand();
    formations.quadrado.theta=pi;
    formations.quadrado.phi=(pi/2)*rand();

    %%%%%%%%%%%%%%%%%%%%%%%FORMAÇÃO CAT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    formations.cat.square.pos=[0,0,0];
    formations.cat.t1.pos=[0,0,0];
    formations.cat.t2.pos=[0,0,0];
    formations.cat.t3.pos=[0,0,0];
    formations.cat.t4.pos=[0,0,0];
    formations.cat.t5.pos=[0,0,0];
    formations.cat.pgram.pos=[0,0,0];

    formations.cat.theta=2*pi*rand();
    formations.cat.phi=(pi/2)*rand();

    %%%%%%%%%%%%%%%%%%%%%%%FORMAÇÃO HOUSE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    formations.house.square.pos=[0,0,0];
    formations.house.t1.pos=[0,0,0];
    formations.house.t2.pos=[0,0,0];
    formations.house.t3.pos=[0,0,0];
    formations.house.t4.pos=[0,0,0];
    formations.house.t5.pos=[0,0,0];
    formations.house.pgram.pos=[0,0,0];

    formations.house.theta=2*pi*rand();
    formations.house.phi=(pi/2)*rand();

end

function pieces=moveToFormation(formations, formation_name, pieces, s)
    %move peças para a posição de acordo com a formação desejada
    %formations- struct que contém todas as formações definidas e posições
    %de peças associadas
    %formation_name - indica qual é a formação a considerar
    %pieces - struct que contém peças do jogo
    %s - step, usado no linsapce

    disp(formation_name)

    %aplicar angulos de rotação ao jogo
    pieces=rotateBoard(formations, formation_name, pieces, s);

    %movimento das peças 

    fields=fieldnames(pieces);

    for i=1:size(fields,1)
        name=fields(i);
        piece=name{1};
        %transf para pôr a peça na posiçao definida pela formação em
        %questão

        %posição atual do objeto 
        curr_pos_obj=pieces.(piece).pI*pieces.(piece).object;
        %posição do pivot
        curr_pos_pivot=curr_pos_obj(1:3,1);
        %posição alvo
        target_pos=formations.(formation_name).(piece).pos;
        %cálculo do vetor com base na posição do pivot e na posição alvo
        transf_vector=[target_pos(1) - curr_pos_pivot(1), target_pos(2) - curr_pos_pivot(2), target_pos(3) - curr_pos_pivot(3) ];

        %ROTAÇÃO
        %rotação atual. Obtida apartir do acos
        curr_rot=acos(pieces.(piece).pI(1,1));
        %rotação alvo
        target_rot=formations.(formation_name).(piece).rot;

        %APLICAÇÃO
        %Aplicar a todos os pontos o vetor calculado
        T(:,:,:,1)=mtrans(linspace(0, transf_vector(1), s), linspace(0, transf_vector(2), s), linspace(0, transf_vector(3), s)); 
        %aplicar rotação
        T(:,:,:,2)=mrotz(linspace(0, target_rot-curr_rot,s));
       
        order=[0,0];%CHECK THIS!!!!!

        %depois de definir as transformações necessárias para chegar à
        %posiçao, animar
        for n=1:size(T,4)
            pieces.(piece).pI=manimate(pieces.(piece).handle, pieces.(piece).object, pieces.(piece).pI, T(:,:,:,n), order);
        end
    end
    
    disp("pausing")
    pause(0.5) %não esquecer de aumentar o pause quando acabar os TESTES
    disp("proceed")
    
    %voltar à posição horizontal
    pieces=resetBoard(formations, name, pieces);

    disp("done")
    
end

function pieces=rotateBoard(formations, name,pieces_in, s)
    %roda o tabuleiro
    %pieces - struct devolvida que contém peças do jogo

    %pieces_in - struct passada como argumento que contém peças do jogo

    %aceder aos angulos guardados em formations
    angles_theta=linspace(0, formations.(name).theta ,s);
    angles_phi=linspace(0, formations.(name).phi ,s);

    fields=fieldnames(pieces_in);

    %aplicar rotações
    for i=1:size(fields,1)
        name=fields(i);
        piece=name{1};
        T(:,:,:,1)=mroty(linspace(0, angles_theta(i), s));
        T(:,:,:,2)=mrotz(linspace(0, angles_phi(i), s));
        order=[0,0];
        %depois de definir as transformações necessárias para chegar à
        %posiçao, animar
        for n=1:size(T,4)
            pieces_in.(piece).pI=manimate(pieces_in.(piece).handle, pieces_in.(piece).object, pieces_in.(piece).pI, T(:,:,:,n), order);
        end

    end

    pieces=pieces_in;

end

function pieces=resetBoard(formations, name, pieces_in)
    %retorna o tabuleiro à posição original
    %pieces - struct devolvida que contém peças do jogo

    %pieces_in - struct passada como argumento que contém peças do jogo

    %deve usar a tranformação guardada no struct para reverter a mesma

    %depois de o tabuleiro voltar à posição inicial acho que posso usar o
    %set_initial_position de novo para repor as peças e depois começar
    %então outro ciclo de montagem de formação
    pieces=pieces_in;
end