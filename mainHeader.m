%������� ���������� �������� "main" �������.
%������������ ��� ���������������� ��������� RP .
%
% �������� ��������� RP
%        zMain_End: true          %���� ���������� ���������� main
%          OnModul: 0             %������������� �������������
%              PAR: [1x1 struct]  %����� �������� ���������� ����
%               dT: 0.5           %��� �������������
%         T_timerH: 24084895062   %����� �������.
%                T: 12.5          %���� �� ������� �������
%     YellowsSpeed: [12x1 double] %�������� �����
%       BluesSpeed: [12x1 double] %�������� �����
%       BallsSpeed: 0             %�������� ����
%         Ballsang: 0             %���� ����������� ����
%            Blues: [12x4 double] %�������� ������ �����
%          Yellows: [12x4 double] %�������� ������ �����
%            Balls: [0 0 0]       %�������� ������ �����
%            Rules: [4x7 double]  %��������� ������ ����������
%             Ball: [1x1 struct]  %��������� ����
%             Blue: [1x12 struct] %��������� �����
%           Yellow: [1x12 struct] %��������� �����
%            Pause: 0             %�����
%
% �������� ��������� ������� RP.Blue(N) ��� RP.Yellow(N)
% ���� ����� �� ��� ������, �� ��� ���� empty
%           I: 1                  %������ ������, ������� ����� ������
%           x: 1.0360e+03         %X ���������� ������
%           y: -905.6405          %Y ���������� ������ 
%           z: [1.0360e+03 -905.6405]           %[X,Y] ����������
%         ang: 0.1835             %���� ����������� ������ 
%           v: 97.3253            %�������� �������� ������
%        Nrul: 0                  %����� ���������� ����������
%         rul: [1x1 struct]       %��������� ����������
%     KickAng: 0                  %����������� ����� ������
%
% �������� ���������� RP.Blue(10).rul
%      sound: 0                   %������ ���� [0..1]
%     sensor: 0                   %������������� ������ [0..4]
%       left: 100                 %��������� ������ ������ [-100..100]
%      right: 99.2465             %��������� ������� ������ [-100..100]
%       kick: -1                  %���� �������� [-1,0,1]

function RPre=mainHeader()
%% RP
global RP;
if isempty(RP)
    fprintf('<RP>: ---RP initial---\n');
    RP.inpair=false;    
end
if isfield(RP,'zMain_End') && (RP.zMain_End==false)
    warning('<RP>: main if FAIL!');
end
RP.zMain_End=false;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Data %%
emptyrul=Crul(0,0,0,0,0);
%�� SSL
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
% --- Rules ��� BT ---
global Rules;
if isempty(Rules)
    Rules=zeros(4,7);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ������ �������� ������ %%
if ~isfield(RP,'pair')
    RP.pair=struct();
    if ~isfield(RP.pair,'Yellows')
        RP.pair.Yellows=-ones(size(Yellows,1),1);
    end
    if ~isfield(RP.pair,'Blues')
        RP.pair.Blues=-ones(size(Blues,1),1);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SYS %%
global PAR;
if isempty(PAR)
    PAR=struct();
end
if ~isfield(PAR,'MAP_X')
    PAR.MAP_X=6000; %6
end
if ~isfield(PAR,'MAP_Y')
    PAR.MAP_Y=4000; %4
end
if ~isfield(PAR,'KICK_DIST')
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
if isfield(RP,'Yellows') && norm(size(Yellows)-size(RP.Yellows))==0    
    RP.YellowsSpeed=sqrt((Yellows(:,2)-RP.Yellows(:,2)).^2+(Yellows(:,3)-RP.Yellows(:,3)).^2)/RP.dT;
    RP.YellowsAngSpeed=(Yellows(:,4)-RP.Yellows(:,4))/RP.dT;
else
    RP.YellowsAngSpeed=zeros(size(Yellows,1),1);
    RP.YellowsSpeed=zeros(size(Yellows,1),1);
end
% RP.BluesSpeed
if isfield(RP,'Blues') && norm(size(Blues)-size(RP.Blues))==0
    RP.BluesSpeed=sqrt((Blues(:,2)-RP.Blues(:,2)).^2+(Blues(:,3)-RP.Blues(:,3)).^2)/RP.dT;
    RP.BluesAngSpeed=(Blues(:,4)-RP.Blues(:,4))/RP.dT;
else
    RP.BluesAngSpeed=zeros(size(Blues,1),1);
    RP.BluesSpeed=zeros(size(Blues,1),1);
end
% RP.BallsSpeed
if isfield(RP,'Balls') && norm(size(Balls)-size(RP.Balls))==0
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
        RP.Blue(i).I=Blues(i,1);
        RP.Blue(i).x=Blues(i,2);
        RP.Blue(i).y=Blues(i,3);
        RP.Blue(i).z=Blues(i,2:3);
        RP.Blue(i).ang=Blues(i,4);
        RP.Blue(i).v=RP.BluesSpeed(i);
        RP.Blue(i).u=RP.BluesAngSpeed(i);
        RP.Blue(i).Nrul=RP.pair.Yellows(i);
        RP.Blue(i).rul=emptyrul;
        RP.Blue(i).KickAng=0;
end
for i=1:size(Yellows,1)
        RP.Yellow(i).I=Yellows(i,1);
        RP.Yellow(i).x=Yellows(i,2);
        RP.Yellow(i).y=Yellows(i,3);
        RP.Yellow(i).z=Yellows(i,2:3);
        RP.Yellow(i).ang=Yellows(i,4);
        RP.Yellow(i).v=RP.YellowsSpeed(i);
        RP.Yellow(i).u=RP.YellowsAngSpeed(i);
        RP.Yellow(i).Nrul=RP.pair.Yellows(i);
        RP.Yellow(i).rul=emptyrul;
        RP.Yellow(i).KickAng=0;
end
% --- RP.Pause ---
if ~isfield(RP,'Pause')    
    RP.Pause=0;
end
pair();
%if (RP.Pause)
%    return;
%end
%% re
RPre=RP;
end