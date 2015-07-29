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
%agent=RP.Yellow(12);
%oagent=extrap(agent,0);
%Blues(12,2:3)=oagent.z;
%Blues(12,4)=oagent.ang;
% global TEST2
% if isempty(TEST2)
%     TEST2.D0=norm(Yellows(12,2:3));
%     TEST2.OLD=Yellows(12,2:3);
%     TEST2.V=0;
%     TEST2.FV=TEST2.V;
%     TEST2.VR=0;
%     TEST2.YS=0;
%     TEST2.T=RP.T;
%     figure(333);
%     clf
%     TEST2.H2=plot(0,0);
%     hold on
%     TEST2.H3=plot(0,0,'R','LineWidth',2);
%     TEST2.H4=plot(0,0,'G','LineWidth',1);
%     TEST2.H5=plot(0,0,'Y','LineWidth',2);
% else
%     TEST2.VR=[TEST2.VR;RP.Yellow(12).v];
%     TEST2.V=[TEST2.V;norm(Yellows(12,2:3)-TEST2.OLD)/RP.dT];
%     TEST2.FV=[TEST2.FV;(TEST2.V(end)+TEST2.FV(max(1,end))+2*TEST2.FV(max(1,end-1)))/4];
%     TEST2.YS=[TEST2.YS;RP.YellowsSpeed(12)];
%     TEST2.OLD=Yellows(12,2:3);
%     TEST2.D0=[TEST2.D0;norm(Yellows(12,2:3))];
%     TEST2.T=[TEST2.T;RP.T];
%     set(TEST2.H2,'xdata',TEST2.T,'ydata',min(TEST2.V,1000));
%     set(TEST2.H3,'xdata',TEST2.T,'ydata',abs(TEST2.VR));
%     set(TEST2.H4,'xdata',TEST2.T,'ydata',min(1000,TEST2.FV));
%     set(TEST2.H5,'xdata',TEST2.T,'ydata',abs(TEST2.YS));
% end
% oBall=extrap(RP.Ball,100);
% Yellows(12,2:3)=oBall.z;
% Yellows(12,4)=oBall.ang-pi;
% Yellows(12,1)=1;


%  global TEST
% if RP.Ball.I
% if isempty(TEST)
%     TEST.Ballz=RP.Ball.z;
%     TEST.Ballv=RP.Ball.v;
%     TEST.BallFV=RP.Ball.v;
%     TEST.Ballu=RP.Yellow(6).u;
%     TEST.Balla=0;    
%     TEST.T=RP.T;
%     figure(554);
%     clf
%     subplot(2,1,1);
%     TEST.h1=plot(TEST.T,TEST.Ballv);
%     hold on
%     TEST.h3=plot(TEST.T,TEST.Ballv,'r','lineWidth',2);
%     subplot(2,1,2);
%     TEST.h2=plot(TEST.T,TEST.Balla);
% else
%     TEST.T=[TEST.T;RP.T];
%     TEST.BallFV=[TEST.BallFV;(TEST.BallFV(max(1,end-1))+2*TEST.BallFV(max(1,end-2))+RP.Ball.v)/4];
%     TEST.Ballz=[TEST.Ballz;RP.Ball.z];
%     TEST.Ballv=[TEST.Ballv;RP.Ball.v];
%     TEST.Balla=[TEST.Balla,(TEST.Ballv(end-1)-TEST.Ballv(end))/RP.dT];        
%     TEST.Ballu=[TEST.Ballu,RP.Yellow(6).u];
%     
%     set(TEST.h1,'xdata',TEST.T','ydata',TEST.Ballv);
%     set(TEST.h2,'xdata',TEST.T,'ydata',TEST.Balla);    
%     set(TEST.h3,'xdata',TEST.T,'ydata',TEST.BallFV);    
% end
% end

%Rule(3,50,-50,0,0);
%Diagnostics();
%RP.Yellow(12).rul=Crul(Rules(1,3),Rules(1,4),0,0,0);
%RP.Yellow(11).rul=GoToPoint(RP.Yellow(11),[-500,500]);

%temp=RP.Yellow(1).rul;
%RP.Yellow(1).rul=ReactAvoidance(RP.Yellow(1),[Blues;Yellows]);
%MAP_addtext('123');

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