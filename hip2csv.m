function [indices,duraciones]=hip2csv(h1,lon_epoca,arch,gen,codigo,luz)
  h1=h1(:);
  [w_dur,w_indice,w_estadios]=cadenando(h1,0);
  [n_dur,n_indice,n_estadios]=cadenando(h1,1);
  [r_dur,r_indice,r_estadios]=cadenando(h1,2);

  indices=[w_indice;n_indice;r_indice];
  duraciones=[w_dur;n_dur;r_dur];
  estadios=[w_estadios;n_estadios;r_estadios];
  
   [indices,ind]=sort(indices, 'ascend');
   duraciones=duraciones(ind);
   estadios=estadios(ind);
   luces=indices*0+1;
   if(size(luz,1)==1)
       l1=max(find(indices<luz(1)))
       l2=max(find(indices<luz(2)))
       luces(l1:l2)=2;
   else
       l1=max(find(indices<luz(1,2)));
       l2=max(find(indices<luz(2,1)));
       luces(1:l1)=2;
       luces(l2:end)=2;       
   end    
   luztxt{2}='LUZ';
   luztxt{1}='OSCURIDAD';
   
  
   fileID = fopen(arch,'w');

   fprintf(fileID,'%s\t%s\t%s\t%s\t%s\t%s\n','t','estadio','duracion','luz','GEN','cod');
   for(ii=1:length(indices))
       fprintf(fileID,'%d\t%d\t%d\t%s\t%s\t%s\n',indices(ii),estadios(ii),duraciones(ii),luztxt{luces(ii)},gen,codigo);
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
