%% MAIN START HEADER
global Blues Yellows Balls Rules RP
mainHeader();
if (RP.Pause) %Выход.
    return;
end
MAP(); %Отрисовка карты.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONTRIL BLOCK

%% Нападающий
G=[-3100,0];            %Ворота
RP.Blue(10).rul=GOcircle(RP.Blue(10),RP.Ball.z,angV(G-RP.Ball.z));
%% Голкипер.
G=[-2800,0]; %Уровень ворот
RP.Yellow(5).rul=GoalKeeper(RP.Yellow(5),RP.Ball.z,G);
RP.Yellow(5).KickAng=-pi/2;    
%%  TrackAvoidance (Нападающий)
B=Balls(2:3);       %цель
X=Yellows(4,2:4);   %Входящий робот (4ый среди жёлтых)
G=[-3000,0];            %Ворота
ST=[-1500,1200];    %Точка ожидания
Opponent=Blues(Blues(:,1)>0,2:3);                 %Соперники (все синии)
Opponent2=[Yellows(Yellows(:,1)>0,2:3);Opponent]; %Препятствия (все роботы)
if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-300)||(abs(B(2))>PAR.MAP_Y/2-300)) %Если мячь не в играбетельной зоне
    if (norm(ST-X(1:2))>300) %Если расстояния до точки ожидания больше 300
        [Left,Right]=TrackAvoidance(X(1:2),X(3),ST,angV(B-ST),12,Opponent,0,0); %Обходим препятствия и едем к ST
    else
        %Остановились.
        Left=0;
        Right=0;
    end
    Kick=0;
else
    if (norm(B-X(1:2))<700 && isSectorClear(X(1:2),B,angV(G-B),Opponent,100)) %Если мы близки к мячу и сектор для захода свободен
        [Left,Right,Kick]=GOSlide(X(1:2),X(3),B,angV(G-B));       %Заход на мячь
    else
        Kick=0;
        [Left,Right]=TrackAvoidance(X(1:2),X(3),B,angV(G-B),2,Opponent);  %Обходим препятствия и едем к B
    end
end
[Left,Right]=ReactAvoidance(Left,Right,X(1:2),X(3),Opponent2); %Реактивные обход препятствий (не врезаться в своих).
%RP.Yellow(4).rul=Crul(Left,Right,Kick,0,0);
%Rule(4,Left,Right,-Kick,0,0); %Отправляем на 4ого робота.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN END
zMain_End = mainEnd();