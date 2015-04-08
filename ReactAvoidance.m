%[Left,Right] = ReactAvoidance(Left,Right,X,Xang,Opponent)
%rul = ReactAvoidance(rul,X,Xang,Opponent)
% Реактивное обхождение препятствий
function [Left,Right] = ReactAvoidance(Left,Right,X,Xang,Opponent)
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

    if ~isSectorClear(X,X+300*[cos(Xang),sin(Xang)],angV(300*[cos(Xang),sin(Xang)]),Opponent,100);
        V=0*(Left+Right)/2;
        Left=V+50*((Left>Right)-0.5);
        Right=V-50*((Left>Right)-0.5);
    end    
if ~isempty(rul)  
    rul.Left=Left;
    rul.Right=Right;
    Left=rul;
    Right=[];
end
end

