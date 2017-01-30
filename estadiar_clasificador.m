function [qw1]=estadiar_clasificador(w2,w1,w3,fm,lon_epoca)
% calculado para fm=200 y estadiamos cada 5 segundos   
% devuelve hipnograma

%obtenemos w1 (hc) y w2 (cx) y w3 (emg)
% estadiaje 1 w   3 nrem 4 rem
 
   
 eegref=reformatear(w2(:),lon_epoca*fm);    
    

%obtenemos señales para estadiar   
    delta=(filtro(w2,1,4,fm));
    theta=(filtro(w1,6,10,fm));
    emg=(filtro(w3,30,35,fm));

    emgref=reformatear(emg(:),lon_epoca*fm);    
    
    dd=smooth(resumir(zscore(log(delta.^2)),lon_epoca*fm),9);
    ee=smooth(resumir(zscore(log(emg.^2)),lon_epoca*fm),3);
    td=smooth(resumir(zscore(theta.^2)-zscore(delta.^2),lon_epoca*fm),9);
    
    estadiaje=ee;
    estadiaje(ee>-9)=-0.5;
   
    estadiaje(ee>0.0)=1; %w
    estadiaje(ee<0.0)=2; %w
   
    estadiaje(ee<0.0 & dd>0.05)=3; %nrem
    estadiaje(ee<0.0 & td>0.1)=4; %rem
   
    p4=[mean(dd(estadiaje==4)) mean(td(estadiaje==4)) mean(ee(estadiaje==4))];
    p3=[mean(dd(estadiaje==3)) mean(td(estadiaje==3)) mean(ee(estadiaje==3))];
    p2=[mean(dd(estadiaje==2)) mean(td(estadiaje==2)) mean(ee(estadiaje==2))];
    p1=[mean(dd(estadiaje==1)) mean(td(estadiaje==1)) mean(ee(estadiaje==1))];

    qw1=kmeans([dd'; td'; ee']',[],'start',[p1;p2;p3;p4]);
    qw1=medfilt1(qw1,5);
    qw1=medfilt1(qw1,5);
   
   
    estadiaje=qw1;
    p4=[mean(dd(estadiaje==4)) mean(td(estadiaje==4)) mean(ee(estadiaje==4))];
    p3=[mean(dd(estadiaje==3)) mean(td(estadiaje==3)) mean(ee(estadiaje==3))];
    p2=[mean(dd(estadiaje==2)) mean(td(estadiaje==2)) mean(ee(estadiaje==2))];
    p1=[mean(dd(estadiaje==1)) mean(td(estadiaje==1)) mean(ee(estadiaje==1))];

    qw1=kmeans([dd'; td'; ee']',[],'start',[p1;p2;p3;p4]);
   
   
   ii=1;
   while(ii<length(qw1)-1)
       ii=ii+1;
       if qw1(ii-1)==4 && td(ii)>0 && qw1(ii+1)==4
           qw1(ii)=4;
           ii=ii+2;
       end
   end
%    
  ii=1;
   while(ii<length(qw1)-1)
       ii=ii+1;
       if qw1(ii-1)==3 && dd(ii)>0 && ee(ii)<0 && qw1(ii+1)==3
           qw1(ii)=2;
           ii=ii+2;
       end
   end
% 
 qw1(qw1==2)=1; 
 
     ii=1;
   while(ii<length(qw1)-1)
       ii=ii+1;
       if qw1(ii-1)==1 && ee(ii)>mean(ee(qw1==3)) && qw1(ii+1)==1
           qw1(ii)=1;
           ii=ii+2;
       end
   end
   

    qw1=medfilt1(qw1,5);
    qw1=medfilt1(qw1,5);
  
    passgamma1=(filtro(w1,75,95,200));
    passgamma2=(filtro(w1,75,95,200));
    w1=w1/sum(passgamma1.^2);
    w2=w2/sum(passgamma2.^2);

    [w1_fft,frec_fft,tiempos,potencias]=sig2espectro(w1,5,1,200);
    s1=mean(w1_fft(qw1==1,:)); %w
    s2=mean(w1_fft(qw1==3,:)); %nrem
    s3=mean(w1_fft(qw1==4,:)); %rem

    [w1_fft,frec_fft,tiempos,potencias]=sig2espectro(w2,5,1,200);
    s4=mean(w1_fft(qw1==1,:)); %w
    s5=mean(w1_fft(qw1==3,:)); %nrem
    s6=mean(w1_fft(qw1==4,:)); %rem

    s1=s1/sum(s1);
    s2=s2/sum(s2);
    s3=s3/sum(s3);
    s4=s4/sum(s4);
    s5=s5/sum(s5);
    s6=s6/sum(s6);

    


end    


