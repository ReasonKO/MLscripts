%angV = angV(Z)
%angV = angV(re,im)
%Угол направления вектора.

function angV = angV(Z,im)
if (nargin==2)
    Z=[Z,im];
end    
%AZI Summary of this function goes here
%   Detailed explanation goes here
if norm(Z)==0 
    angV=0;
    return;
end
re=Z(1);
im=Z(2);
angV = acos(re/sqrt((re)^2+(im)^2));
%     if(sign(re)~=sign(im))
%         alpha=-alpha;
%     end
%     alpha
%     if (re<0)
%         alpha=alpha+pi*sign(im);
%     end
    if (im<0) angV=-angV;
end