
function [h3,dd,ee,ss,td,ddc]=test_hipnogramas(arch,fm,lepoca,archcsv,gen,codigo,luz,modarch)

   load(arch);
%   [h1]=estadiar_clasico(w1(1,:),w1(2,:),w1(3,:),fm,lepoca);
%   [h2]=estadiar_gurev_mod(w1(1,:),w1(2,:),w1(3,:),fm,lepoca);
   [h3,dd,ee,ss,td,ddc,us,ut,ue,ud]=estadiar_clasificador(w1(1,:),w1(2,:),w1(3,:),fm,lepoca);
   [indluz,xx2,luces]=hip2csv(h3,lepoca,archcsv,gen,codigo,luz,modarch);
   estadisticas_sueno(h3,lepoca);

   fig = figure;
   subplot(5,1,1);
   hold on;
   plot(h3);
   ylim([-1.5 2.5]);
   plot(indluz,-2+1./(luces==1),'b');
   ylabel('hyp');
   subplot(5,1,2);
   plot(td);
   ylim([-2 4.0]);
   hline(ut);
   ylabel('thHc');
   subplot(5,1,3);
   plot(dd);
   ylim([-0.6 1.0]);
   ylabel('dlCx');
   hline(ud);
   subplot(5,1,4);
   plot(ss);
   hline(us);
   ylim([-0.6 1.0]);
   ylabel('sigCx');
   subplot(5,1,5);
   plot(ee);
   hline(ue);
   ylim([-0.6 1.0]);
   ylabel('emg');
   suptitle(arch);
   drawnow;
   print(fig,[arch '_fig.png'],'-dpng')
%[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT3_TW1',300,5,'w7_esta','WT','07',[1 7000]);
end



