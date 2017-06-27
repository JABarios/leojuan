function [oSa]=oSa_calc_tablahipnograma(oSa,ii)
   
   [indices,duraciones,estadios,luces]=hip2tabla(oSa.hyp{ii}.h1,oSa.luces(ii));
   oSa.hyp{ii}.tabla=  [indices duraciones estadios luces];
   
end



