%% MAIN START HEADER
global Blues Yellows Balls Rules RP
mainHeader();
if (RP.Pause) %�����.
    return;
end
MAP(); %��������� �����.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONTRIL BLOCK

%% ����������
RP.Blue(10).rul=GOcircle(RP.Blue(10),RP.Ball.z,angV(-RP.Ball.z));


%%  TrackAvoidance (����������)
B=Balls(2:3);       %����
X=Yellows(4,2:4);   %�������� ����� (4�� ����� �����)
G=[0,0];            %������
ST=[-1500,1200];    %����� ��������
Opponent=Blues(Blues(:,1)>0,2:3);                 %��������� (��� �����)
Opponent2=[Yellows(Yellows(:,1)>0,2:3);Opponent]; %����������� (��� ������)
if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-300)||(abs(B(2))>PAR.MAP_Y/2-300)) %���� ���� �� � ������������� ����
    if (norm(ST-X(1:2))>300) %���� ���������� �� ����� �������� ������ 300
        [Left,Right]=TrackAvoidance(X(1:2),X(3),ST,angV(B-ST),12,Opponent,0,0); %������� ����������� � ���� � ST
    else
        %������������.
        Left=0;
        Right=0;
    end
    Kick=0;
else
    if (norm(B-X(1:2))<700 && isSectorClear(X(1:2),B,angV(G-B),Opponent,100)) %���� �� ������ � ���� � ������ ��� ������ ��������
        [Left,Right,Kick]=GOSlide(X(1:2),X(3),B,angV(G-B));       %����� �� ����
    else
        Kick=0;
        [Left,Right]=TrackAvoidance(X(1:2),X(3),B,angV(G-B),2,Opponent);  %������� ����������� � ���� � B
    end
end
[Left,Right]=ReactAvoidance(Left,Right,X(1:2),X(3),Opponent2); %���������� ����� ����������� (�� ��������� � �����).
RP.Yellow(4).rul=Crul(Left,Right,Kick,0,0);
%Rule(4,Left,Right,-Kick,0,0); %���������� �� 4��� ������.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MAIN END
zMain_End = mainEnd();