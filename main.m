%% MAIN START HEADER
global Blues Yellows Balls Rules RP PAR
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
PAR.MAP_Y=4000;
PAR.MAP_X=6000;

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN END
zMain_End = mainEnd();