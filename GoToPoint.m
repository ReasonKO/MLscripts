%[Left,Right]=GoToPoint(X,Xang,C,Cang,StopDistance);
%[Left,Right]=GoToPoint(X,Xang,C,Cang), StopDistance=200;
%[Left,Right]=GoToPoint(X,Xang,C), �ang=Xang, StopDistance=0;
%[rul]=GoToPoint(Agent,C,Cang,StopDistance);
%[rul]=GoToPoint(Agent,C,Cang), StopDistance=200;
%[rul]=GoToPoint(Agent,C), �ang=agent.ang, StopDistance=0;
%
%�������� ������ Agent(��� ����������� X � ����� Xang)  � ����� �.
%��������� � ����������� StopDistance � �������� �� ���� �ang. 
function [Left,Right]=GoToPoint(X,Xang,C,Cang,StopDistance)
%% ��������� �� ���������
if (isstruct(X))
    agent=X;
    Struct_Input=true;
    if (nargin==4)
        StopDistance=Cang;
        Cang=C;
        C=Xang;
        Xang=agent.ang;
        X=agent.z;
    end    
    if (nargin==3)
        StopDistance=200;
        Cang=C;
        C=Xang;
        Xang=agent.ang;
        X=agent.z;
    end
    if (nargin==2)
        StopDistance=0;
        Cang=agent.ang;
        C=Xang;
        Xang=agent.ang;
        X=agent.z;
    end
else
    Struct_Input=false;
    if (nargin==4)
        StopDistance=200;
    end    
    if (nargin==3)   
        StopDistance=0;
        Cang=Xang;
    end
end
%% ����������� ������
X=reshape(X,1,2);
C=reshape(C,1,2);
%% ���������� ���������
%Ub - ������� ��������.
%V - �������� ��������.
if (norm(C-X)>StopDistance)
    Ub=azi(angV(C-X)-Xang)/pi; 
    V=1-abs(Ub);
else
    Ub=azi(Cang-Xang)/pi;
    V=0;
end
%% ������� � �������
Left=100*(V-Ub);
Right=100*(V+Ub);
%% re
if (Struct_Input)
    Left=Crul(Left,Right,0,0,0);
    Right=NaN;
end
end