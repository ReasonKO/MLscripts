%PAUSE
%������ � �������� ����� 
%�� ����� ����� Rule �� ������� ������
global RP;
global Rules;

%% ���������� ������������ ������
pcode main.m;
Rules=zeros(size(Rules));
if (size(Pause)==[0,0])
    Pause=0;
end
%����� �����.
RP.Pause=1-RP.Pause;
if (RP.Pause)
    fprintf('Pause = ON\n');
else
    fprintf('Pause = OFF\n');
end

%% ������� "����" �� ���� �������.
if (RP.Pause==1)
    Rules(1,:)=[2,1,0,0,0,0,0];
    Rules(2,:)=[1,0,0,0,0,0,0];
    Rules(3,:)=[1,0,0,0,0,0,0];
    Rules(4,:)=[1,0,0,0,0,0,0];
    pause(0.1);
    Rules(1,:)=[2,1,0,0,0,0,0];
    Rules(2,:)=[1,0,0,0,0,0,0];
    Rules(3,:)=[1,0,0,0,0,0,0];
    Rules(4,:)=[1,0,0,0,0,0,0];
else
    Rules(1,:)=[2,1,0,0,0,0,0];
end

%% 