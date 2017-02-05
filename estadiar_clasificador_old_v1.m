function [qw1,dd,ee,ss,td,ddc,umbral_sigma,umbral_theta,umbral_emg]=estadiar_clasificador(w2,w1,w3,fm,lon_epoca)
% calculado para fm=200 y estadiamos cada 5 segundos   
% devuelve hipnograma

%obtenemos w1 (hc) y w2 (cx) y w3 (emg)
% estadiaje 1 w   3 nrem 4 rem
% -2 mov
% -1 no estadiado
% 0 vigilia
% 1 nrem
% 2 rem


%obtenemos señales para estadiar   
    theta= (filtro(w1,6,10,fm));
    delta= (filtro(w1,1,4,fm));
    deltac= (filtro(w2,1,4,fm));
    sigma= (filtro(w2,10,15,fm));
    emg  = (filtro(w3,30,35,fm));
   
    dd=smooth(resumir(zscore(log(delta.^2)),lon_epoca*fm),9);
    ddc=smooth(resumir(zscore(log(deltac.^2)),lon_epoca*fm),9);
    ee=smooth(resumir(zscore(log(emg.^2)),lon_epoca*fm),3);
    ss=smooth(resumir(zscore(log(sigma.^2)),lon_epoca*fm),6);
    thhc=smooth(resumir(zscore(log(theta.^2)),lon_epoca*fm),11);
    
    ddc=ddc-smooth(ddc,2*900);
    dd=dd-smooth(dd,2*900);
    ee=ee-smooth(ee,0.5*900);

    td=smooth(zscore(-1*(dd-medfilt1(dd,200))+-1*(ss-medfilt1(ss,200))+thhc-medfilt1(thhc,200)),11);
    
