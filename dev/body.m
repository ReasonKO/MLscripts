Xagent=[0,0];
Xang=0;
algN=1;
Ball=[000,000];
Opponent=[250,-400; 400,600; -700, -300; -450, 900];
Cang=pi/4;
BallDangArea=4;
C_dist=100;
C=Ball-C_dist*[cos(Cang),sin(Cang)];
MAX_WEIGHT=3000;
Stop_Range=300;
%% Полиморфизм
if (isstruct(Xagent))
    if ~isempty(Xang)
        warning('use Xang=[] if Xagent is struct');
    end
    agent=Xagent;
    Xagent=agent.z;
    Xang=agent.ang;
else
    agent=[];
end
if (nargin==6)
    BallDangArea=4;
    C_dist=100;
end
if (nargin==7)
    BallDangArea=0;
end  
if isempty(algN)
    if isempty(agent)
        error('algN & agent is empty');
    end
    algN=agent.id;
end
if size(Opponent,2)==4
    Opponent=Opponent(Opponent(:,1)>0,2:3);
end
Opponent=Opponent(or(Opponent(:,1)-Xagent(1)~=0,Opponent(:,2)-Xagent(2)~=0),:);
%% PAR TRACKAVOI PAR
global trackavoi PAR
if isempty(trackavoi) || ~isfield(trackavoi,'weight')
    %инициализация множества параметров.
    TrackAvoi_INI();
    trackavoi.weight=[];
    trackavoi.MAP=[];
end
dp=trackavoi.PAR.dp;
X=trackavoi.PAR.X;
Y=trackavoi.PAR.Y;
sdvigI1=trackavoi.PAR.sdvigI1;
sdvigI2=trackavoi.PAR.sdvigI2;
sdvigL=trackavoi.PAR.sdvigL;
sdvig=trackavoi.PAR.sdvig;
getIndex=trackavoi.FUN.getIndex;
sdvigIp=trackavoi.FUN.sdvigIp;
in_field=trackavoi.PAR.in_field;
szX=size(X,2);
szY=size(X,1);
szXY=szX*szY;
ind1=1:2:szXY;
ind2=2:2:szXY;
szS=size(sdvig,1);
if ((length(trackavoi.weight)>=algN) ...
    && ~isempty(trackavoi.weight{algN})...
    && size(trackavoi.weight{algN},1)==szY ...
    && size(trackavoi.weight{algN},2)==szX)
    WeightMatrix=trackavoi.weight{algN};
else
    WeightMatrix=zeros(szY,szX);
end
%% params
tic %% НАЧАЛО ОТСЧЁТА ---------------------tic-----------------------------
algStep=10;
algr0=500;
algK=(algr0^algStep)/(algStep-1);    
DangerValue=ones(szY,szX);
for i=1:size(Opponent,1)
    DangerValue=DangerValue+algK./(((X-Opponent(i,1)).^2+(Y-Opponent(i,2)).^2).^(algStep/2));
end

Q1=(sqrt((X-C(1)).^2+(Y-C(2)).^2)<=BallDangArea*dp);
Q2=(sqrt((X-Ball(1)).^2+(Y-Ball(2)).^2)<=BallDangArea*dp);

Q3=(abs(azi(angV(X-C(1),Y-C(2))-Cang))>4*pi/6);
Q4=(sqrt((X-C(1)).^2+(Y-C(2)).^2)<=dp);


BallDange=and(or(Q1,Q2),~or(Q3,Q4));
DangerValue(BallDange)=50;

[~,ICang]=min(abs(azi(Cang-angV(sdvig(:,1),sdvig(:,2)))));
DangerValue(DangerValue>100)=100;
DangerValue(DangerValue==0)=NaN;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
figure(123)
clf
hold on
axis equal
axis([-PAR.MAP_X/2-150,PAR.MAP_X/2+150,-PAR.MAP_Y/2-100,PAR.MAP_Y/2+100]);
MEGAh=0;


VarWeightMassive=zeros(szY*szX,size(sdvig,1));
%WeightMatrix=zeros(szY,szX);
WeightMatrix(getIndex(C))=0;
WeightMatrix(~in_field)=inf;

