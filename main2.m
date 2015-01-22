%return;
tic();
global zMain_End
if (zMain_End==false)
    warning('<RP>: main if FAILD!')
end
zMain_End=false;
%% Data
%от SSL
global Balls;
global Blues;
global Yellows;
%для BT
global Rules;
if isempty(Rules)
    Rules=zeros(4,7);
end
%% SYS %%
global PAR;
if isempty(PAR)
    PAR.MAP_X=8000; %6
    PAR.MAP_Y=6000; %4
    PAR.KICK_DIST=120;
end
if ~isfield(PAR,'LGate')
    PAR.LGate.X=-PAR.MAP_X/2;
    PAR.LGate.Y=0;    
    PAR.LGate.ang=0;    
    PAR.LGate.width=1000;
end
if ~isfield(PAR,'RGate')
    PAR.RGate.X=PAR.MAP_X/2;
    PAR.RGate.Y=0;
    PAR.RGate.ang=-pi;    
    PAR.RGate.width=1000;
end
if ~isfield(PAR,'RobotSize')
    PAR.RobotSize=100;
end
if ~isfield(PAR,'RobotArm')
    PAR.RobotArm=100;
end
%% RP
global RP;
global Modul;
RP.PAR=PAR;
% RP.T
if isfield(RP,'T')
    if isempty(Modul)
        RP.dT=toc(RP.T_timerVal);
    else
        RP.dT=Modul.dT;
    end
    RP.T_timerVal=tic();
    RP.T=RP.T+RP.dT;
else
    RP.dT=0;
    RP.T_timerVal=tic();
    RP.T=0;
end
% RP.YellowsSpeed
if isfield(RP,'Yellows')    
    RP.YellowsSpeed=sqrt((Yellows(:,2)-RP.Yellows(:,2)).^2+(Yellows(:,3)-RP.Yellows(:,3)).^2)/RP.dT;
else
    RP.YellowsSpeed=zeros(size(Yellows,1),1);
end
RP.YellowsSpeed
% RP.BluesSpeed
if isfield(RP,'Blues')    
    RP.BluesSpeed=sqrt((Blues(:,2)-RP.Blues(:,2)).^2+(Blues(:,3)-RP.Blues(:,3)).^2)/RP.dT;
else
    RP.BluesSpeed=zeros(size(Blues,1),1);
end
% RP.BallsSpeed
if isfield(RP,'Balls')    
    RP.BallsSpeed=sqrt((Balls(:,2)-RP.Balls(:,2)).^2+(Balls(:,3)-RP.Balls(:,3)).^2)/RP.dT;
else
    RP.BallsSpeed=zeros(size(Balls,1),1);
end
% RP - Save
RP.Blues=Blues;
RP.Yellows=Yellows;
RP.Balls=Balls;
RP.Rules=Rules;
% RP.Pause
if ~isfield(RP,'Pause')    
    RP.Pause=0;
end
if (RP.Pause)
    return;
end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%-------------------------ОПИСАНИЕ РОБОТОВ--------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Очень простой нападающий. 
% B=[Balls(1,2),Balls(1,3)]; 
% X=Yellows(11,2:4);
% [Left,Right,Kick]=GoSlide(X(1:2),X(3),B,pi/6);
% Rule(5,Left,Right,Kick,0,0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Простой нападающий
% B=Balls(2:3);
% X=Yellows(10,2:4); %Входящий робот
% G=[-2000,2000]; %Ворота
% ST=[-1500,-1500]; %Точка ожидания
% if  ((Balls(1)==0)||(abs(B(1))>2800)||(abs(B(2))>2700)||((B(2))>000))
%     [Left,Right]=GoToPoint(X(1:2),X(3),ST,pi/2-pi/2*sign(B(1)));
%    Kick=0;
% else 
%     %[Left,Right,Kick]=GOcircle6(X(1:2),X(3),B,angV(G-B));
%     [Left,Right,Kick]=GOSlide(X(1:2),X(3),B,angV(G-B));
%     %[Left,Right,Kick]=GOeiler(X(1:2),X(3),B,angV(G-B));%angV(G-B));
% end
% Rule(2,Left,Right,-Kick,0,0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TrackAvoidance (Нападающий) упращённый вариант
% B=[Balls(1,2),Balls(1,3)]; 
% X=Blues(3,2:4);
% Opponent=Yellows(Yellows(:,1)>0,2:3);
% Opponent2=[Blues(Blues(:,1)>0,2:3);Opponent];
% G=[-3500,0];%[-PAR.MAP_X/2,0000]; %Ворота
% if (norm(B-X(1:2))<700 && isSectorClear(X(1:2),B,angV(G-B),Opponent,100))
%     [Left,Right,Kick]=GOSlide(X(1:2),X(3),B,angV(G-B));       
% else
%     Kick=0;
%     [Left,Right]=TrackAvoidance(X(1:2),X(3),B,angV(G-B),2,Opponent);
% end
% if ~isSectorClear(X(1:2),X(1:2)+300*[cos(X(3)),sin(X(3))],Opponent2);
%     V=(Left+Right)/2;
%     Left=Left-V;
%     Right=Right-V;
% end
% Rule(6,Left,Right,Kick,0,0);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TrackAvoidance (Нападающий)
B=Balls(2:3);       %цель
X=Yellows(4,2:4);   %Входящий робот (4ый среди жёлтых)
G=[0,0];            %Ворота
ST=[-1500,1200];    %Точка ожидания
Opponent=Blues(Blues(:,1)>0,2:3);                 %Соперники (все синии)
Opponent2=[Yellows(Yellows(:,1)>0,2:3);Opponent]; %Препятствия (все роботы)
N=4;                %Отправляем на Nого робота

SCRIPT_atack(N,X,B,G,ST,Opponent,Opponent2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Голкипер.
if (Balls(1)==0)
    Left=0;Right=0;Kick=0;
else
    B=[Balls(1,2),Balls(1,3)]; 
    X=Yellows(10,2:4);
    G=[-2800,0]; %Уровень ворот
    [Left,Right,Kick]=GoalKeeper(X(1:2),X(3),B,G);
end
Rule(1,Left,Right,-Kick,0,0);
%% Голкипер.
if (Balls(1)==0)
    Left=0;Right=0;Kick=0;
else
    B=[Balls(1,2),Balls(1,3)]; 
    X=Blues(10,2:4);
    G=[2800,-00]; %Уровень ворот
    [Left,Right,Kick]=GoalKeeper(X(1:2),X(3),B,G);
end
Rule(2,Left,Right,-Kick,0,0);
%% MAP
MAP
%iso_MAP
%RP_map
%%
zMain_End=true;
%fprintf('End of MAIN\n');