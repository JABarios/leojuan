function [h1]=estadiar_clasico(w1c,w1h,w1e,fm,lepoca)

%fm=200;
%lepoca=5;
horas=24;
% -2 mov
% -1 no estadiado
% 0 vigilia
% 1 nrem
% 2 rem

    %leemos emg
    w1e=w1e(:);
    w1e=w1e(1:fm*60*60*horas);
    w1e=reshape(w1e,fm*lepoca,[]);
    emg=median(abs(w1e));
    me=mean(emg);
    de=std(emg);
    w1e=0;

   % el histograma empieza como todo a -1 
   % marcamos como 0 ("vigilia") si emg > emg+2sd 
    h1=zeros(1,length(emg))-1;
	dbg_reglas(h1);

    h1(  h1==-1 & emg   > (me + 1 * de)) =0;

    'regla vigilia'
	dbg_reglas(h1);
   
    %leemos corteza
    w1c=w1c(:);

    w1c=w1c(1:fm*60*60*horas);
    w1c(isnan(w1c))=max(w1c);

    %eliminamos artef de mov
    w1cf=filtro(w1c,30,40,fm);
    w1cxartef=reshape(w1cf,fm*lepoca,[]);
    w1cf=0;
    artef=median(abs(w1cxartef));
   % artefsd=std(abs(w1cxartef));
    artefsd=smooth(artef,fm)';
    
    h1( artef > 1.2*artefsd  )= -2;
    w1cxartef=0;
    
    'regla artefactos' 
	dbg_reglas(h1);

    %calculo de fmd en corteza
    [Sh,fh]=sig2espectro(w1c,lepoca,1,fm);
    fmda=esp2fmd(Sh,fh,[1 30]);
    
    %umbral de vigilia 
    umbral_vig=median(fmda(h1==0));
    sd_umbral_vig=mad(fmda(h1==0));
    w1c=0;

    %marcamos 0 (vigilia) si fmd>umbral y emg > mediana
    h1(  h1==-1 & fmda' > (umbral_vig+0.1*sd_umbral_vig) ...
                & emg > (me - 0*de)) =0;
    h1(  h1==-1 & emg>me)=0;

    'vigilias nuevas'
	dbg_reglas(h1);

    %umbral no_vigilias 	
    umbral_resto=median(fmda(h1==-1));
    sd_umbral_resto=mad(fmda(h1==-1));


    'regla norem'
	dbg_reglas(h1);
    
    %marcamos 3 (posible rem) si no_vigilia y emg=muy bajito o si no_vigilia, emg=bajito y umbral resto-0.1sd < umbral < umbral vigilia-0.1sd]
    h1(  h1==-1 & emg   < (me - 0.0 * de)) =3;
    h1(  h1==-1 & emg   < (me - 0.1 * de) ...
                & fmda' < (umbral_vig-0.1*sd_umbral_vig) ...
                & fmda' > umbral_resto-0.1*sd_umbral_resto) =3;

            
	dbg_reglas(h1);
    
     
    %leemos hipocampo
    w1h=w1h(:);
    
    w1h=w1h(1:fm*60*60*horas);
    w1h(isnan(w1h))=max(w1h);
    [Sh,fh]=sig2espectro(w1h,lepoca,1,fm);

    %fmd[1-10] de hipocampo
    fmdh=esp2fmd(Sh,fh,[1 10]);
    umbral_rem=mean(fmdh(h1==3));
    sd_umbral_rem=std(fmdh(h1==3));
    w1h=0;

    %marcamos rem si (no_vigilia o posible rem) y fmd_hc > 1.5sd umbralrem y emg<0.6sd
    h1((h1==-1 | h1==3) & fmdh' > umbral_rem+1.0*sd_umbral_rem & emg < (me-0.1*de))=2;
    %los "rem" pasan a no_vigilia
    h1(h1==3)=-1;   

    %marcamos 1 (posible nrem) si no_vigilia y fmd < fmd vigilia
    h1(  h1==-1 &  fmda' < umbral_vig-0.05*sd_umbral_vig ) =1;

    umbral_vig=median(fmda(h1==0));
    sd_umbral_vig=mad(fmda(h1==0));
 %    h1(h1==-1 & emg<me -0.1*de & fmda' < (umbral_vig-1.0*sd_umbral_vig)) =1;
 %    h1(h1==-1 & fmda' > (umbral_vig+0.5*sd_umbral_vig)) =0;
%    h1(h1==-1 & delta > (md - p2 * dd)  & emg < (me-0.2*de))=1;
    'regla norem'
    h1(h1==-1 & fmda' < (umbral_vig-0.0*sd_umbral_vig))    =1;
    umbral_vig=median(fmda(h1==1));
    sd_umbral_vig=mad(fmda(h1==1));

	dbg_reglas(h1);

     h1(h1==-1 & emg>me -0.5*de & fmda' > (umbral_vig+0.2*sd_umbral_vig)) =0;


  regla_rem=0;
  regla_vig=0;
  regla_nrem=0;
   for ii=2:length(h1)-1
        if(h1(ii)==-1 & (h1(ii-1)==2 & h1(ii+1)==2))
           h1(ii)=2; regla_rem=regla_rem+1;
       end
      if(h1(ii)==-1 & (1+h1(ii-1)==1) & (1+h1(ii+1)==1 ))
           h1(ii)=0; regla_vig=regla_vig+1;
       end
      if(h1(ii)==-1 & (h1(ii-1)==1)  & (h1(ii+1)==1))
           h1(ii)=1; regla_nrem=regla_nrem+1;
       end
    end   
	dbg_reglas(h1);
 
    h1(h1==-2)=0;
%    h1(h1==-1 ) =1;
  
    
end

function dbg_reglas(h1)
   fprintf('aqui, van: %d sinclasif, %d artefs, %d vigilias, %d nrems, %d rems, %d posibles rem, de todos %d\n',...
             sum(h1==-1),sum(h1==-2), sum(h1==0),sum(h1==1),sum(h1==2),sum(h1==3),length(h1));
end


