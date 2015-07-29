function agent=extrap(agent,T)
%”скорение(трение) м€ча
%A=-4/0.03; %100..300
A=-250;

if (agent.id==100) 
    L=integral(@(t)max(0,agent.v+A*t),0,T);
else
    if (agent.u==0)
        L=T*agent.v;
    else
        L=T*sqrt(2)*agent.v/abs(agent.u)*sqrt(1-cos(agent.u*T).^2);
    end
end
if isfield(agent,'u')
    agent.ang=agent.ang+agent.u*T/2;
end
agent.z=agent.z+L*[cos(agent.ang),sin(agent.ang)];

if isfield(agent,'u')
    agent.ang=agent.ang+agent.u*T/2;
end

end