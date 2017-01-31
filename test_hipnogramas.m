
function [h1,h2,h3]=test_hipnogramas(arch,fm,lepoca,archcsv,gen,codigo,luz)

   load(arch);
%   [h1]=estadiar_clasico(w1(1,:),w1(2,:),w1(3,:),fm,lepoca);
%   [h2]=estadiar_gurev_mod(w1(1,:),w1(2,:),w1(3,:),fm,lepoca);
   [h3]=estadiar_clasificador(w1(1,:),w1(2,:),w1(3,:),fm,lepoca);
   hip2csv(h3,lepoca,archcsv,gen,codigo,luz);


%    figure;
%    subplot(3,1,1);
%    plot(h1);
%    ylim([-1.5 2.5]);
%    subplot(3,1,2);
%    plot(h2);
%    ylim([-1.5 2.5]);
   subplot(3,1,3);
   plot(h3);
   ylim([-1.5 2.5]);
   


end



