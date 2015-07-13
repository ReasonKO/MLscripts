%% MAIN START HEADER
global Blues Yellows Balls Rules RP PAR
mainHeader();
MAP(); %Отрисовка карты.
if (RP.Pause) %Выход.
    return;
end
zMain_End=RP.zMain_End;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONTRIL BLOCK
% -----------------PAR----------------
PAR.MAP_Y=3000;
PAR.MAP_X=6000;
PAR.KICK_DIST=150;
PAR.HALF_FIELD=0;
PAR.RobotSize=200;
%% -----------------------------------
%RP.Yellow(6).rul=Crul(50,50,0,0,0);
%RP.Yellow(6).rul=GoToPoint(RP.Yellow(6),[100,-100]);
%RP.Yellow(6).rul=RegControl(RP.Yellow(6));
CollisionControl();

RP.Yellow(1).rul=SCRIPT_GoalKeeper(RP.Yellow(1),RP.Ball,[2800,0]);
RP.Yellow(2).rul=SCRIPT_Atack(RP.Yellow(2),RP.Ball,[-3000,0],[500,-500]);
RP.Yellow(3).rul=SCRIPT_Atack(RP.Yellow(3),RP.Ball,[-3000,0],[-500,500]);
%RP.Yellow(4).rul=SCRIPT_Atack(RP.Yellow(4),RP.Ball,[-3000,0],[500,-500]);
%RP.Yellow(5).rul=SCRIPT_Atack(RP.Yellow(5),RP.Ball,[-3000,0],[500,-500]);

RP.Blue(1).rul=SCRIPT_GoalKeeper(RP.Blue(1),RP.Ball,[-2800,0]);
RP.Blue(2).rul=SCRIPT_Atack(RP.Blue(2),RP.Ball,[3000,0],[-500,-500]);
RP.Blue(3).rul=SCRIPT_Atack(RP.Blue(3),RP.Ball,[3000,0],[500,500]);
%RP.Blue(4).rul=SCRIPT_Atack(RP.Blue(4),RP.Ball,[3000,0],[500,-500]);
%RP.Blue(5).rul=SCRIPT_Atack(RP.Blue(5),RP.Ball,[3000,0],[500,-500]);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN END
%Rules
zMain_End = mainEnd();