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

%% CONTRIL BLOCK
RP.Yellow(1).rul=GoToPoint(RP.Yellow(1),[500,0]);

temp=RP.Yellow(1).rul;
RP.Yellow(1).rul=ReactAvoidance(RP.Yellow(1),[Blues,Yellows]);
MAP_addtext(max(RP.Yellow(1).rul.left,RP.Yellow(1).rul.right),'max=%f');
MAP_addtext(RP.Yellow(1).rul.left-temp.left,'| %4.0f %4.0f');
MAP_addtext(RP.Yellow(1).rul.right-temp.right,'| %4.0f %4.0f');

plot(PAR.RobotSize*sin(-pi:0.1:pi),PAR.RobotSize*cos(-pi:0.1:pi));
plot((PAR.RobotSize+150)*sin(-pi:0.1:pi),(PAR.RobotSize+150)*cos(-pi:0.1:pi));
plot((PAR.RobotSize+450)*sin(-pi:0.1:pi),(PAR.RobotSize+450)*cos(-pi:0.1:pi));

%RP.Blue(2).Nrul=1;
%G=Blues(10,2:3);
%RP.Blue(2).rul=GoToPoint(RP.Blue(2),[-1000,500]);
%RP.Blue(2).rul=SCRIPT_Atack(RP.Blue(2),RP.Ball,G,[-1000,0],[Blues;Yellows]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN END
%Rules
zMain_End = mainEnd();