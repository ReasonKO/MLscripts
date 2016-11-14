function TrackAvoi_INI()
global trackavoi;
global PAR
if (isempty(PAR))
    PAR.MAP_Y=2000;
    PAR.MAP_X=4000;
end
%%
dp=50;
%%
dx=dp;
dy=dx*sqrt(3)/2;
ln_xH=floor(PAR.MAP_X/2/dx)+2;
ln_yH=floor(PAR.MAP_Y/2/dy)+2;
%длина по X не важно, но по Y должна быть чЄтной.
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
%—мещение чЄтных строчек Ќка по X на пол шага.
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
in_field=and(abs(X)<=PAR.MAP_X/2,abs(Y)<=PAR.MAP_Y/2);


trackavoi.PAR.dp=dp;
trackavoi.PAR.X=X;
trackavoi.PAR.Y=Y;
trackavoi.PAR.sdvig=sdvig;
trackavoi.PAR.sdvigI1=sdvigI1;
trackavoi.PAR.sdvigI2=sdvigI2;
trackavoi.PAR.sdvigL=sdvigL;
trackavoi.PAR.in_field=in_field;
trackavoi.FUN.getIndex=getIndex;
trackavoi.FUN.sdvigIp=sdvigIp;
end