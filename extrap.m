%agent=extrap(agent,T)
%��������������� ������� ���� ��� ������ agent ����� ����� T
function agent=extrap(agent,T)
A=-250; %A=-4/0.03; %100..300 %���������(������) ����

%ID ����
if (agent.id==100) 
    %���������� ���������� �����.
    L=integral(@(t)max(0,agent.v+A*t),0,T);
else
    %���������� ���������� ������� (����� ����� ���������� ��������).
    if (agent.u==0)
        L=T*agent.v;
    else
        L=sqrt(2)*agent.v/abs(agent.u)*sqrt(1-cos(agent.u*T));
    end
end
%���������, ��������, ���������.
if isfield(agent,'u')
    agent.ang=agent.ang+agent.u*T/2;
end
agent.z=agent.z+L*[cos(agent.ang),sin(agent.ang)];
if isfield(agent,'u')
    agent.ang=azi(agent.ang+agent.u*T/2);
end
end