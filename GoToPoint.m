%[Left,Right]=GoToPoint(X,Xang,C,Cang,StopDistance);
%[Left,Right]=GoToPoint(X,Xang,C,Cang), StopDistance=200;
%[Left,Right]=GoToPoint(X,Xang,C), Сang=Xang, StopDistance=0;
%[rul]=GoToPoint(Agent,C,Cang,StopDistance);
%[rul]=GoToPoint(Agent,C,Cang), StopDistance=200;
%[rul]=GoToPoint(Agent,C), Сang=agent.ang, StopDistance=0;
%
%Движение робота Agent(или координатой X и углом Xang)  к точке С.
%Остановка в окрестности StopDistance и разворот на угол Сang. 
function [Left,Right]=GoToPoint(X,Xang,C,Cang,StopDistance)
%% Параметры по умолчанию
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
%% верификация данных
X=reshape(X,1,2);
C=reshape(C,1,2);
%% Вычисление скоростей
%Ub - угловая скорость.
%V - линейная скорость.
if (norm(C-X)>StopDistance)
    Ub=azi(angV(C-X)-Xang)/pi; 
    V=1-abs(Ub);
else
    Ub=azi(Cang-Xang)/pi;
    V=0;
end
%% Переход к колесам
Left=100*(V-Ub);
Right=100*(V+Ub);
%% re
if (Struct_Input)
    Left=Crul(Left,Right,0,0,0);
    Right=NaN;
end
end