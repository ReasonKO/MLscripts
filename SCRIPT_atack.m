%�������� ������� 
function SCRIPT_atack(N,X,B,G,ST,Opponent,Opponent2)
global Balls;
global PAR;
if  ((Balls(1)==0)||(abs(B(1))>PAR.MAP_X/2-300)||(abs(B(2))>PAR.MAP_Y/2-300)) %���� ���� �� � ������������� ����
    if (norm(ST-X(1:2))>300) %���� ���������� �� ����� �������� ������ 300
        [Left,Right]=TrackAvoidance(X(1:2),X(3),ST,angV(B-ST),12,Opponent,0,0); %������� ����������� � ���� � ST
    else
        Left=0; Right=0;        %������������.
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

Rule(N,Left,Right,-Kick,0,0); 
end