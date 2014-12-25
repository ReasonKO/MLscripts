%MAP_INI
%������������� ��������� MAP � �������� figure(100)
%��� ������� ���������������� ��������� ������.

global Blues
global Yellows
clear MAP_PAR; 
global MAP_PAR;
MAP_PAR.MAP_H=figure(100);
clf
hold on;grid on;

global PAR;
if (isempty(PAR))
    fprintf('PAR is not initialized/f');
    return;
end
axis equal
axis([-PAR.MAP_X/2-50,PAR.MAP_X/2+50,-PAR.MAP_Y/2-50,PAR.MAP_Y/2+50]);
%plot(C(1)+300*sin(0:0.1:2*pi),C(2)+300*cos(0:0.1:2*pi));
set(gca,'Color',[0.1 0.9 0.1]);

MAP_PAR.viz_Balls=[];

for i=1:size(Blues,1)
    MAP_PAR.viz_Blues{i}=[];
end
for i=1:size(Yellows,1)
    MAP_PAR.viz_Yellows{i}=[];
end