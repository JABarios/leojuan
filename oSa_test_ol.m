
function [oSa,indices]=oSa_test_ol(oSa,ii,lonepoca)
   [indices]=test_ol([oSa.dirdat oSa.archs{ii}],oSa.fm,lonepoca,oSa.gen{ii},oSa.cod{ii},oSa.luces(ii));
end

