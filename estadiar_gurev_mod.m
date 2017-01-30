function estadiaje=estadiar_gurev_mod(ch_cx,ch_hc,ch_mg,fm,lepoca)


lepoca=5;
horas=24;
%calcular bandas
%emg
        ch_mg=ch_mg(:);
        ch_mg=ch_mg(1:fm*60*60*horas);
        ch_mg=reshape(ch_mg,fm*lepoca,[]);

       [Sh,fh]=sig2espectro(ch_mg,lepoca,1,fm);
       ch_mg=0; 
       [xx,pmg,xx]=esp2fmd(Sh,fh,[10 100]);
       
%cx
       ch_cx=ch_cx(:);
       ch_cx=ch_cx(1:fm*60*60*horas);
       ch_cx=reshape(ch_cx,fm*lepoca,[]);
       [Sh,fh]=sig2espectro(ch_cx,lepoca,1,fm);
       ch_cx=0;  
       [ff,sigma,sh]=esp2fmd(ch_cx,ss.frec,[10 14]);
%hc 
       ch_hc=ch_hc(:);
       ch_hc=ch_hc(1:fm*60*60*horas);
       ch_hc=reshape(ch_hc,fm*lepoca,[]);
       [Sh,fh]=sig2espectro(ch_hc,lepoca,1,fm);
       ch_hc=0; 
       [xx,alfa,xx]=esp2fmd(Sh,fh,[10 16]);
       [xx,theta,xx]=esp2fmd(Sh,fh,[7 9]);
       [xx,gamma,xx]=esp2fmd(Sh,fh,[30 80]);
       [xx,delta,xx]=esp2fmd(Sh,fh,[1 4]);
       [ff,xx,sh]=esp2fmd(Sh,fh,[1 11]);
       ch_hc=0;       
       
        ag=smooth(alfa./gamma,3)';
        td=smooth(theta./delta,3)';
        pmg=smooth(pmg,3)';
        vig=smooth(sigma.*theta,3)';
        
        
        condicion_nrem = ag > median(ag)*1.00 & pmg < median(pmg)*1.0;
        condicion_rem  = td > mean(td) + 1.25*std(td) & pmg < median(pmg)*1.0;
        condicion_wk   = pmg >= median(pmg)*3 ;
        condicion_res  = not(condicion_nrem | condicion_rem | condicion_wk );
        
        
        
        estadiaje=zeros(1,length(ff));
        estadiaje(condicion_rem)=3;
        estadiaje(condicion_res)=1;
        estadiaje(condicion_nrem)=2;        
        estadiaje(condicion_wk)=0;
        
        
        u_emg=mean(pmg(condicion_rem | condicion_nrem));
        sd_emg=std(pmg(condicion_rem | condicion_nrem));
        

        for ii=1:length(estadiaje)
		 if (pmg(ii)>u_emg+2*sd_emg)
		    estadiaje(ii)=0;
		    continue;
		 end
        end
        
        
        
        u_vig = mean(vig(estadiaje==0));
        sd_vig= std(vig(estadiaje==0));
        
        
        for ii=1:length(estadiaje)
		 if (vig(ii)<u_vig)
		    estadiaje(ii)=0;
		    continue;
		 end
        end
        
        u_ag = mean(ag(estadiaje==0));
        sd_ag= std(ag(estadiaje==0));
     

        
	   for ii=1:length(estadiaje)
		 if (ag(ii)<u_ag-2*sd_ag)
		    estadiaje(ii)=2;
		    continue;
		 end
       end
       
       
        u_td = mean(td(estadiaje==0 | estadiaje==3));
        sd_td= std(td(estadiaje==0 | estadiaje==3));

	   for ii=1:length(estadiaje)
		 if (td(ii)>u_td-0*sd_td && pmg(ii) < u_emg+0*sd_emg )
		    estadiaje(ii)=3;
		    continue;
		 end
       end
       
        u_vig = mean(vig(estadiaje==0));
        sd_vig= std(vig(estadiaje==0));
       
       
       
        for ii=2:length(estadiaje)-1
           if (estadiaje(ii)==1)

               if(estadiaje(ii-1)==2 || estadiaje(ii+1)==2 && ag(ii)>prctile(ag(condicion_nrem),25) )
                   estadiaje(ii)=2;
                   continue;
               end    
               if(estadiaje(ii-1)==3 || estadiaje(ii+1)==3 && td(ii)>mean(td) )
                   estadiaje(ii)=3;
                   continue;
               end    
               if(estadiaje(ii-1)==0 || estadiaje(ii+1)==0 && (td(ii)>mean(td) || vig(ii)<u_vig) )
                   estadiaje(ii)=0;
                   continue;
               end   
           end    
        end    
        
	 for ii=2:length(estadiaje)
           if (estadiaje(ii)==3)
               if(estadiaje(ii-1)==0) 
              %     estadiaje(ii)=0;
                   continue;
               end    
           end    
       end    

       %estadiaje=medfilt1(estadiaje,3);
        
end
