%% Modul INI
clear all
close all
%pcode main.m
mainHeader();
global Modul Blues Yellows Balls Rules;
if isempty(Modul)    
    Modul.Tend=30000; %Время выполнения моделирования
    Modul.dT=0.3;    %Шаг дискретизации
    Modul.Delay=0.2;   %Задержка управления в шагах дискретизации
    Modul.l_wheel=100; %Размер робота
    Modul.T=0;         %Время выполнения программы 
    Modul.N=0;         %Номер шага программы  
    Modul.viz=0;       %Визуализировать ли дополнительную анимацию?
    Modul.MapError=[0,5,5,0.05]; %Погрешность передачи координат %0.08-0.11

    Modul.treckcolor=[0,1,0.4];
    %Структуры для корректной работы моделирования
    Modul.Save.Yellows=Yellows;
    Modul.Save.Blues=Blues;
    Modul.Save.Balls=Balls;
    Modul.YellowsKick=zeros(size(Yellows,1),2);
    Modul.BluesKick=zeros(size(Blues,1),2);

    Modul.Ball.Ang=0;      
    Modul.Ball.V=0;
end
global PAR
PAR.KICK_DIST=200;
INIPosition();
MAP_INI();