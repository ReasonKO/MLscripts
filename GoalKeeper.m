%[Left,Right,Kick]=GoalKeeper(X,Xang,B,G)
%������� �������� �������� � ����� X � ����� Xang
%B - ��������� ����. G - ��������� ������ �����.
%��������
%�1)�������� � ������.
%�2)������ �� �������� ����� � ������� ��� ��������� ����. 
%�3)������ �������� ���.
%---v0.7--- 
function [Left,Right,Kick]=GoalKeeper(X,Xang,B,G)
%Cx=G(1)%-400*sign(G(1));
%������� �� ����� �������!!!
%% ���������
lgate=500; %������ �����.
DefDist=300; %������� �����.
%%
Kick=0;
%% ����������� ����� ������ �
%B(2)/3000*lgate
%---�����������---
C=G;
C(2)=C(2)-lgate+2*lgate*norm(G-[0,lgate]-B,2)/( norm(G-[0,lgate]-B,2)+norm(G+[0,lgate]-B,2) );
%---�� ����� ���---
%C=[G(1),-((1-abs(B(1)-G(1))/PAR.MAP_X))^3*B(2)];
if abs(C(2))>lgate
    C(2)=sign(C(2))*lgate;
end

%% �1) �������� � �������
% ������� ���������� ����������.

Cang=angV(C-X);
if (abs(azi(Cang-Xang))<=abs(azi(Cang-Xang+pi)))
    RT=1; %�������� �����
else
    RT=-1;%�������� �����
end    
%% ���������
%w-���� �������� �� ��������� ����������� ��������
if (abs(C(1)-X(1))>100 || abs(C(2)-X(2))>50)
    Ub=azi(Cang-Xang+pi*(RT==-1))/pi; 
else
    Cang=-sign(G(1))*pi/2; %��������� ��������� ����������� �����������
    Ub=azi(Cang-Xang)/pi;
end

V_=max( (abs(C(2)-X(2))-50)/250 , (abs(C(1)-X(1))-50)/150 );%������� ����������
V_=max(0,min(1,V_));
V=V_*RT*(1-abs(Ub));

if (abs(G(1)-X(1))>DefDist && abs(azi(Cang-Xang))/pi>0.5)
    Ub=azi(Cang-Xang)/pi;   
end

%global PAR
%if (norm(B-X)<300 && abs(azi(angV(B-X)-Xang-sign(G(1))*pi/2))<pi/4)
%    Kick=1
%end
if (norm(B-X)<300 && abs(azi(angV(B-X)-Xang-pi/2))<pi/4)
    Kick=1;
end
%% RE
Left =100*(V-Ub);
Right=100*(V+Ub);
%% ������������
% global viz_gk_C;
% global MAP_H;
% if (1)  
%     H = get(0, 'CurrentFigure');
%     if ((~isempty(MAP_H)) && (~isempty(H)) && (H==MAP_H))
%         if (isempty(viz_gk_C))
%             plot([G(1),G(1)],[-lgate,lgate],'B');
%             plot([C(1)-DefDist,C(1)-DefDist],[-lgate,lgate],'R');
%             plot([C(1)+DefDist,C(1)+DefDist],[-lgate,lgate],'R');
%             viz_gk_C=plot([B(1),C(1)],[B(2),C(2)],'R-');
%         else
%             set(viz_gk_C,'xdata',[B(1),C(1)],'ydata',[B(2),C(2)]); 
%         end
%     end
% end
end