%% MAIN START HEADER
global Blues Yellows Balls Rules RP PAR Modul
if isempty(RP)
    addpath tools
    addpath RPtools
    addpath MODUL
end
%
mainHeader();
MAP(); %Îòðèñîâêà êàðòû.
if (RP.Pause) %Âûõîä.
    return;
end
zMain_End=RP.zMain_End;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PAR.HALF_FIELD=-1;
PAR.MAP_X=4000;
PAR.MAP_Y=3000;
PAR.RobotSize=200;
PAR.KICK_DIST=200;
PAR.DELAY=0.15;
PAR.WhellR=5;

PAR.LGate.X=-2000;
PAR.RGate.X=2000;
%PAR.BorotArm=225;

%% CONTRIL BLOCK
% global temp
% if ~isempty(Modul)
% if isempty(temp)
%     temp.h=plot(0,0);
% end
% if (mod(Modul.N,100)==1)
% if ishandle(temp.h)
%     delete(temp.h);
% end
% temp.left_=rand(1)*150-50;
% temp.right_=rand(1)*150-50;
% temp.h=plot(0,0,'-');
% end
% agent=extrapR(RP.Blue(1),0:0.1:10);
% setPlotData(temp.h,agent.x,agent.y);
% end
%Diagnostics();

%Rule(3,50,-50,0,0);
%Diagnostics();
%RP.Yellow(12).rul=Crul(Rules(1,3),Rules(1,4),0,0,0);
%RP.Yellow(11).rul=GoToPoint(RP.Yellow(11),[-500,500]);
G=[2000,0];
B=RP.Ball.z;
RP.Blue(1).rul=GOcircle(RP.Blue(1),B,angV(G-B));
%RP.Blue(1).rul=NewAlgRot(RP.Blue(1),B,0);
%RP.Blue(9).rul=SCRIPT_Atack(RP.Blue(9),B,G,[-1000,0],Yellows);
%RP.Blue(9).Nrul=1;
%if isnan(Blues(1,2))
%    error('');
%else
%    Blues
%end
% 
% B=RP.Ball.z;
% agent=RP.Yellow(12);
% G=[-1000,000];
% if (agent.I) && (RP.Ball.I)
%     RP.Yellow(12).rul=GOcircle(agent,B,angV(G-B));
%     RP.Yellow(12).rul=RegControl(RP.Yellow(12));
% else
%     if (agent.I)
%         RP.Yellow(12).rul=GoToPoint(agent,G,[],[100,300]);
%     else
%         RP.Yellow(12).rul=Crul(0,0,0,1,0);
%     end
% end
% RP.Yellow(12).Nrul=1;

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
Rules
zMain_End = mainEnd();
