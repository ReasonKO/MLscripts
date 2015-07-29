%% MAIN START HEADER
global Blues Yellows Balls Rules RP PAR Modul
mainHeader();
MAP(); %Отрисовка карты.
if (RP.Pause) %Выход.
    return;
end
zMain_End=RP.zMain_End;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PAR.HALF_FIELD=0;
PAR.MAP_X=4000;
PAR.MAP_Y=3000;
PAR.RobotSize=200;
PAR.KICK_DIST=150;
PAR.DELAY=0.15;
PAR.WhellR=5;

PAR.LGate.X=-2000;
PAR.RGate.X=2000;
%PAR.BorotArm=225;


%% CONTRIL BLOCK
%Diagnostics();

%Rule(3,50,-50,0,0);
%Diagnostics();
%RP.Yellow(12).rul=Crul(Rules(1,3),Rules(1,4),0,0,0);
%RP.Yellow(11).rul=GoToPoint(RP.Yellow(11),[-500,500]);

B=RP.Ball.z;
agent=RP.Yellow(12);
G=[-1000,000];
if (agent.I) && (RP.Ball.I)
    RP.Yellow(12).rul=GOcircle(agent,B,angV(G-B));
    RP.Yellow(12).rul=RegControl(RP.Yellow(12));
else
    if (agent.I)
        RP.Yellow(12).rul=GoToPoint(agent,G,[],[100,300]);
    else
        RP.Yellow(12).rul=Crul(0,0,0,1,0);
    end
end
RP.Yellow(12).Nrul=1;

% G=[2000,0];
% RP.Yellow(1).rul=SCRIPT_GoalKeeper(RP.Yellow(1),RP.Ball,-G);
% RP.Yellow(2).rul=SCRIPT_Atack(RP.Yellow(2),RP.Ball,G,[500,-500]);
% RP.Yellow(3).rul=SCRIPT_Atack(RP.Yellow(3),RP.Ball,G,[-500,-500]);
% 
% G=[-2000,0];
% RP.Blue(1).rul=SCRIPT_GoalKeeper(RP.Blue(1),RP.Ball,-G);
% RP.Blue(2).rul=SCRIPT_Atack(RP.Blue(2),RP.Ball,G,[500,500]);
% RP.Blue(3).rul=SCRIPT_Atack(RP.Blue(3),RP.Ball,G,[-500,500]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN END
%Rules
zMain_End = mainEnd();