%    td=smooth(resumir(zscore(log(delta.^2)),lon_epoca*fm),2);
  
    

    estadiaje=ee;
    estadiaje(ee>-9)=2;
   
    estadiaje(ss>0.1  )=3; %w
    estadiaje(ee>0.1)=1; %indet
   
    estadiaje(ee<0.0 & ss > 0 & dd>0.05)=3; %nrem
    estadiaje(ee<0.0 & ss < 0.2 & dd<-0.02 & td>1.8)=4; %rem
   
    p4=[mean(dd(estadiaje==4)) mean(td(estadiaje==4)) mean(ee(estadiaje==4)) mean(ss(estadiaje==4))];
    p3=[mean(dd(estadiaje==3)) mean(td(estadiaje==3)) mean(ee(estadiaje==3)) mean(ss(estadiaje==3))];
    p2=[mean(dd(estadiaje==2)) mean(td(estadiaje==2)) mean(ee(estadiaje==2)) mean(ss(estadiaje==2))];
    p1=[mean(dd(estadiaje==1)) mean(td(estadiaje==1)) mean(ee(estadiaje==1)) mean(ss(estadiaje==1))];

    qw1=kmeans([dd'; td'; ee'; ss']',[],'start',[p1;p2;p3;p4]);
    qw1=medfilt1(qw1,5);
    qw1=medfilt1(qw1,5);
   
   
    estadiaje=qw1;
     p4=[mean(dd(estadiaje==4)) mean(td(estadiaje==4)) mean(ee(estadiaje==4)) mean(ss(estadiaje==4))];
     p3=[mean(dd(estadiaje==3)) mean(td(estadiaje==3)) mean(ee(estadiaje==3)) mean(ss(estadiaje==3))];
     p2=[mean(dd(estadiaje==2)) mean(td(estadiaje==2)) mean(ee(estadiaje==2)) mean(ss(estadiaje==2))];
     p1=[mean(dd(estadiaje==1)) mean(td(estadiaje==1)) mean(ee(estadiaje==1)) mean(ss(estadiaje==1))];


    qw1=kmeans([dd'; td'; ee'; ss']',[],'start',[p1;p2;p3;p4]);
    qw1=medfilt1(qw1,5);
    qw1=medfilt1(qw1,5);

for(jj=1:5)
    
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
       if qw1(ii-1)==3 && ss(ii)>mean(ss(qw1==1)) && qw1(ii+1)==3
           qw1(ii)=2;
           ii=ii+2;
       end
   end
% 

 qw1(qw1==2)=3; 
 
     ii=1;
   while(ii<length(qw1)-1)
       ii=ii+1;
       if qw1(ii-1)==1 && ss(ii)<mean(ss(qw1==3)) && qw1(ii+1)==1
           qw1(ii)=1;
           ii=ii+2;
       end
   end
   
end
    qw1(qw1==1)=0;
    qw1(qw1==3)=1;
    qw1(qw1==4)=2;
 
    umbral_emg=(mean(ee(qw1==0))+mean(ee(qw1==1)))/2;
    umbral_sigma=(mean(ss(qw1==0))+mean(ss(qw1==1)))/2;
    umbral_theta=(mean(td(qw1==1))+mean(td(qw1==2)))/2;

    estadiaje=ee;
    estadiaje(ee>-9)=-0.5;
   
    estadiaje(ee>umbral_emg)=1; %w
    estadiaje(ee<umbral_emg)=2; %w
   
    estadiaje(ee<umbral_emg & ss > umbral_sigma )=3; %nrem
    estadiaje(ee<umbral_emg & td > umbral_theta)=4; %rem
   
    p4=[mean(dd(estadiaje==4)) mean(td(estadiaje==4)) mean(ee(estadiaje==4)) mean(ss(estadiaje==4))];
    p3=[mean(dd(estadiaje==3)) mean(td(estadiaje==3)) mean(ee(estadiaje==3)) mean(ss(estadiaje==3))];
    p2=[mean(dd(estadiaje==2)) mean(td(estadiaje==2)) mean(ee(estadiaje==2)) mean(ss(estadiaje==2))];
    p1=[mean(dd(estadiaje==1)) mean(td(estadiaje==1)) mean(ee(estadiaje==1)) mean(ss(estadiaje==1))];

    qw1=kmeans([dd'; td'; ee'; ss']',[],'start',[p1;p2;p3;p4]);
    qw1=medfilt1(qw1,5);
    qw1=medfilt1(qw1,5);

 for(jj=1:5)
    
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
       if qw1(ii-1)==3 && ss(ii)>mean(ss(qw1==1)) && qw1(ii+1)==3
           qw1(ii)=2;
           ii=ii+2;
       end
   end
% 

 qw1(qw1==2)=3; 
 
     ii=1;
   while(ii<length(qw1)-1)
       ii=ii+1;
       if qw1(ii-1)==1 && ss(ii)<mean(ss(qw1==3)) && qw1(ii+1)==1
           qw1(ii)=1;
           ii=ii+2;
       end
   end
   
 end 

    qw1(qw1==1)=0;
    qw1(qw1==3)=1;
    qw1(qw1==4)=2;
    
    umbral_emg=(mean(ee(qw1==0))+mean(ee(qw1==1)))/2;
    umbral_sigma=(mean(ss(qw1==0))+mean(ss(qw1==1)))/2;
    umbral_theta=(mean(td(qw1==1))+mean(td(qw1==2)))/2;

  
    
    qw1=qw1*0;
    qw1(ss>=umbral_sigma)=1;
    qw1(ee>=umbral_emg)=0;
    qw1( ss>=umbral_sigma & ee<umbral_emg)=1;
    qw1(td>=umbral_theta & ee<=umbral_emg)=2;

    qw1=medfilt1(qw1,5);
    qw1=medfilt1(qw1,5);
   
%    
 for(jj=1:100)
      ii=1;
       while(ii<length(qw1)-1)
           ii=ii+1;
           if qw1(ii-1)==1 && (ss(ii)>0) && qw1(ii+1)==1
               qw1(ii)=1;
               ii=ii+2;
           end
       end
   % 
 
     ii=1;
   while(ii<length(qw1)-1)
       ii=ii+1;
       if qw1(ii-1)==0 && ss(ii)<0 && qw1(ii+1)==0
           qw1(ii)=0;
           ii=ii+2;
       end
   end
   
       ii=1;
   while(ii<length(qw1)-1)
       ii=ii+1;
       if qw1(ii-1)==2 && td(ii)>0 && qw1(ii+1)==2
           qw1(ii)=2;
           ii=ii+2;
       end
   end
end

    qw1=medfilt1(qw1,7);
    qw1=medfilt1(qw1,7);

end    


