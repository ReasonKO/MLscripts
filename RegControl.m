function rul = RegControl(agent,rul)
if (nargin<2)
    rul=agent.rul;
end
rul.left(abs(rul.left)>100)=sign(rul.left)*100;
rul.right(abs(rul.right)>100)=sign(rul.right)*100;
global Yellows Blues
rul=ReactAvoidance(rul,agent,[Yellows;Blues]);
rul=BoardControl(agent,rul);
rul=MoveControl(agent,rul);
end

