%�������� ������� 
function rul=SCRIPT_Atack(agent,B,G,ST,Opponent)
global RP Blues Yellows Balls PAR;
%% �����������
if isstruct(B)
    Ball=B;
    B=Ball.z;
end
if (nargin==4)
    if (agent.id>=RP.YELLOWIDMIN)
        %YellowTeam
        Opponent=Blues;
    else
        %BlueTeam
        Opponent=Yellows;    
    end
end
%%
if (agent.I>0)
    if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-100)||(abs(B(2))>PAR.MAP_Y/2-100)) %���� ���� �� � ������������� ����
        rul=TrackAvoidance(agent,[],ST,angV(B-ST),[],Opponent,0,0); %������� ����������� � ���� � ST        
    else
        if (norm(B-agent.z)<700 && isSectorClear(agent.z,B,Opponent,angV(G-B),PAR.RobotSize)) %���� �� ������ � ���� � ������ ��� ������ ��������
            rul=GOcircle(agent,B,angV(G-B));
        else
            rul=TrackAvoidance(agent,[],B,angV(G-B),[],Opponent);  %������� ����������� � ���� � B
        end
    end
    rul=RegControl(agent,rul); %������������� ����������  
else
    rul=RegControl(agent);
end
end