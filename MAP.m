% MAP
% Отрисовка поля и игроков 
% Создание структуры MAP_PAR и перемещение отрисованного ранее

%% Было ли создано окно?
global MAP_PAR;
global Blues;
global Yellows;
global Balls;

if (isfield(MAP_PAR,'MAP_H') && ishandle(MAP_PAR.MAP_H) && isequal('on',get(MAP_PAR.MAP_H,'Visible')))
%% BEGIN 

MAP_l=150;
for MAP_i=1:size(Blues,1)
    if (Blues(MAP_i,1)>0)
        viz_x=Blues(MAP_i,2);
        viz_y=Blues(MAP_i,3);
        viz_angx=[Blues(MAP_i,2),Blues(MAP_i,2)+MAP_l*cos(Blues(MAP_i,4))];
        viz_angy=[Blues(MAP_i,3),Blues(MAP_i,3)+MAP_l*sin(Blues(MAP_i,4))];
        if (isempty(MAP_PAR.viz_Blues{MAP_i}))
            figure(100)
            MAP_PAR.viz_Blues{MAP_i}(1)=plot(viz_x,viz_y,'Bo');        
            MAP_PAR.viz_Blues{MAP_i}(2)=plot(viz_angx,viz_angy,'B-');            
            MAP_PAR.viz_Blues{MAP_i}(3)=text(viz_x+MAP_l/2,viz_y+MAP_l/2,{MAP_i});
        else                        
            set(MAP_PAR.viz_Blues{MAP_i}(1),'xdata',viz_x,'ydata',viz_y);
            set(MAP_PAR.viz_Blues{MAP_i}(2),'xdata',viz_angx,'ydata',viz_angy);    
            set(MAP_PAR.viz_Blues{MAP_i}(3),'Position',[viz_x+MAP_l/2,viz_y+MAP_l/2]);    
        end
    end
end    
for MAP_i=1:size(Yellows,1)
    if (Yellows(MAP_i,1)>0)
        viz_x=Yellows(MAP_i,2);
        viz_y=Yellows(MAP_i,3);
        viz_angx=[Yellows(MAP_i,2),Yellows(MAP_i,2)+MAP_l*cos(Yellows(MAP_i,4))];
        viz_angy=[Yellows(MAP_i,3),Yellows(MAP_i,3)+MAP_l*sin(Yellows(MAP_i,4))];
        if (isempty(MAP_PAR.viz_Yellows{MAP_i}))
            figure(100)
            MAP_PAR.viz_Yellows{MAP_i}(1)=plot(viz_x,viz_y,'Yo');   
            MAP_PAR.viz_Yellows{MAP_i}(2)=plot(viz_angx,viz_angy,'Y-');            
            MAP_PAR.viz_Yellows{MAP_i}(3)=text(viz_x+MAP_l/2,viz_y+MAP_l/2,{MAP_i});
        else                        
            set(MAP_PAR.viz_Yellows{MAP_i}(1),'xdata',viz_x,'ydata',viz_y);
            set(MAP_PAR.viz_Yellows{MAP_i}(2),'xdata',viz_angx,'ydata',viz_angy);                 
            set(MAP_PAR.viz_Yellows{MAP_i}(3),'Position',[viz_x+MAP_l/2,viz_y+MAP_l/2]);   
        end
    end
end
if (Balls(1)>0)
    viz_x=Balls(2);
    viz_y=Balls(3);
    if (isempty(MAP_PAR.viz_Balls))
        figure(100)
        MAP_PAR.viz_Balls=plot(viz_x,viz_y,'Ro');
        set(MAP_PAR.viz_Balls,'ZData',1);
    else
        set(MAP_PAR.viz_Balls,'xdata',viz_x,'ydata',viz_y);
    end
end
drawnow
%% END
end