for j=1:100
    for i=1:szS
        ind1_f=min(max((ind1)+sdvigI1(i),1),szXY);
        ind2_f=min(max((ind2)+sdvigI2(i),1),szXY);
        %     VarWeightMassive(ind1,i)=WeightMatrix(1:2:szXY)+sdvigL(i);
        %     VarWeightMassive(ind2,i)=WeightMatrix(2:2:szXY)+sdvigL(i);
        %Ускорения до 25% можно получить при помощи замены массива индексов
        %на полноразмерный массив булевых флажков.
        VarWeightMassive(ind1,i)=WeightMatrix(ind1_f)+DangerValue(ind1_f)*sdvigL(i);%+rand(1)*0.1;
        VarWeightMassive(ind2,i)=WeightMatrix(ind2_f)+DangerValue(ind2_f)*sdvigL(i);%+rand(1)*0.1;
    end
    VarWeightMatrix=reshape(VarWeightMassive,[szY,szX,szS]);
    [WeightMatrix,R]=min(VarWeightMatrix,[],3);
    WeightMassive=min(VarWeightMassive,[],2);

    R(getIndex(C))=ICang;
    WeightMatrix(getIndex(C))=0;
    WeightMatrix(~in_field)=inf;

    WeightMatrix(WeightMatrix>MAX_WEIGHT)=NaN;
    WeightMassive(WeightMassive>MAX_WEIGHT)=NaN;
      
    if MEGAh==0
    	MEGAh=surf(X,Y,WeightMatrix,'EdgeColor','none');
    else
        set(MEGAh,'Zdata',WeightMatrix);
        drawnow
    end
end
toc %% КОНЕЦ ОТСЧЁТА ---------------------toc------------------------------
%% SaveResults
trackavoi.weight{algN}=WeightMatrix;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ReControl
if (WeightMatrix(getIndex(Xagent))<=MAX_WEIGHT)  
    dang=sdvig(R(getIndex(Xagent)),:);
    Ub=azi(angV(dang)-Xang)/pi;
    V=1-abs(Ub);
    V=V*min(Stop_Range,WeightMatrix(getIndex(Xagent)))/Stop_Range;
    Left =100*(V-Ub);
    Right=100*(V+Ub);
else
    Left=0;
    Right=0;
end
if isstruct(agent)
    Left=Crul(Left,Right,0,0,0);
    Right=[];
end
%% visual
%% Plots
Pplot=@(ind,sd)plot(X(sdvigIp(ind,sd)),Y(sdvigIp(ind,sd)),'Ro');
%%
for i=1:szXY
if in_field(i)
plot3(X(i),Y(i),WeightMassive(i),'.','color',[0,0,0])
%plot3([X(i),X(i)+sdvig(R(i),1)],[Y(i),Y(i)+sdvig(R(i),2)],[WeightMassive(i),WeightMassive(sdvigIp(i,R(i)))],'B-')
plot3(X(i)+0.6*[0,X(sdvigIp(i,R(i)))-X(i)],Y(i)+0.6*[0,Y(sdvigIp(i,R(i)))-Y(i)],WeightMassive(i)+0.6*[0,WeightMassive(sdvigIp(i,R(i)))-WeightMassive(i)],'K-')

else
plot3(X(i),Y(i),WeightMassive(i),'R.')
end
end

%% препятствия
figure(12314)
clf
hold on
axis equal
axis([-PAR.MAP_X/2-150,PAR.MAP_X/2+150,-PAR.MAP_Y/2-100,PAR.MAP_Y/2+100]);
plot(X,Y,'K.');
plot(X(in_field),Y(in_field),'B.');

pI=142;

plot(X(pI),Y(pI),'Ro');


figure(1235)
clf
hold on
axis equal
axis([-PAR.MAP_X/2-150,PAR.MAP_X/2+150,-PAR.MAP_Y/2-100,PAR.MAP_Y/2+100]);
surf(X,Y,DangerValue,'EdgeColor','none')
colormap('Copper');


figure(12314)
testI=[-410,80];
i=getIndex(testI);
plot(X(i),Y(i),'Ro');
plot(X(sdvigIp(i,R(i))),Y(sdvigIp(i,R(i))),'Go');
plot(X(i)+0.6*[0,X(sdvigIp(i,R(i)))-X(i)],Y(i)+0.6*[0,Y(sdvigIp(i,R(i)))-Y(i)],'B-')

figure(123)
plot3(Ball(1),Ball(2),MAX_WEIGHT,'R.','MarkerSize',50);
plot3(Opponent(:,1),Opponent(:,2),MAX_WEIGHT*ones(size(Opponent,1),1),'K.','MarkerSize',50);

Pplot(i,4);
Pplot(i,9);