maxescala=300;
arch_salida='basura';

oSa=estructura_wtsmarkov();

for ii=1:length(oSa.archs)
  tic;  
  [oSa,h1]=oSa_calc_hipnograma(oSa,ii,5);
  toc;
end
 save('wt_hipnos_markov','oSa')
 


