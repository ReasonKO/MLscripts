algN=1;
%%



global trackavoi PAR

if isempty(trackavoi) || ~isfield(trackavoi,'weight')
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

%% Plots
Pplot=@(ind,sd)plot(X(sdvigIp(ind,sd)),Y(sdvigIp(ind,sd)),'Ro');
%% params
    algStep=10;
    algr0=500;
 algK=(algr0^algStep)/(algStep-1);
Opponent=[250,-400; 400,600; -700, -300; -450, 900];
Cang=pi/4;
BallDangArea=4;
Ball=[000,000];
    
DangerValue=ones(szY,szX);
for i=1:size(Opponent,1)
    DangerValue=DangerValue+algK./(((X-Opponent(i,1)).^2+(Y-Opponent(i,2)).^2).^(algStep/2));
end
Q1=(abs(azi(angV(X-Ball(1),Y-Ball(2))-Cang))<4*pi/6);
Q2=(sqrt((X-Ball(1)).^2+(Y-Ball(2)).^2)<=BallDangArea*dp);
Q3=(sqrt((X-Ball(1)).^2+(Y-Ball(2)).^2)>dp);
BallDange=and(and(Q1,Q2),Q3);
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

tic

VarWeightMassive=zeros(szY*szX,size(sdvig,1));
%WeightMatrix=zeros(szY,szX);
WeightMatrix(getIndex(Ball))=0;
WeightMatrix(~in_field)=inf;

for j=1:100
    for i=1:szS
        ind1_f=min(max((ind1)+sdvigI1(i),1),szXY);
        ind2_f=min(max((ind2)+sdvigI2(i),1),szXY);
        %     VarWeightMassive(ind1,i)=WeightMatrix(1:2:szXY)+sdvigL(i);
        %     VarWeightMassive(ind2,i)=WeightMatrix(2:2:szXY)+sdvigL(i);
        %Ускорения до 25% можно получить при помощи замены массива индексов на
        %полноразмерный массив булевых флажков.
        VarWeightMassive(ind1,i)=WeightMatrix(ind1_f)+DangerValue(ind1_f)*sdvigL(i);%+rand(1)*0.1;
        VarWeightMassive(ind2,i)=WeightMatrix(ind2_f)+DangerValue(ind2_f)*sdvigL(i);%+rand(1)*0.1;
    end
    VarWeightMatrix=reshape(VarWeightMassive,[szY,szX,szS]);
    [WeightMatrix,R]=min(VarWeightMatrix,[],3);
    WeightMassive=min(VarWeightMassive,[],2);

    R(getIndex(Ball))=ICang;
    WeightMatrix(getIndex(Ball))=0;
    WeightMatrix(~in_field)=inf;

    WeightMatrix(WeightMatrix>3000)=NaN;
    WeightMassive(WeightMassive>3000)=NaN;
      
    if MEGAh==0
    	MEGAh=surf(X,Y,WeightMatrix,'EdgeColor','none');
    else
        set(MEGAh,'Zdata',WeightMatrix);
        drawnow
    end
end
toc
%% SaveResults
trackavoi.weight{algN}=WeightMatrix;

%% visual
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

Pplot(i,4);
Pplot(i,9);