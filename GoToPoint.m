%[Left,Right]=GoToPoint(X,Xang,C,Cang,StopDistance);
%[Left,Right]=GoToPoint(X,Xang,C,Cang), StopDistance=200;
%[Left,Right]=GoToPoint(X,Xang,C), �ang=Xang, StopDistance=0;
%�������� ������ � � ����� Xang � ����� �.
%��������� � ����������� StopDistance � �������� �� ���� �ang. 
function [Left,Right]=GoToPoint(X,Xang,C,Cang,StopDistance)
%% ��������� �� ���������
if (nargin==4)
    StopDistance=200;
end    
if (nargin==3)   
    StopDistance=000;
    Cang=Xang;
end
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
end