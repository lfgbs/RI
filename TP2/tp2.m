%% Initial configurations
clc % Clear all text from command window
close all % Close all figures previously opened
clear % Clear previous environment variables
addpath RI/lib/ % Update yout matlab path (the folder must exist)

hold on; axis equal; grid on; axis([-1600 1200 -1800 1300 -600 1600])
xlabel('X')
ylabel('Y')
view(3)

%main tapete dimensions
mtw=625;
mtl=2560;

%secondary tapete dimensions
stw=625;
stl=1250;

%table leg dimensions
ll=560;
lw=50;

p_name={'mt' 'st1' 'st2' 'mtl1' 'mtl2' 'mtl3' 'mtl4' 'st1l1' 'st1l2' 'st1l3' 'st1l4' 'st2l1' 'st2l2' 'st2l3' 'st2l4'};

%spacing
setup.st1.xs=205;
setup.st1.ys=-370;
setup.st1.rot=-pi/2;

setup.st2.xs=-205-stw;
setup.st2.ys=-370;
setup.st2.rot=-pi/2;

setup.mt.xs=-1540;
setup.mt.ys=440;
setup.mt.rot=0;

setup.mtl1.xs=-1540;
setup.mtl1.ys=440;
setup.mtl1.rot=0;

setup.mtl2.xs=-1540;
setup.mtl2.ys=440+mtw-lw;
setup.mtl2.rot=0;

setup.mtl3.xs=-1540+mtl-lw;
setup.mtl3.ys=440;
setup.mtl3.rot=0;

setup.mtl4.xs=-1540+mtl-lw;
setup.mtl4.ys=440+mtw-lw;
setup.mtl4.rot=0;

setup.st1l1.xs=205;
setup.st1l1.ys=-370-lw;
setup.st1l1.rot=0;

setup.st1l2.xs=205+stw-lw;
setup.st1l2.ys=-370-stl;
setup.st1l2.rot=0;

setup.st1l3.xs=205;
setup.st1l3.ys=-370-stl;
setup.st1l3.rot=0;

setup.st1l4.xs=205+stw-lw;
setup.st1l4.ys=-370-lw;
setup.st1l4.rot=0;

setup.st2l1.xs=-205-stw;
setup.st2l1.ys=-370-lw;
setup.st2l1.rot=0;

setup.st2l2.xs=-205-stw;
setup.st2l2.ys=-370-stl;
setup.st2l2.rot=0;

setup.st2l3.xs=-205-lw;
setup.st2l3.ys=-370-lw;
setup.st2l3.rot=0;

setup.st2l4.xs=-205-lw;
setup.st2l4.ys=-370-stl;
setup.st2l4.rot=0;


%robot default dimensions
L1=181;
L2=176;
L3=613;
L4=137;
L5=572;
L6=135;
L7=120;
L8=332;

DH=[0 0 L1 0
    -pi/2 0 0 -pi/2
    0 0 L2 0
    -pi/2 0 0 0
    0 L3 0 0
    0 0 -L4 0
    pi/2 0 0 pi/2
    0 0 L5 0
    0 0 0 -pi/2
    0 0 L6 0
    0 0 0 pi/2
    0 0 L7 0
    0 0 0 pi/2
    0 0 L8 0];


%criar peças
envObjects=createEnv(mtw, mtl, stw, stl, lw, ll, p_name);

%mover para posição na formação
pieces=moveToFormation(setup, envObjects);


Qi=zeros(14,1);
Qf=[0 0 -pi/4 0 0 3*pi/4 0 pi/2 0 pi/2 0 0 0 pi]';
QQ=[Qi, Qf];

jtypes=zeros(1,14);

[H, h, P, AAA]=InitRobot(QQ, 100, DH, jtypes, 0.5);
AnimateRobot(H, AAA, P, h, 0.03)

%figure
%hold on; axis equal; grid on; axis([-10 200 -10 200 0 200])

%%%%%%%%%%%%%%%%%FUNCTIONS%%%%%%%%%%%%%%%%%%%%

