function [indices,duraciones,luces]=hip2csv(h1c,lon_epoca,arch,gen,codigo,luz,modoarch,maxescala)
% luz: epoca de transicion de oscuridad a luz 
% modoarch 1 con cabecero-inicio 2 sin cabecero-append
 
     %escribimos un archivo csv delimitado por tabuladores
     if(modoarch==1)
               fileID = fopen([arch '.csv'],'w');
               fprintf(fileID,'%s\t%s\t%s\t%s\t%s\t%s\t%s\n','cod','GEN','dur','est','t','luz','escala');
     else
               fileID = fopen([arch '.csv'],'a');
     end
     for jj=1:maxescala

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
           luztxt{2}='LUZ';
           luztxt{1}='OSCURIDAD';
     
           for(ii=1:length(indices))
                 fprintf(fileID,'%s\t%s\t%d\t%d\t%d\t%s\t%d\n',codigo,gen,duraciones(ii)*lon_epoca,estadios(ii),indices(ii)*lon_epoca,luztxt{luces(ii)},jj);
           end    
      end        
      fclose(fileID);

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
