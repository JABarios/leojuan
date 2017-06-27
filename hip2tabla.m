function [indices,duraciones,estadios,luces]=hip2tabla(h1c,luz)
% luz: epoca de transicion de oscuridad a luz 
% luz=1 oscuro, luz==2 iluminado
% si luz=-1 deja el campo luz a 0 (desconocido)

          jj=11;
          h1=medfilt1(h1c(:),jj);

          [w_dur,w_indice,w_estadios]=cadenando(h1,0);
          [n_dur,n_indice,n_estadios]=cadenando(h1,1);
          [r_dur,r_indice,r_estadios]=cadenando(h1,2);

          indices=[w_indice;n_indice;r_indice];
          duraciones=[w_dur;n_dur;r_dur];
          estadios=[w_estadios;n_estadios;r_estadios];

           [indices,ind]=sort(indices, 'ascend');
           duraciones=duraciones(ind);
           estadios=estadios(ind);

           %elabora vector con luz-oscuridad segun parametros asignados al inicio
           l1=(max(find(indices<luz)));
           l2=(max(find(indices<(luz+43200/5))));
           l3=(max(find(indices<(luz-43200/5))));

           if(luz > 43200/5)
              luces=indices*0+2;
              luces(1:l1)=1;
              luces(l1:end)=2;
              luces(1:l3)=2;
           else
              luces=indices*0+1;
              luces(l1:end)=2;
              luces(1:l1)=1;
              luces(l2:end)=1;

           end   
           if(luz < 0)
              luces=indices*0;
           end           
%           luztxt{2}='LUZ';
%           luztxt{1}='OSCURIDAD';
     
end

function [duracion,indices,estadios]=cadenando(h1,fase)
    xx=(h1==fase)+0;
    dxx=diff(xx);
    for(ii=2:length(xx));if(xx(ii)==1)xx(ii)=xx(ii)+xx(ii-1);end;end
    duracion=xx([dxx; 0]==-1);
    % indice del final del estadio, restamos duracion para sacar el inicio
    indices=find(dxx==-1)-duracion;
    estadios=indices*0+fase;
end
