%[Left,Right] = ReactAvoidance(Left,Right,X,Xang,Opponent)
%rul = ReactAvoidance(rul,X,Xang,Opponent)
% Реактивное обхождение препятствий
% Только для V>=0
function [Left,Right] = ReactAvoidance(Left,Right,X,Xang,Opponent)
%% Локальные параметры
global PAR;
Robotsize=PAR.RobotSize;
len0=150;
len1=300;
%% Полиморфизм
rul=[];
agent=[];
if (nargin==2)
    agent=Left;
    Opponent=Right;
    rul=agent.rul;
    X=agent.z;
    Xang=agent.ang;
    Left=rul.left;
    Right=rul.right;
end
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
if size(Opponent,2)==4
    Opponent=Opponent(Opponent(:,1)>0,2:3);
end    
%% Pars
Ubreal=(Right-Left)/200;
Vreal=(Right+Left)/200;
length=len0+Vreal*len1;
if (Vreal<0)
    [Right,Left] = ReactAvoidance(-Right,-Left,X,Xang+pi,Opponent);    
    Right=-Right; Left=-Left; 
    if ~isempty(rul)  
        rul=Crul(Left,Right,rul.kick,0,0);
        Left=rul;
        Right=[];
    end
    return;
end
%% Alg 
% Поиск направления с свободным сектором.
Cang=Ubreal*pi;
dang=0;

[~,cor]=isSectorClear(X,X+length*[cos(Xang),sin(Xang)],Opponent);
re=isSectorClear(X,X+length*[cos(Xang+Cang),sin(Xang+Cang)],Opponent);

while (abs(dang)<pi && re==0)
    dang=-sign(dang)*(abs(dang)+pi/180) + pi/360*(dang==0);
    re=isSectorClear(X,X+length*[cos(Xang+Cang+dang),sin(Xang+Cang+dang)],Opponent);    
end
% dang=0;
% [re,cor]=isSectorClear(X,X+length*[cos(Xang),sin(Xang)],Opponent,Xang,RobotsizeX2,0);
% 
% while (abs(dang)<pi && re==0)
%     if (abs(Ubreal)<=0.1)
%         dang=-sign(dang)*(abs(dang)+pi/180) + pi/360*(dang==0);
%     else
%         dang=dang+azi(sign(Ubreal)*pi/360);        
%     end
%     re=isSectorClear(X,X+length*[cos(Xang+dang),sin(Xang+dang)],Opponent,Xang+dang,RobotsizeX2,0);    
% end

%Vreal=Vreal+max(0,abs(Ubreal)-0.8);

Ub=azi(Cang+dang)/pi;
Vneed=1-abs(Ub);
if ~isempty(cor)
    Vneed=min(Vneed,(norm(cor-X)-Robotsize-len0)/(Robotsize+len0));
end
V=min(Vneed,Vreal);
%% Переход к колесам
%fprintf('REACT AVOIDANCE cor=%d Vneed=%d V=%d\n',cor,Vneed,V)
Left=100*(V-Ub);
Right=100*(V+Ub);
%% Debug
%fprintf('ReacAvoidance: Vreal=%4.2f,Ubreal=%4.2f,V=%4.2f,Ub=%4.2f\n',Vreal,Ubreal,Vneed,Ub);
%if ~isempty(cor)
%fprintf(' %4.2f\n',norm(cor-X))
%end
%% graph
% global map_test_react;
% if (get(0,'CurrentFigure')==100)
% if isempty(map_test_react) || ~ishandle(map_test_react)
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

