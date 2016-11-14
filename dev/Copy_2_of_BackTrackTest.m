clear all
global PAR
PAR.MAP_Y=2000;
PAR.MAP_X=4000;
dp=50;
dx=dp;
dy=dx*sqrt(3)/2;

%
ln_xH=floor(PAR.MAP_X/2/dx)+2;
ln_yH=floor(PAR.MAP_Y/2/dy)+2;

%длина по X не важно, но по Y должна быть чётной.
%[Y,X]=meshgrid((ln_yH+1)*dy:-dy:(-ln_yH)*dy,-ln_xH*dx:dx:ln_xH*dx);
[X,Y]=meshgrid(-ln_xH*dx:dx:ln_xH*dx,(ln_yH+1*(mod(ln_yH,2)==1))*dy:-dy:-ln_yH*dy);
szX=size(X,2);
szY=size(X,1);
szXY=szX*szY;
[~,zeroXY]=min(abs(reshape(Y.^2+X.^2,[1,szXY])));
[~,zeroY]=min(Y(:,1).^2);

if mod(szY,2)~=0
    error('mod(ln_y,2)~=0');
end
if X(zeroXY)~=0 || Y(zeroXY)~=0
    error('zeroXY');
end

%Смещение чётных строчек Нка по X на пол шага.
X(2:2:end)=X(2:2:end)+dx/2;

%% sdvig множестно сдвигов 
sdvig=dp*[-0.5,+sqrt(3)/2;
          -0.5,-sqrt(3)/2;
            -1,       0;
            +1,       0;
          +0.5,-sqrt(3)/2;
          +0.5,+sqrt(3)/2;
             0,+sqrt(3);
             0,-sqrt(3);
          -1.5,+sqrt(3)/2;
          -1.5,-sqrt(3)/2;
          +1.5,+sqrt(3)/2;
          +1.5,-sqrt(3)/2]; 
sdvigL= sqrt(sdvig(:,1).^2+sdvig(:,2).^2);
sdvigI1=[-1-szY,1-szY,-szY,szY,1,-1,-2,2,-szY*2-1,-2*szY+1,szY-1,szY+1];   
sdvigI2=[-1,1,-szY,szY,+szY+1,+szY-1,-2,2,-szY-1,-szY+1,+szY*2-1,+szY*2+1];   
sdvigIp=@(ind,sd)min(max(ind+(sd>0)*(sdvigI2(max(sd,1))*(mod(ind,2)==0)+sdvigI1(max(sd,1))*(mod(ind,2)==1)),1),szXY);
szS=size(sdvig,1);
getIndex=@(z)(-round(z(2)/dy)+zeroY)+szY*(szX-1)/2+szY*round((z(1)-dx/2*(mod((-round(z(2)/dy)+zeroY),2)==0))/dx);

%% Plots
Pplot=@(ind,sd)plot(X(sdvigIp(ind,sd)),Y(sdvigIp(ind,sd)),'Ro');


% if ~isnan(Cang)
%     rz=coor(C,X,Y);   
%     rz2=coor(Ball,X,Y);
%     for i=-BallDangArea:BallDangArea
%         for j=-BallDangArea:BallDangArea
%             if ((rz(2)+i<=szY) && (rz(2)+i>0) && (rz(1)+j<=szX) && (rz(1)+j>0))
%                 qwert=[X(rz(2)+i,rz(1)+j)-X(rz(2),rz(1)),...
%                        Y(rz(2)+i,rz(1)+j)-Y(rz(2),rz(1))];
%                 if ((abs(azi(angV(qwert)-Cang))<4*pi/6) && norm(qwert)>d*2)
%                     FF(rz(2)+i,rz(1)+j)=50;            
%                 end
%             end
%             if ((rz2(2)+i<=szY) && (rz2(2)+i>0) && (rz2(1)+j<=szX) && (rz2(1)+j>0))
%                 qwert=[X(rz2(2)+i,rz2(1)+j)-X(rz2(2),rz2(1)),...
%                        Y(rz2(2)+i,rz2(1)+j)-Y(rz2(2),rz2(1))];
%                 if ((abs(azi(angV(qwert)-Cang))<4*pi/6) && norm(qwert)>d*2)
%                     FF(rz2(2)+i,rz2(1)+j)=50;            
%                 end
%             end
%         end
%     end
% end
%% препятствия






