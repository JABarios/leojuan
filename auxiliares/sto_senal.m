function w1=sto_senal(ss,canal,f1,f2)

sss=ss.senal{canal};
f=ss.frec;


[epocas,columnas]=size(sss);
frecuencias= f>f1 & f<f2;
w1=sss(:,frecuencias);
w1=sum(w1')';
%w1=w1/trimmean(w1,5);
w1=w1/mean(w1);

%w1=zscore(w1);
end