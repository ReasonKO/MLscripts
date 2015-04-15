%[Left,Right] = ReactAvoidance(Left,Right,X,Xang,Opponent)
%rul = ReactAvoidance(rul,X,Xang,Opponent)
% Реактивное обхождение препятствий
function [Left,Right] = ReactAvoidance(Left,Right,X,Xang,Opponent)
RobotsizeX2=200;
length=400;
    rul=[];
    agent=[];
if (nargin==3)
    rul=Left;
    agent=Right;
    Opponent=X;
    X=agent.z;
    Xang=agent.ang;
    Left=rul.left;
    Right=rul.right;
end
if isstruct(Left)
    rul=Left;
        Opponent=Xang;
        Xang=X;
        X=Right;
    Left=rul.left;
    Right=rul.left;
end
if isstruct(X)
    agent=X;
    Opponent=Xang;
    Xang=agent.ang;
    X=agent.z;
end
%% Alg
dang=0;
re=isSectorClear(X,X+length*[cos(Xang),sin(Xang)],Opponent,Xang,RobotsizeX2,0);
cor=[];
while (dang<pi && re==0)
    if (dang==0)
        dang=pi/360;
    else
        dang=-dang-sign(dang)*(pi/180);
    end
    [re,cor]=isSectorClear(X,X+length*[cos(Xang+dang),sin(Xang+dang)],Opponent,Xang+dang,RobotsizeX2,0);    
end  
Ubreal=(Right-Left)/200;
Vreal=(Right+Left)/200;
if (dang~=0)
    Ubneed=(dang/pi);
    if (Ubneed>=0)
        Ub=max(Ubneed,Ubreal);
    else
        Ub=min(Ubneed,Ubreal);
    end
else
    Ub=Ubreal;
end
Vneed=1-abs(Ub);
if ~isempty(cor)
    Vneed=min(1-abs(Ub),norm(cor-X)/length);
end
V=min(Vneed,Vreal);
%% Переход к колесам
Left=100*(V-Ub);
Right=100*(V+Ub);
%% graph
% global map_test_react;
% if (get(0,'CurrentFigure')==100)
% if isempty(map_test_react)
%     map_test_react=plot(X(1)+length*[0,cos(Xang+dang)],X(2)+length*[0,sin(Xang+dang)],'R');
% else
%     set(map_test_react,'xdata',X(1)+length*[0,cos(Xang+dang)],'ydata',X(2)+length*[0,sin(Xang+dang)]);     
% end
% end
  
if ~isempty(rul)  
    rul=Crul(Left,Right,rul.kick,0,0);
    Left=rul;
    Right=[];
end
end

