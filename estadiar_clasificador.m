function [qw1,dd,ee,ss,td,ddc,umbral_sigma,umbral_theta,umbral_emg, umbral_delta]=estadiar_clasificador2(w2,w1,w3,fm,lon_epoca)
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
    emg  = (filtro(w3,30,39,fm));
    gamma= (filtro(w2,30,45,fm));
    
   
    dd=smooth(resumir(zscore(log(delta.^2./theta.^2)),lon_epoca*fm),9);
    ddc=smooth(resumir(zscore(log(deltac.^2./theta.^2)),lon_epoca*fm),9);
    ee=smooth(resumir(zscore((emg.^2)),lon_epoca*fm),3);
    ss=smooth(resumir(zscore(log(sigma.^2./gamma.^2)),lon_epoca*fm),6);
    thhc=smooth(resumir(zscore(log(theta.^2)),lon_epoca*fm),11);
    
%    ddc=ddc-smooth(ddc,2*900);
%    dd=dd-smooth(dd,2*900);
    ee=ee-smooth(ee,0.5*900);

%    td=smooth(zscore(-1*(dd-medfilt1(dd,200))+-1*(ss-medfilt1(ss,200))+thhc-medfilt1(thhc,200)),11);
    td=smooth(zscore((-1*(dd-medfilt1(dd,200))).*(-1*(ss-medfilt1(ss,200)))));
    
  
   % dd=ddc;
    
    umbral_emg=0.3;
    umbral_sigma=0.15;
    umbral_theta=1;
    umbral_delta=0.05;
    estadiaje=ee*0-1;

    for jj=1:2
         estadiaje(ee>umbral_emg  )=1; %w
       %  estadiaje(ss<umbral_sigma & ee>0  )=1; %w
%         
         estadiaje(ss>umbral_sigma  )=2; %nrem
         estadiaje(ee<umbral_emg & dd>umbral_delta)=2; %nrem
         estadiaje(ee<umbral_emg & dd<umbral_delta & td>umbral_theta)=3; %rem


%         p3=[mean(dd(estadiaje==3)) mean(td(estadiaje==3)) mean(ee(estadiaje==3)) mean(ss(estadiaje==3))];
%         p2=[mean(dd(estadiaje==2)) mean(td(estadiaje==2)) mean(ee(estadiaje==2)) mean(ss(estadiaje==2))];
%         p1=[mean(dd(estadiaje==1)) mean(td(estadiaje==1)) mean(ee(estadiaje==1)) mean(ss(estadiaje==1))];
% 
%         qw1=kmeans([dd'; td'; ee'; ss']',[],'start',[p1;p2;p3]);
%         qw1=medfilt1(qw1,5);
%         qw1=medfilt1(qw1,5);

        p3=[mean(dd(estadiaje==3)) mean(td(estadiaje==3))  mean(ss(estadiaje==3))];
        p2=[mean(dd(estadiaje==2)) mean(td(estadiaje==2))  mean(ss(estadiaje==2))];
        p1=[mean(dd(estadiaje==1)) mean(td(estadiaje==1))  mean(ss(estadiaje==1))];

        qw1=kmeans([dd'; td'; ss']',[],'start',[p1;p2;p3]);
        qw1=medfilt1(qw1,11); %13
        qw1=medfilt1(qw1,11);

        
        umbral_emg=mean(ee(qw1==1))+0.01;
        umbral_sigma=(mean(ss(qw1==1))+mean(ss(qw1==2)))/2;
        umbral_theta=(1.5*mean(td(qw1==2))+mean(td(qw1==3)))/2.5;
        umbral_delta=(mean(dd(qw1==2))+mean(dd(qw1==1)))/2;
        estadiaje=qw1;
    end
    
   qw1=qw1*0;
   qw1(ss>=umbral_sigma)=2;
   qw1(ss<umbral_sigma)=1;
   qw1(ee>umbral_emg)=1;
   qw1(td>=umbral_theta)=3;
  
  
  
    
    regla_3=0;regla_2=0;regla_1=0;
   for(jj=1:5)
       ii=1;
       while(ii<length(qw1)-1)
           ii=ii+1;
           if qw1(ii-1)==3 && td(ii)>0 && qw1(ii+1)==3
               qw1(ii)=3;
               regla_3=regla_3+1;
               ii=ii+2;
           end
       end
       ii=1;
       while(ii<length(qw1)-1)
           ii=ii+1;
           if qw1(ii-1)==2 && ss(ii)>prctile(ss(qw1==2),25) && qw1(ii+1)==2
               qw1(ii)=2;
               regla_2=regla_2+1;
               ii=ii+2;
           end
       end
       ii=1;
       while(ii<length(qw1)-1)
           ii=ii+1;
           if qw1(ii-1)==1 && ss(ii)<prctile(ss(qw1==1),25) && qw1(ii+1)==1
               qw1(ii)=1;
               regla_1=regla_1+1;
               ii=ii+2;
           end
       end
   
 end 
    qw1=medfilt1(qw1,11);
    qw1=medfilt1(qw1,11);



    qw1(qw1==1)=0;
    qw1(qw1==2)=1;
    qw1(qw1==3)=2;
    fprintf('r 1:%d, r2:%d, r3:%d --',regla_1,regla_2, regla_3);
 
end    
