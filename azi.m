%ang = azi(ang)
%���������� �������� ���� � [-pi,pi];

function ang = azi(ang)
ang=rem(ang,2*pi);
if (abs(ang)>pi) 
    ang=ang-sign(ang)*2*pi; 
end
end
