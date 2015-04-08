global Modul
if isempty(Modul)
    return
end
Modul.T=Modul.T+Modul.dT;
MOD_Agents();
MOD_Ball();