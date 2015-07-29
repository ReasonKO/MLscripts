%re=MOD_GO(X,Xang,Rul)
%re=[X(1),X(2),Xang] 
%������������� �������� ������
function re=MOD_GO(X,Xang,Rul,dT)
global Modul;
if (nargin==3)    
    dT=Modul.dT;
end
%% ������������� ����������
l=Modul.l_wheel;
%% ������� � ���������
Left=Rul(1)*Modul.vSpeed;
Right=Rul(2)*Modul.vSpeed;
U=(Right-Left)/(2*l);
V=(Left+Right)/2;
%% ���������� ����� �����
if (U==0)
    L=dT*V;
else
    L=sqrt(2)*V/abs(U)*sqrt(1-cos(U*dT));
end
%% �������, ���.��������, �������.
Xang=Xang+U*dT/2;
X=X+L*[cos(Xang),sin(Xang)];
Xang=azi(Xang+U*dT/2);
%% �����
re=[X(1),X(2),Xang];
end