I=1:(size(X,1)*size(X,2));

figure(12314)
clf
hold on
axis equal
axis([-PAR.MAP_X/2-150,PAR.MAP_X/2+150,-PAR.MAP_Y/2-100,PAR.MAP_Y/2+100]);
plot(X,Y,'K.');
in_field=and(abs(X)<=PAR.MAP_X/2,abs(Y)<=PAR.MAP_Y/2);
plot(X(in_field),Y(in_field),'B.');

pI=142;

plot(X(pI),Y(pI),'Ro');

%% params
    algStep=10;
    algr0=500;
 algK=(algr0^algStep)/(algStep-1);
Opponent=[250,-400; 400,600; -700, -300; -450, 900];
Cang=pi/4*0;
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

figure(1235)
clf
hold on
axis equal
axis([-PAR.MAP_X/2-150,PAR.MAP_X/2+150,-PAR.MAP_Y/2-100,PAR.MAP_Y/2+100]);
surf(X,Y,DangerValue,'EdgeColor','none')
colormap('Copper');


% figure(12314)
% for i=1:szXY
%     if BallDange(i)
%     plot(X(i),Y(i),'Ro');
%         X(i)
%         Y(i)
%     end
% end
%return


%Z=range(
lsloy=2;
VarWeightMassive=zeros(szY*szX,size(sdvig,1));
WeightMatrix=zeros(szY,szX);

%WeightExternal=[ones(lsloy+szY+lsloy,lsloy)*inf,[ones(lsloy,szX)*inf;weight;ones(lsloy,szX)*inf],ones(lsloy+szY+lsloy,lsloy)*inf];

figure(123)
clf
hold on
axis equal
axis([-PAR.MAP_X/2-150,PAR.MAP_X/2+150,-PAR.MAP_Y/2-100,PAR.MAP_Y/2+100]);
MEGAh=0;
tic

indtest=(WeightMatrix==-inf);
ind1=1:2:szXY;
ind2=2:2:szXY;

for j=1:1000
    WeightMatrix(~in_field)=inf;
%     if j<150
     WeightMatrix(getIndex([0,0]))=0;
%     end
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

        WeightMatrix(~in_field)=inf;
%    if j<150
    	WeightMatrix(getIndex([0,0]))=0;
%    end
    WeightMatrix(WeightMatrix>3000)=NaN;
    WeightMassive(WeightMassive>3000)=NaN;

        %WeightMatrix(453)=0;
    if MEGAh==0
    	MEGAh=surf(X,Y,WeightMatrix,'EdgeColor','none');
    else
        set(MEGAh,'Zdata',WeightMatrix);
    end
    drawnow
end
toc
for i=1:szXY
if in_field(i)
plot3(X(i),Y(i),WeightMassive(i),'.','color',[0,0,0])
%plot3([X(i),X(i)+sdvig(R(i),1)],[Y(i),Y(i)+sdvig(R(i),2)],[WeightMassive(i),WeightMassive(sdvigIp(i,R(i)))],'B-')
plot3(X(i)+0.6*[0,X(sdvigIp(i,R(i)))-X(i)],Y(i)+0.6*[0,Y(sdvigIp(i,R(i)))-Y(i)],WeightMassive(i)+0.6*[0,WeightMassive(sdvigIp(i,R(i)))-WeightMassive(i)],'K-')

else
plot3(X(i),Y(i),WeightMassive(i),'R.')
end
end


figure(12314)
testI=[-410,80];
i=getIndex(testI)
plot(X(i),Y(i),'Ro');
plot(X(sdvigIp(i,R(i))),Y(sdvigIp(i,R(i))),'Go');
plot(X(i)+0.6*[0,X(sdvigIp(i,R(i)))-X(i)],Y(i)+0.6*[0,Y(sdvigIp(i,R(i)))-Y(i)],'B-')

Pplot(i,4);
Pplot(i,9);


figure(12323)
%feather([X,Y]

%surf(X,Y,WeightMatrix)
%[WeightMatrix,R]=min(VarWeightMassive,[],3);

