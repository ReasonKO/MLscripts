clear all
close all
pcode main.m
clc
%% Global INI
global Rules;    Rules=zeros(12,7);
global Balls;    Balls=zeros(1,3);
global Blues;    Blues=zeros(12,4);
global Yellows;  Yellows=zeros(12,4);

global PAR;
PAR.MAP_X=6000;
PAR.MAP_Y=4000;
PAR.KICK_DIST=150;
PAR.ROBOT_SIZE_R=100;
%% Modul INI
global Modul;
Modul.Tend=1000; %����� ���������� �������������
Modul.dT=0.2;    %��� �������������
Modul.Delay=2;   %�������� ���������� � ����� �������������
Modul.l_wheel=100; %������ ������
Modul.T=0;         %����� ���������� ��������� 
Modul.N=0;         %����� ���� ���������  
Modul.viz=0;       %��������������� �� �������������� ��������?
Modul.MapError=0*[0,5,5,0.05]; %����������� �������� ���������

%��������� ��� ���������� ������ �������������
Modul.Save.Yellows=Yellows;
Modul.Save.Blues=Blues;
Modul.Save.Balls=Balls;
Modul.YellowsKick=zeros(size(Yellows,1),2);
Modul.BluesKick=zeros(size(Blues,1),2);

Modul.Ball.Ang=0;      
Modul.Ball.V=0;
for i=1:Modul.Delay;
    Modul.Rules_Delay{i}=Rules;
end
%==========================================================================
%% INI ��������� �������
Balls(:)=[1,1900,00];
%Yellows(1,:)=[1,400,-200,pi/4];
%Yellows(2,:)=[1,-500,600,-pi/2];
%Yellows(3,:)=[1,000,800,pi];
%Blues(1,:)=[1,100,150,pi];
%Blues(2,:)=[1,-300,300,pi/4];
%Blues(3,:)=[1,-500,300,pi/4];

%Blues(10,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
Blues(10,:)=[1,500,-1000,-pi];
Blues(9,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
%Yellows(10,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
Yellows(4,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];

%for i=1:0
%    Yellows(i,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
%    Blues(i,:)7=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
%end

Blues
Yellows

%for i=1:12
%    Yellows(i,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
%end
%==========================================================================
%% ����
while(Modul.T+Modul.dT<=Modul.Tend )    
    %pause(0.1)
    Rules=zeros(12,7);
    Modul.N=Modul.N+1;
    Modul.T=Modul.T+Modul.dT;    
    %% �������� �����������
    if norm(Modul.MapError)>0
        Modul.Save.Yellows=Yellows;
        Modul.Save.Blues=Blues;
        Modul.Save.Balls=Balls;    
        Yellows=Modul.Save.Yellows+randn(size(Yellows)).*repmat(Modul.MapError,size(Yellows(:,1)));
        Blues=Modul.Save.Blues+randn(size(Blues)).*repmat(Modul.MapError,size(Blues(:,1)));
        Balls=Modul.Save.Balls+randn(size(Balls)).*Modul.MapError(1:3);
    end
    %% MAIN ---------------------------------------------------------------
    main1
    %main   %�������� ������, ����������� ��������
    %======================================================================
    %% �������� �����������
    if norm(Modul.MapError)>0
        Yellows=Modul.Save.Yellows;
        Blues=Modul.Save.Blues;
        Balls=Modul.Save.Balls;    
    end
    %% ������������� �����
    if (Modul.N==1)  
        MAP_INI        
    end
    %% ��������
    Rules_Delay_S=Rules;
    if (Modul.Delay>0)
        Rules=Modul.Rules_Delay{1};
        for i=1:Modul.Delay-1
            Modul.Rules_Delay{i}=Modul.Rules_Delay{i+1};        
        end
        Modul.Rules_Delay{Modul.Delay}=Rules_Delay_S;
    end    
    %% �������� ���������� ������
    % ������: MOD_NGO(9,3,'Y'); (��� ���������� Rule � ����� RP)
    % 9 - ����� ����� ������, 3 - ����� ���������� ������, Y - �� �����. 
    MOD_Agents();
%     MOD_NGO(3,4,'Y');
%     MOD_NGO(10,2,'B',1,-pi/2);
%    SAVE_rip();
%--------------------------------------------
    kick=Rules(1,5)||Rules(2,5)||Rules(3,5);
    if (kick~=0)
        %Tend=T%+5*dT;
    end
%% --------MOD_BALL-----------    
    MOD_Ball    
%%---------DOP------------------------------------------------------------- 
%     if (abs(Blues(7,4)-pi/2)<0.01)        
%         Blues(7,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
%     end
%     if (abs(Blues(8,4)+pi/2)<0.01)        
%         Blues(8,:)=[1,(rand(1,3)-0.5).*[PAR.MAP_Y,PAR.MAP_Y,2*pi]];
%     end
end
%SAVE_map;
%SAVE_load();