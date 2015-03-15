%[Left,Right,Kick]=GoalKeeper(X,Xang,B,G)
%rul=GoalKeeper(Agent,B,G)
%Функция движения воротаря в точке X с углом Xang
%B - положение мяча. G - положение центра ворот.
%Алгоритм
%А1)Приехать в ворота.
%А2)Встать на заданную точку в воротах для отражения мяча. 
%А3)Выбить пойманый мяч.
%---v0.7--- 
function [Left,Right,Kick]=GoalKeeper(X,Xang,B,G)
if (isstruct(X))
    Struct_Input=true;
    Agent=X;
    X=Agent.z;
    G=B;
    B=Xang;
    Xang=Agent.ang;
else
    Struct_Input=false;
end
if (isstruct(B))
    Ball=B;
    B=stuctB.z;
else
    Ball=NaN;
end
%Cx=G(1)%-400*sign(G(1));
%пиналка на левой стороне!!!
%% Параметры
lgate=500; %Ширина ворот.
DefDist=300; %Глубина ворот.
XaccelL=150;
YaccelL=50;
%% Определение точки защиты С
%B(2)/3000*lgate
%---Биссектриса---
C=G;
C(2)=C(2)-lgate+2*lgate*norm(G-[0,lgate]-B,2)/( norm(G-[0,lgate]-B,2)+norm(G+[0,lgate]-B,2) );
%---Не помню что---
%C=[G(1),-((1-abs(B(1)-G(1))/PAR.MAP_X))^3*B(2)];

%Направление движения мяча
if ~isnan(Ball)
    BallSpeed=200;
    BallSpeedmin=50;
    B_C=[NaN,NaN];
    if (Ball.v>BallSpeedmin && (abs(azi(angV(G-B)-Ball.ang))<pi/2))
        B_C(1)=C(1);
        B_C(2)=B(2)+sin(RP.Ball.ang)*(G(1)-B(1))/cos(RP.Ball.ang);
        C(2)=(B_C(2)-C(2))*min(1,(RP.Ball.v-BallSpeedmin)/BallSpeed)+C(2);
    end
end
%Выход за края ворот
if abs(C(2)-G(2))>lgate
    C(2)=G(2)+sign(C(2)-G(2))*lgate;
end
%% А1) Движение к воротам
% Методом скользящей траектории.

Cang=angV(C-X);
if (abs(azi(Cang-Xang))<=abs(azi(Cang-Xang+pi)))
    RT=1; %Движение прямо
else
    RT=-1;%Движение назад
end    
%% Параметры
%w-угол доворота до желаемого направления движения
if (abs(C(1)-X(1))>100 || abs(C(2)-X(2))>50)
    Ub=azi(Cang-Xang+pi*(RT==-1))/pi; 
else
    Cang=-sign(G(1))*pi/2; %Установка желаемого направления становления
    Ub=azi(Cang-Xang)/pi;
end

if (abs(G(1)-X(1))>DefDist && abs(azi(Cang-Xang))/pi>0.5)
    Ub=azi(Cang-Xang)/pi;   
end

V_=max( (abs(C(2)-X(2))-50)/YaccelL , (abs(C(1)-X(1))-50)/XaccelL );%Плавное замедление
V_=max(0,min(1,V_));
V=V_*RT*(1-abs(Ub));


%global PAR
%if (norm(B-X)<300 && abs(azi(angV(B-X)-Xang-sign(G(1))*pi/2))<pi/4)
%    Kick=1
%end
Kick=0;
MOD=0; %1
if (norm(B-X)<200)
    Ub=min(-0.9,max(0.9,2*azi(angV(B-X)-Xang-MOD*pi/2)/pi));       
    V=0.1;
    if abs(azi(angV(B-X)-Xang-MOD*pi/2))<pi/4
       Kick=1;
    end
end

%% RE
Left =100*(V-Ub);
Right=100*(V+Ub);
if (Struct_Input)
    rul=Crul(Left,Right,Kick,0,0);
    Left=rul;
    Right=NaN;
    Kick=NaN;
end
%% Визуализация
% global viz_gk_C viz_gk_C2;
% if (1)  
%     if (get(0,'CurrentFigure')==100)
%         if (isempty(viz_gk_C))
%             plot([G(1),G(1)],[-lgate,lgate],'B');
%             plot([C(1)-DefDist,C(1)-DefDist],[-lgate,lgate],'R');
%             plot([C(1)+DefDist,C(1)+DefDist],[-lgate,lgate],'R');
%             viz_gk_C2=plot(B_C(1),B_C(2),'Bo');
%             viz_gk_C=plot([B(1),C(1)],[B(2),C(2)],'R-');
%         else
%             set(viz_gk_C2,'xdata',B_C(1),'ydata',B_C(2)); 
%             set(viz_gk_C,'xdata',[B(1),C(1)],'ydata',[B(2),C(2)]); 
%         end
%     end
% end
end