%esta função coloca os tapetes na configuração desejada
function pieces=moveToFormation(setup, pieces)
    %move peças para a posição de acordo com a formação desejada
    %formations- struct que contém todas as formações definidas e posições
    %de peças associadas
    %formation_name - indica qual é a formação a considerar
    %pieces - struct que contém peças do jogo
    %s - step, usado no linsapce

    %movimento das peças 
    fields=fieldnames(pieces);

    for i=1:size(fields,1)
        name=fields(i);
        piece=name{1};

        T(:,:,:,1)=mrotz(setup.(piece).rot);
        T(:,:,:,2)=mtrans(setup.(piece).xs, setup.(piece).ys, 0); 

        %depois de definir as transformações necessárias para chegar à
        %posiçao, animar
        for n=1:size(T,4)
            pieces.(piece).pI=T(:,:,n)*pieces.(piece).pI;
            Pn=pieces.(piece).pI*pieces.(piece).object;
            set(pieces.(piece).handle, 'Vertices', Pn(1:3,:)')
        end
    end
    
end


function config=createEnv(mtw, mtl, stw, stl, lw, ll, p_name)
    %config - Vector contendo as peças criadas
    %l - lado do quadrado, usado como referência para o resto das pepieceças
    %p_name - array com a nomenclatura das peças, vai ser usado para criar
    %e referenciar os campos respetivos a cada peça

    %thickness constante para todos os tapetes
    t=-50;

    %criar peças
    for i=1:size(p_name,2)
        name=p_name(i);
        piece=name{1};

        if strcmp(piece, 'mt')
            [P,F]=createTable(mtw, mtl, t);
            config.(piece).object=P;
            config.(piece).color='g';

        elseif strcmp(piece, 'st1')
            [P,F]=createTable(stw, stl, t);
            config.(piece).object=P;
            config.(piece).color='g';

        elseif strcmp(piece, 'st2')
            [P,F]=createTable(stw, stl, t);
            config.(piece).object=P;
            config.(piece).color='g';

        elseif strcmp(piece, 'mtl1')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';

        elseif strcmp(piece, 'mtl2')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';

        elseif strcmp(piece, 'mtl3')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';
            
        elseif strcmp(piece, 'mtl4')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';

        elseif strcmp(piece, 'st1l1')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';
            
        elseif strcmp(piece, 'st1l2')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';
            
        elseif strcmp(piece, 'st1l3')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';

        elseif strcmp(piece, 'st1l4')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';

        elseif strcmp(piece, 'st2l1')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';

            
        elseif strcmp(piece, 'st2l2')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';
            
        elseif strcmp(piece, 'st2l3')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';
            
        elseif strcmp(piece, 'st2l4')
            [P,F]=createTableLeg(lw, ll);
            config.(piece).object=P;
            config.(piece).color='k';

        else
            error("Piece not recognized.")
        end

        config.(piece).pI=eye(4); %matriz identidade para retratar que ainda não se moveu
        config.(piece).handle=patch('Vertices', P(1:3,:)', 'Faces', F, 'Facecolor', config.(piece).color);
    end

end
    

%%%%%%%criar objetos%%%%%%%%%%%
%criar tapetes
function [P, F]=createTable(tw, tl, t)
    P=[0 tl tl 0 0 tl tl 0
       0 0 tw tw 0 0 tw tw
       0 0 0 0 t t t t
       1 1 1 1 1 1 1 1];

    F=[1 2 3 4
       5 6 7 8
       1 4 8 5
       2 3 7 6
       1 2 6 5 
       3 4 8 7];
end

%criar pernas
function [P, F]=createTableLeg(lw, ll)
    P=[0 lw lw 0 0 lw lw 0
       0 0 lw lw 0 0 lw lw
       0 0 0 0 -ll -ll -ll -ll
       1 1 1 1 1 1 1 1];

    F=[1 2 3 4
       5 6 7 8
       1 4 8 5
       2 3 7 6
       1 2 6 5 
       3 4 8 7];
end

%criar componente C1
function [P, F]=createC1(lw, ll)
    P=[0 lw lw 0 0 lw lw 0
       0 0 lw lw 0 0 lw lw
       0 0 0 0 -ll -ll -ll -ll
       1 1 1 1 1 1 1 1];

    F=[1 2 3 4
       5 6 7 8
       1 4 8 5
       2 3 7 6
       1 2 6 5 
       3 4 8 7];
end

%criar componente C2
function [P, F]=createC2()
    P=[0 lw lw 0 0 lw lw 0
       0 0 lw lw 0 0 lw lw
       0 0 0 0 -ll -ll -ll -ll
       1 1 1 1 1 1 1 1];

    F=[1 2 3 4
       5 6 7 8
       1 4 8 5
       2 3 7 6
       1 2 6 5 
       3 4 8 7];
end

%criar componente C3 


