
function [oSa,h3]=oSa_calc_hipnograma(oSa,ii,lonepoca)
   [h3]=calc_hipnograma([oSa.dirdat oSa.archs{ii}],oSa.fm,lonepoca,oSa.luces(ii));
   oSa.hyp{ii}=h3;
   fprintf('estadiado %s\n',oSa.archs{ii});
   
end


