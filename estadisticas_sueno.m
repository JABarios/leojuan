function s=estadisticas_sueno(h1,lon_epoca)
  h1=h1(:);
  s.w_d=mean(cadenando(h1,0))*lon_epoca;
  s.nrem_d=mean(cadenando(h1,1)*lon_epoca);
  s.rem_d=mean(cadenando(h1,2)*lon_epoca);
  

end

function salida=cadenando(h1,fase)
    xx=(h1==fase)+0;
    dxx=diff(xx);
    for(ii=2:length(xx));if(xx(ii)==1)xx(ii)=xx(ii)+xx(ii-1);end;end
    salida=xx([dxx; 0]==-1);
end

