%%Vmax~=700 шум~=30
%%Umax~=7 шум~=0.3
global GH
if isempty(GH)
    GH=[];
end
h=tic();
%% MAIN START HEADER
global Blues Yellows Balls Rules RP PAR
mainHeader();
% global GG
% if isempty(GG)
%     GG=RP.Yellow(9).u;
% else
%     GG(size(GG,1)+1,1)=RP.Yellow(9).u;
% end
if (RP.Pause) %Выход.
    return;
end
zMain_End=RP.zMain_End;
MAP(); %Отрисовка карты.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONTRIL BLOCK
PAR.MAP_Y=4000;
PAR.MAP_X=6000;
% RP.Blue(10).rul=Crul(100,100,0,0,0);
% RP.Blue(10).rul=RegControl(RP.Blue(10));
% RP.Blue(1).rul=GoToPoint(RP.Blue(1),[-5500;560],0.1,100);
% RP.Blue(1).rul=BoardControl(RP.Blue(1));
%% Нападающий
%G=[-3100,0];            %Ворота
%RP.Yellow(4).rul=GoToPoint(RP.Yellow(4),[500;560],0.1,100);
%RP.Yellow(9).rul=GoToPoint(RP.Yellow(9),[-500;-560],0.1,100);
%RP.Yellow(9).rul=BoardControl(RP.Yellow(9));

%RP.Yellow(10).rul=GoToPoint(RP.Yellow(10),[-1500;-560],0.1,100);
%RP.Yellow(10).rul=BoardControl(RP.Yellow(10));
%     RP.Blue(4).rul=GOcircle(RP.Blue(4),RP.Ball,angV(G-RP.Ball.z));
%     RP.Blue(4).rul.kick=-RP.Blue(4).rul.kick;

% G=[-1206,-1155];
% RP.Yellow(10).rul=GOcircle(RP.Yellow(10),RP.Ball,angV(G-RP.Ball.z));
% RP.Yellow(10).rul=MoveControl(RP.Yellow(10));
% RP.Yellow(10).rul=ReactAvoidance(RP.Yellow(10),[Yellows;Blues]);
% RP.Yellow(10).rul=BoardControl(RP.Yellow(10));
% 
% RP.Yellow(10).rul.kick=-RP.Yellow(10).rul.kick;

%% Нападающий
% if (RP.Blue(4).I>0 && RP.Ball.I>0)
%     G=[-3000,0];            %Ворота    
%     RP.Blue(4).rul=GOcircle(RP.Blue(4),RP.Ball,angV(G-RP.Ball.z));
%     RP.Blue(4).rul.kick=-RP.Blue(4).rul.kick;
% end
%%                      %%КОМАНДА Синих
%% Голкипер.
if (RP.Blue(1).I>0 && RP.Ball.I>0)
    G=[2800,0]; %Уровень ворот
    RP.Blue(1).rul=GoalKeeper(RP.Blue(1),RP.Ball.z,G);
    RP.Blue(1).KickAng=-pi/2;    
    RP.Blue(1).rul.kick=-RP.Blue(1).rul.kick;        
    RP.Blue(1).rul=RegControl(RP.Blue(1));
end
%%  TrackAvoidance (Нападающий)
B=Balls(2:3); 
agent=RP.Blue(9);  %Управляемый робот
G=[-3000,00];            %Ворота
ST=[1000,-1000];    %Точка ожидания
if (agent.I>0)
    if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-100)||(abs(B(2))>PAR.MAP_Y/2-100)) %Если мячь не в играбетельной зоне
        rul=TrackAvoidance(agent,[],ST,angV(B-ST),[],Yellows,0,0); %Обходим препятствия и едем к ST        
    else
        if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Yellows,angV(G-B),100)) %Если мы близки к мячу и сектор для захода свободен
            rul=GOcircle(agent,B,angV(G-B));
        else
            rul=TrackAvoidance(agent,[],B,angV(G-B),[],Yellows);  %Обходим препятствия и едем к B
        end
    end
    rul=RegControl(agent,rul); %Регуляризация управления  
else
    rul=Crul(0,0,0,0,0);
end
RP.Blue(9).rul=rul;%Возвращяем управление
%%  TrackAvoidance (Нападающий)
B=Balls(2:3); 
agent=RP.Blue(4);  %Управляемый робот
G=[-3000,00];            %Ворота
ST=[1000,1000];    %Точка ожидания
if (agent.I>0)
    if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-100)||(abs(B(2))>PAR.MAP_Y/2-100)) %Если мячь не в играбетельной зоне
        rul=TrackAvoidance(agent,[],ST,angV(B-ST),[],Yellows,0,0); %Обходим препятствия и едем к ST        
    else
        if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Yellows,angV(G-B),100)) %Если мы близки к мячу и сектор для захода свободен
            rul=GOcircle(agent,B,angV(G-B));
        else
            rul=TrackAvoidance(agent,[],B,angV(G-B),[],Yellows);  %Обходим препятствия и едем к B
        end
    end
    rul=RegControl(agent,rul); %Регуляризация управления  
