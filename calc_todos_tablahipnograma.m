maxescala=300;
arch_salida='basura';

%oSa=estructura_wtsmarkov();

for ii=1:length(oSa.archs)
  tic;  
  oSa=oSa_calc_tablahipnograma(oSa,ii);
  toc;
end
% save('wt_hipnos_markov','oSa')
 


