% rul = GOcircle(agent,C,Cang)
% ������� ������ �� ����.
% ����� �������� ��������� ���������� ��������� �������, ��������� �� ����.
% � �������� ��������� � ���������� ���������� ��������� �� RP
function rul = GOcircle(agent,C,Cang)
%% ��������� ��������� (�������� ���������)
Crad=300;
Cradmax=600;
%% ���������
global PAR;
KICK_DIST=PAR.KICK_DIST;
[x,y]=rotV(agent.x-C(1),agent.y-C(2),-Cang);
Aang=agent.ang-Cang;

%% �������� �����������
GCy=(x.^2+y.^2)./(2*y); %�������� �������������� ������������
angF=azi(angV(-x,GCy-y)-sign(GCy)*( pi/2 )); %����������� �����������
angC=azi(angV(-x-Crad,-y)); %����������� ���������� ����� �������
%angC2=azi(angV(-x,-y)); %����������� ���������� ����
N=sqrt(x.^2+y.^2); %����������
%% ������� �����
%�������� �����
ang=angF+azi((angC-angF)).*max( 0,min((N-Crad)/Cradmax,0.8));
%����� �� ������
ang2=ang;
ang2(x>0)=azi(ang(x>0))./(1-max(-0.5,min((N(x>0)-Crad)/Crad,0)));
ang2(x<=0)=azi(ang(x<=0)).*(1-max(-0.5,min((N(x<=0)-Crad)/Crad,0)));
%% Kick
if (x<0 && x>-KICK_DIST && abs(y)<100 && abs(azi(Aang))<pi/16)
    kick=1;
else
    kick=0;
end
%% �������� ����������
if (x<0 && abs(y)<100)
    V_=max(0.2,min(1,(-x-100)/300));
else
    V_=1;
end
%% ���������� ���������
%Ub - ������� ��������, V - �������� ��������.
Ub=azi(ang2-Aang)/pi; 
Ub=sign(Ub)*min(1,2*abs(Ub));
V=V_*(1-abs(Ub));
%% ������� � �������
rul=Crul(100*(V-Ub),100*(V+Ub),kick,0,0);
end