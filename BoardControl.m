function rul = BoardControl(agent,rul)
if (nargin<2)
    rul=agent.rul;
end
savedist=300;
V=(rul.left+rul.right)/200;
Ub=(rul.right-rul.left)/200;

cdist=sign(V)*savedist;
c=agent.z+cdist*[cos(agent.ang),sin(agent.ang)];
global PAR
dist=min(PAR.MAP_X/2-abs(agent.z(1)),PAR.MAP_Y/2-abs(agent.z(2)));
cc=min(1,max(0,dist/savedist));
newV=V*cc;

    newUb=azi(angV(-agent.z)-agent.ang)/pi;
    newUb=Ub*cc+(1-cc)*newUb;

if (abs(c(1))>PAR.MAP_X/2 || abs(c(2))>PAR.MAP_Y/2)
    %goAway=(abs(c(2))>PAR.MAP_Y/2);    
    %if newUb>0
    %    newUb=max(newUb,Ub);
    %else
    %    newUb=min(newUb,Ub);
    %end
    rul=Crul(100*(newV-newUb),100*(newV+newUb),0,0,0);
else
    rul=Crul(100*(V-newUb),100*(V+newUb),0,0,0);
end
end