else
    rul=Crul(0,0,0,0,0);
end
RP.Blue(4).rul=rul;%Возвращяем управление
%%                      %%КОМАНДА ЖЁЛТЫХ
%% Голкипер.
if (RP.Yellow(1).I>0 && RP.Ball.I>0)
    G=[-2800,0]; %Уровень ворот
    RP.Yellow(1).KickAng=-pi/2;    
    RP.Yellow(1).rul=GoalKeeper(RP.Yellow(1),RP.Ball,G);
    RP.Yellow(1).rul.kick=-RP.Yellow(1).rul.kick;
    RP.Yellow(1).rul=RegControl(RP.Yellow(1));
end
%%  TrackAvoidance (Нападающий)
B=Balls(2:3); 
agent=RP.Yellow(6);  %Управляемый робот
G=[3000,00];            %Ворота
ST=[-1000,-1000];    %Точка ожидания
if (agent.I>0)
    if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-100)||(abs(B(2))>PAR.MAP_Y/2-100)) %Если мячь не в играбетельной зоне
        rul=TrackAvoidance(agent,[],ST,angV(B-ST),[],Blues,0,0); %Обходим препятствия и едем к ST        
    else
        if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Blues,angV(G-B),100)) %Если мы близки к мячу и сектор для захода свободен
            rul=GOcircle(agent,B,angV(G-B));
        else
            rul=TrackAvoidance(agent,[],B,angV(G-B),[],Blues);  %Обходим препятствия и едем к B
        end
    end
    rul=RegControl(agent,rul); %Регуляризация управления  
else
    rul=Crul(0,0,0,0,0);
end
RP.Yellow(6).rul=rul;%Возвращяем управление
%%  TrackAvoidance (Нападающий)
B=Balls(2:3); 
agent=RP.Yellow(4);  %Управляемый робот
G=[3000,00];            %Ворота
ST=[-1000,1000];    %Точка ожидания
if (agent.I>0)
    if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-100)||(abs(B(2))>PAR.MAP_Y/2-100)) %Если мячь не в играбетельной зоне
        rul=TrackAvoidance(agent,[],ST,angV(B-ST),[],Blues,0,0); %Обходим препятствия и едем к ST        
    else
        if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Blues,angV(G-B),100)) %Если мы близки к мячу и сектор для захода свободен
            rul=GOcircle(agent,B,angV(G-B));
        else
            rul=TrackAvoidance(agent,[],B,angV(G-B),[],Blues);  %Обходим препятствия и едем к B
        end
    end
    rul=RegControl(agent,rul); %Регуляризация управления  
else
    rul=Crul(0,0,0,0,0);
end
RP.Yellow(4).rul=rul;%Возвращяем управление
%%  TrackAvoidance (Нападающий)
% ident=1;
% B=Balls(2:3); 
% agent=RP.Blue(9);
% G=[3000,00];            %Ворота
% ST=[1000,0000];    %Точка ожидания
% OpponentB=Blues(Blues(:,1)>0,2:3);                 %Соперники (все синии)
% OpponentY=Yellows(Yellows(:,1)>0,2:3);            %Препятствия (все роботы)
% Opponent=OpponentY;
% Opponent2=[OpponentY;OpponentB];
% if (agent.I>0)
%     if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-300)||(abs(B(2))>PAR.MAP_Y/2-300)) %Если мячь не в играбетельной зоне
%         rul=TrackAvoidance(agent,[],ST,angV(B-ST),ident,Opponent,0,0); %Обходим препятствия и едем к ST        
%     else
%         if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Opponent,angV(G-B),100)) %Если мы близки к мячу и сектор для захода свободен
%             rul=GOcircle(agent,B,angV(G-B));
%         else
%             rul=TrackAvoidance(agent,[],B,angV(G-B),ident+100,Opponent);  %Обходим препятствия и едем к B
%         end
%     end
%     rul=ReactAvoidance(rul,agent,Opponent2); %Реактивный обход препятствий (не врезаться в своих).    
% else
%     rul=Crul(0,0,0,0,0);
% end
% RP.Blue(9).rul=rul;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN END
zMain_End = mainEnd();
GH(size(GH,1)+1,1)=toc(h);