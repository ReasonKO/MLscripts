%%Vmax~=700 ���~=30
%%Umax~=7 ���~=0.3
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
if (RP.Pause) %�����.
    return;
end
zMain_End=RP.zMain_End;
MAP(); %��������� �����.
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
%% ����������
%G=[-3100,0];            %������
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

%% ����������
% if (RP.Blue(4).I>0 && RP.Ball.I>0)
%     G=[-3000,0];            %������    
%     RP.Blue(4).rul=GOcircle(RP.Blue(4),RP.Ball,angV(G-RP.Ball.z));
%     RP.Blue(4).rul.kick=-RP.Blue(4).rul.kick;
% end
%%                      %%������� �����
%% ��������.
if (RP.Blue(1).I>0 && RP.Ball.I>0)
    G=[2800,0]; %������� �����
    RP.Blue(1).rul=GoalKeeper(RP.Blue(1),RP.Ball.z,G);
    RP.Blue(1).KickAng=-pi/2;    
    RP.Blue(1).rul.kick=-RP.Blue(1).rul.kick;        
    RP.Blue(1).rul=RegControl(RP.Blue(1));
end
%%  TrackAvoidance (����������)
B=Balls(2:3); 
agent=RP.Blue(9);  %����������� �����
G=[-3000,00];            %������
ST=[1000,-1000];    %����� ��������
if (agent.I>0)
    if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-100)||(abs(B(2))>PAR.MAP_Y/2-100)) %���� ���� �� � ������������� ����
        rul=TrackAvoidance(agent,[],ST,angV(B-ST),[],Yellows,0,0); %������� ����������� � ���� � ST        
    else
        if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Yellows,angV(G-B),100)) %���� �� ������ � ���� � ������ ��� ������ ��������
            rul=GOcircle(agent,B,angV(G-B));
        else
            rul=TrackAvoidance(agent,[],B,angV(G-B),[],Yellows);  %������� ����������� � ���� � B
        end
    end
    rul=RegControl(agent,rul); %������������� ����������  
else
    rul=Crul(0,0,0,0,0);
end
RP.Blue(9).rul=rul;%���������� ����������
%%  TrackAvoidance (����������)
B=Balls(2:3); 
agent=RP.Blue(4);  %����������� �����
G=[-3000,00];            %������
ST=[1000,1000];    %����� ��������
if (agent.I>0)
    if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-100)||(abs(B(2))>PAR.MAP_Y/2-100)) %���� ���� �� � ������������� ����
        rul=TrackAvoidance(agent,[],ST,angV(B-ST),[],Yellows,0,0); %������� ����������� � ���� � ST        
    else
        if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Yellows,angV(G-B),100)) %���� �� ������ � ���� � ������ ��� ������ ��������
            rul=GOcircle(agent,B,angV(G-B));
        else
            rul=TrackAvoidance(agent,[],B,angV(G-B),[],Yellows);  %������� ����������� � ���� � B
        end
    end
    rul=RegControl(agent,rul); %������������� ����������  
else
    rul=Crul(0,0,0,0,0);
end
RP.Blue(4).rul=rul;%���������� ����������
%%                      %%������� ƨ����
%% ��������.
if (RP.Yellow(1).I>0 && RP.Ball.I>0)
    G=[-2800,0]; %������� �����
    RP.Yellow(1).KickAng=-pi/2;    
    RP.Yellow(1).rul=GoalKeeper(RP.Yellow(1),RP.Ball,G);
    RP.Yellow(1).rul.kick=-RP.Yellow(1).rul.kick;
    RP.Yellow(1).rul=RegControl(RP.Yellow(1));
end
%%  TrackAvoidance (����������)
B=Balls(2:3); 
agent=RP.Yellow(6);  %����������� �����
G=[3000,00];            %������
ST=[-1000,-1000];    %����� ��������
if (agent.I>0)
    if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-100)||(abs(B(2))>PAR.MAP_Y/2-100)) %���� ���� �� � ������������� ����
        rul=TrackAvoidance(agent,[],ST,angV(B-ST),[],Blues,0,0); %������� ����������� � ���� � ST        
    else
        if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Blues,angV(G-B),100)) %���� �� ������ � ���� � ������ ��� ������ ��������
            rul=GOcircle(agent,B,angV(G-B));
        else
            rul=TrackAvoidance(agent,[],B,angV(G-B),[],Blues);  %������� ����������� � ���� � B
        end
    end
    rul=RegControl(agent,rul); %������������� ����������  
else
    rul=Crul(0,0,0,0,0);
end
RP.Yellow(6).rul=rul;%���������� ����������
%%  TrackAvoidance (����������)
B=Balls(2:3); 
agent=RP.Yellow(4);  %����������� �����
G=[3000,00];            %������
ST=[-1000,1000];    %����� ��������
if (agent.I>0)
    if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-100)||(abs(B(2))>PAR.MAP_Y/2-100)) %���� ���� �� � ������������� ����
        rul=TrackAvoidance(agent,[],ST,angV(B-ST),[],Blues,0,0); %������� ����������� � ���� � ST        
    else
        if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Blues,angV(G-B),100)) %���� �� ������ � ���� � ������ ��� ������ ��������
            rul=GOcircle(agent,B,angV(G-B));
        else
            rul=TrackAvoidance(agent,[],B,angV(G-B),[],Blues);  %������� ����������� � ���� � B
        end
    end
    rul=RegControl(agent,rul); %������������� ����������  
else
    rul=Crul(0,0,0,0,0);
end
RP.Yellow(4).rul=rul;%���������� ����������
%%  TrackAvoidance (����������)
% ident=1;
% B=Balls(2:3); 
% agent=RP.Blue(9);
% G=[3000,00];            %������
% ST=[1000,0000];    %����� ��������
% OpponentB=Blues(Blues(:,1)>0,2:3);                 %��������� (��� �����)
% OpponentY=Yellows(Yellows(:,1)>0,2:3);            %����������� (��� ������)
% Opponent=OpponentY;
% Opponent2=[OpponentY;OpponentB];
% if (agent.I>0)
%     if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-300)||(abs(B(2))>PAR.MAP_Y/2-300)) %���� ���� �� � ������������� ����
%         rul=TrackAvoidance(agent,[],ST,angV(B-ST),ident,Opponent,0,0); %������� ����������� � ���� � ST        
%     else
%         if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Opponent,angV(G-B),100)) %���� �� ������ � ���� � ������ ��� ������ ��������
%             rul=GOcircle(agent,B,angV(G-B));
%         else
%             rul=TrackAvoidance(agent,[],B,angV(G-B),ident+100,Opponent);  %������� ����������� � ���� � B
%         end
%     end
%     rul=ReactAvoidance(rul,agent,Opponent2); %���������� ����� ����������� (�� ��������� � �����).    
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