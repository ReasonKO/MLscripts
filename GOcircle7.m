%[Left,Right,Kick]=GOcircle6(X,Xang,B,Cang)
%Классический алгоритм забивания мяча в ворота 
function [Left,Right,Kick]=GOcircle7(X,Xang,B,Cang)
Bang=Cang;
A=X;
Aang=Xang;

global Yellows;
global Blues;
drr=300;
KICK_DIST=350;
l=170;%70 -125
%R=l+100;
R=l+100;
R2=l+100;

KSpeed=1;
K=1;
Kick=0;


C=B-drr*[cos(Cang),sin(Cang)];

%% AL 1 Невязка окружности.
ACang=angV(C-A);
ABang=angV(B-A);

DB=azi(ABang-Bang);
DBA=azi(ABang-Xang);

DC=azi(ACang-Cang);
DCA=azi(ACang-Xang);

if (sin(DC)==0)
    SecC=norm(X-C);
    rC=inf;
else
    rC=(norm(X-C)/2)/abs(sin(DC));
    SecC=abs(DC)*2*rC;
end


if (sin(DB)==0)
    SecB=norm(X-B);
    rB=inf;
else
    rB=(norm(X-B)/2)/abs(sin(DB));
    SecB=abs(DB)*2*rB;
end



%% AL 3 касательная
Cc=C-sign(DC)*[cos(Cang+pi/2),sin(Cang+pi/2)]*R;

if (norm(X-Cc)>=R) 
    DCc=azi(angV(Cc-X)-Xang+sign(DC)*asin(R/norm(X-Cc)));
else
    DCc=sign(DC)*asin(norm(X-Cc)/R)/2;
end

%% Выбор алгоритма
ALGORITM=0;
Pz=dot(C-B,X-B)/norm(C-B);
Pzt=sqrt(norm(X-B)^2-(Pz)^2);
l_k=l/4;

if (Pzt<l)&&(Pz>0)&&(Pz<drr+R)&&((abs(Cang-Xang)<pi/8)||(Pz<drr))%)||(Pzt<l_k))%(((SecB<drr+200)&&(abs(DB)<pi/4)))%(abs(Cang-Xang)<pi/8)||
    ALGORITM=4;    

    Ub=azi(Cang-Xang)/pi;
    KSpeed=((Pz+100)/(drr+R+100));
    
    if ((abs(azi(Cang-Xang)))<10*pi/180)&&(Pz<KICK_DIST)
        ALGORITM=5;   
        KSpeed=1;
        Kick=1;     
    end
else
eee=(l/(rC+l))*pi*(1-abs(2*azi(DCA+DC)/pi))-sign(DC)*KwA3*azi(DCA+DC);
    if ((norm(X-Cc)<R2)&&(eee>0))||(norm(X-Cc)<R)
        w=azi(DCA+DC);
        w=w-l*sign(DC);

        ALGORITM=3;  
    else  
        ALGORITM=1;
        w=DCc;
    end
end



%% ПРОПОРЦИАНАЛЬНЫЙ РЕГУЛЯТОР


V=1*KSpeed;
Left=100*(V-Ub);
Right=100*(V+Ub);
[V,Ub]
%% SAVE
global MODUL_ON;
if size(MODUL_ON)~=[0,0]         
    plot(C(1),C(2),'Y.');
             
    plot(Cc(1),Cc(2),'Y.');
end    
%     
% if (SAVE_it())
%     global S_t;
%     global S_ALGORITM;
%     global S_Dang;
%     global S_w;
%     global S_REALw;
%     global S_SR;
%     global S_SL;
%     global S_Cc;
%     global S_R;
%     global S_R2;
%     S_Cc{S_t}=Cc;
%     S_R{S_t}=R;
%     S_R2{S_t}=R2;
%     S_ALGORITM{S_t}=ALGORITM;
%     S_Dang{S_t}=azi(Cang-Xang);
%     S_w{S_t}=wP;
%     S_REALw{S_t}=((Right-Left)/2)/RS;
%     S_SR{S_t}=Right;
%     S_SL{S_t}=Left;
%     global S_X; S_X{S_t}=X;
% end
%% end
[Left,Right,Kick,0];
%% MOD_KICK
global MOD_Kick;
if ((Kick==1) && (~isempty(MOD_Kick)))
    MOD_Kick=[Xang,200]
end
end