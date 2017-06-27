function [h1]=calc_hipnograma(arch,fm,lepoca,luz)

   load(arch);
   [h1.h1,h1.dd,h1.ee,h1.ss,h1.td,h1.ddc,h1.us,h1.ut,h1.ue,h1.ud]=estadiar_clasificador(w1(1,:),w1(2,:),w1(3,:),fm,lepoca);
   h1.tabla=hip2tabla(h1.h1,luz);
   
end



