
function oSa_pinta_sueno(oSa,ii)

   h3=oSa.hyp{ii}.h1;
   dd=oSa.hyp{ii}.dd;
   ee=oSa.hyp{ii}.ee;
   ss=oSa.hyp{ii}.ss;
   td=oSa.hyp{ii}.td;
   ddc=oSa.hyp{ii}.ddc;
   us=oSa.hyp{ii}.us;
   ut=oSa.hyp{ii}.ut;
   ue=oSa.hyp{ii}.ue;
   ud=oSa.hyp{ii}.ud;
   lepoca=5;
   [indluz,xx2,luces]=hip2csv(h3,5,'kk','WT','01',oSa.luces(ii),1,300);
   estadisticas_sueno(h3,5);

   h3=medfilt1(h3,30);
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
   suptitle(oSa.archs{ii});
   drawnow;
%   print(fig,[arch '_fig.png'],'-dpng')

end