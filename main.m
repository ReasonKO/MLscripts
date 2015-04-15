global GH
if isempty(GH)
    GH=[];
end
h=tic();
%% MAIN START HEADER
global Blues Yellows Balls Rules RP
mainHeader();
if (RP.Pause) %�����.
    return;
end
zMain_End=RP.zMain_End;
MAP(); %��������� �����.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONTRIL BLOCK

%% ����������
G=[-3100,0];            %������
RP.Yellow(4).rul=GoToPoint(RP.Yellow(4),[500;560],0.1,100);
%% ����������
% if (RP.Blue(4).I>0 && RP.Ball.I>0)
%     G=[-3000,0];            %������    
%     RP.Blue(4).rul=GOcircle(RP.Blue(4),RP.Ball,angV(G-RP.Ball.z));
%     RP.Blue(4).rul.kick=-RP.Blue(4).rul.kick;
% end
%% ��������.
if (RP.Yellow(1).I>0 && RP.Ball.I>0)
    G=[-2800,0]; %������� �����
    RP.Yellow(1).KickAng=-pi/2;    
    RP.Yellow(1).rul=GoalKeeper(RP.Yellow(1),RP.Ball,G);
    RP.Yellow(1).rul.kick=-RP.Yellow(1).rul.kick;
end
% %% ��������.
% if (RP.Blue(1).I>0 && RP.Ball.I>0)
%     G=[2800,0]; %������� �����
%     RP.Blue(1).rul=GoalKeeper(RP.Blue(1),RP.Ball.z,G);
%     RP.Blue(1).KickAng=-pi/2;    
%     RP.Blue(1).rul.kick=-RP.Blue(1).rul.kick;    
% end
%%  TrackAvoidance (����������)
B=Balls(2:3); 
agent=RP.Yellow(6);
G=[00,00];            %������
ST=[-1000,-1000];    %����� ��������
Opponent=Blues(Blues(:,1)>0,2:3);                 %��������� (��� �����)
Opponent2=[Yellows(Yellows(:,1)>0,2:3);Opponent]; %����������� (��� ������)
if (agent.I>0)
    if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-300)||(abs(B(2))>PAR.MAP_Y/2-300)) %���� ���� �� � ������������� ����
        rul=TrackAvoidance(agent,[],ST,angV(B-ST),13,Opponent,0,0); %������� ����������� � ���� � ST        
    else
        if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Opponent,angV(G-B),100)) %���� �� ������ � ���� � ������ ��� ������ ��������
            rul=GOcircle(agent,B,angV(G-B));
        else
            rul=TrackAvoidance(agent,[],B,angV(G-B),3,Opponent);  %������� ����������� � ���� � B
        end
    end
    rul=ReactAvoidance(rul,agent,Opponent2); %���������� ����� ����������� (�� ��������� � �����).    
else
    rul=Crul(0,0,0,0,0);
end
RP.Yellow(6).rul=rul;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN END
zMain_End = mainEnd();
GH(size(GH,1)+1,1)=toc(h);