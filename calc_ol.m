maxescala=300;
arch_salida='basura';

oSa=estructura_wtsmarkov();

for ii=1:length(oSa.archs)
  [oSa,indices]=oSa_test_ol(oSa,ii,5);
end


 % empiza con luz en el numerito
[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT4_TW1',300,5,arch_salida,'WT','04',[38551/5],1,maxescala);
[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT7_TW1',300,5,arch_salida,'WT','07',[7781/5 ],2,maxescala);
[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT1_TW1',300,5,arch_salida,'WT','01',[59717/5 ],2,maxescala);
[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT2_TW1',300,5,arch_salida,'WT','02',[24102/5 ],2,maxescala);
[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT3_TW1',300,5,arch_salida,'WT','03',[ 86248/5 ],2,maxescala); %cam
[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT5_TW1',300,5,arch_salida,'WT','05',[2947/5],2,maxescala);
[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT6_TW1',300,5,arch_salida,'WT','06',[7781/5],2,maxescala);
[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT9_TW1',300,5,arch_salida,'WT','09',[11129/5],2,maxescala);
[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT12_TW1',300,5,arch_salida,'WT','12',[41608/5 ],2,maxescala); %cam
[h3,dd,ee,ss,td,ddc]=test_hipnogramas('datos/WT13_TW1',300,5,arch_salida,'WT','13',[38251/5],2,maxescala);

