%Функция начинающая основную "main" функцию.
%Обязательная для функционирования структуры RP .
function RPre=mainHeader()
%% RP
global RP;
if isempty(RP)
    fprintf('<RP>: ---RP initial---\n');
end
if isfield(RP,'zMain_End') && (RP.zMain_End==false)
    warning('<RP>: main if FAIL!');
end
RP.zMain_End=false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Data %%
emptyrul=struct();
emptyrul.left=0;
emptyrul.right=0;
emptyrul.kick=0;
emptyrul.sound=0;
emptyrul.sensor=0;
%от SSL
% --- Balls ----
global Balls;
if isempty(Balls)   
    Balls=zeros(1,3);  
end
% --- Blues ----
global Blues;
if isempty(Blues)
    Blues=zeros(12,4);
end
% --- Blues ----
global Yellows;
if isempty(Yellows)
   Yellows=zeros(12,4);
end
% --- Rules для BT ---
global Rules;
if isempty(Rules)
    Rules=zeros(4,7);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Разбор входящих данных %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--- time ---
global Modul;
if isempty(Modul)
    RP.OnModul=false;
else
    RP.OnModul=true;
end
RP.PAR=PAR;
% RP.T
if isfield(RP,'T')
    if isempty(Modul)
        RP.dT=toc(RP.T_timerH);
    else
        RP.dT=Modul.dT;
    end
    RP.T_timerH=tic();
    RP.T=RP.T+RP.dT;
else
    RP.dT=0;
    RP.T_timerH=tic();
    RP.T=0;
end
%--- speed ---
% RP.YellowsSpeed
if isfield(RP,'Yellows') && norm(size(Yellows)-size(RP.Yellows))    
    RP.YellowsSpeed=sqrt((Yellows(:,2)-RP.Yellows(:,2)).^2+(Yellows(:,3)-RP.Yellows(:,3)).^2)/RP.dT;
else
    RP.YellowsSpeed=zeros(size(Yellows,1),1);
end
% RP.BluesSpeed
if isfield(RP,'Blues') && norm(size(Blues)-size(RP.Blues))    
    RP.BluesSpeed=sqrt((Blues(:,2)-RP.Blues(:,2)).^2+(Blues(:,3)-RP.Blues(:,3)).^2)/RP.dT;
else
    RP.BluesSpeed=zeros(size(Blues,1),1);
end
% RP.BallsSpeed
if isfield(RP,'Balls') && norm(size(Balls)-size(RP.Balls))
    RP.BallsSpeed=sqrt((Balls(2)-RP.Balls(2)).^2+(Balls(3)-RP.Balls(3)).^2)/RP.dT;
    RP.Ballsang=angV(RP.Balls(2:3)-Balls(2:3));
else
    RP.BallsSpeed=zeros(size(Balls,1),1);
    RP.Ballsang=0;
end
%--- Save ---
RP.Blues=Blues;
RP.Yellows=Yellows;
RP.Balls=Balls;
RP.Rules=Rules;
%--- RP interface ---
RP.Ball.I=Balls(1);
RP.Ball.x=Balls(2);
RP.Ball.y=Balls(3);
RP.Ball.z=Balls(2:3);
RP.Ball.ang=RP.Ballsang;
RP.Ball.v=RP.BallsSpeed;


for i=1:size(Blues,1)
    if ((Blues(i,1)==1) || (i==size(Blues,1)))
        RP.Blue(i).I=Blues(i,1);
        RP.Blue(i).x=Blues(i,2);
        RP.Blue(i).y=Blues(i,3);
        RP.Blue(i).z=Blues(i,2:3);
        RP.Blue(i).ang=Blues(i,4);
        RP.Blue(i).v=RP.BluesSpeed(i);
        RP.Blue(i).Nrul=0;
        RP.Blue(i).rul=emptyrul;
        RP.Blue(i).KickAng=0;
    end
end
for i=1:size(Yellows,1)
    if ((Yellows(i,1)==1) || (i==size(Yellows,1)))
        RP.Yellow(i).I=Yellows(i,1);
        RP.Yellow(i).x=Yellows(i,2);
        RP.Yellow(i).y=Yellows(i,3);
        RP.Yellow(i).z=Yellows(i,2:3);
        RP.Yellow(i).ang=0;
        RP.Yellow(i).v=RP.YellowsSpeed(i);
        RP.Yellow(i).Nrul=0;
        RP.Yellow(i).rul=emptyrul;
        RP.Yellow(i).KickAng=0;
    end
end
% --- RP.Pause ---
if ~isfield(RP,'Pause')    
    RP.Pause=0;
end
if (RP.Pause)
    return;
end
%% re
RPre=RP;
end