% programa que hace ...
%

%calculando las figuras


dibujando=1;
num_figura=3;
ch_cx=1;
ch_hc=2;
ch_mg=3;
canal=1;
if opcion==1
  l1=0;l2=200;
  ly1=-12;ly2=-1;
end
if opcion==2
  l1=0;l2=40;
  ly1=-9;ly2=-1;
end

flanco=1; %1 ataque, 0 salida
        

fid = fopen('estadiando.txt','wt');
fprintf(fid,'%s\t%s\t%s\t%s\n','caso','gen','epoca','estadiaje');

canal_escogido=opciones_pt.canal;
nom_fig_prom=opciones_pt.nom_fig_prom;
nom_fig_raw=opciones_pt.nom_fig_raw;
fig_prom=opciones_pt.figuras(1);
fig_raw=opciones_pt.figuras(2);
titulo=opciones_pt.titulo;
flanco=opciones_pt.flanco;

figure(fig_prom)
clf
suptitle(titulo)
figure(fig_raw)
clf
suptitle(titulo)


colores={'b', 'r'};
nombres={'wt','ko'};
titulos={'WT','Cx36-KO'};

%figure(5);clf;
%figure(6);clf;

chusos{1}={ 'hswt01b4';
          'hswt02b4';
          'hswt03b2';
          'hswt04b5';
          'sswt01b';
          'sswt02b3';
          'sswt03b';
          'sswt04b';
          'sswt05b';
          'sswt06b2';
          'sswt07b3';
         % 'sswt08b'; % raro, creo que por fentanilo
          'sswt09b3';
          'sswt10b4';
          'sswt11b2';
          'sswt12b3';
          'sswt13b3';
};
      
chusos{2}={'hsko01b2';
        'hsko02b3';
        'hsko03b2';
        'hsko04b2';
        'ssko01b';
        'ssko02b';
        'ssko03b';
        'ssko04b';
        'ssko05b';
        'ssko06b';
        'ssko07b';
       'ssko08b';
        'ssko09b';
        'ssko10b';
        'ssko11b';
        'ssko12b';
        'ssko13b';
} ;       

situacion{1}=1:16;
situacion{2}=17:32;



if dibujando
 for jj=1:2
    for ii=1:6;promedios{ii}=[];end;
    ficheroswt=chusos{jj};
    color=colores{jj};
    situacionw=situacion{jj};
    genotipo=nombres{jj};
    
    for ii=1:length(ficheroswt);
        
        load([ '~/enlaces/lab7/fft/' ficheroswt{ii} '.fft.mat']);

        estadiaje=estadiar_gurev_mod(ss,1,2,3); %cx,hc,emg
        for fii=1:length(estadiaje)
            fprintf(fid,'%s\t%s\t%d\t%d\n',ficheroswt{ii},genotipo,fii,estadiaje(fii));    
        end
        
        %calculando limites rem
        
        posibles_rem=find(estadiaje==3);
        largos=[ diff(posibles_rem)>50]; % T si siguiente a mas de 50 epocas
        
        if flanco==1
          posibles_rem=posibles_rem([1==1 largos(1:end-1)]);  %T si siguiente a mas de 50 epocas
        else  
          posibles_rem=posibles_rem([largos(1:end)]);  %T si anterior a mas de 50 epocas
        end  
        puntos=posibles_rem(posibles_rem>300 & posibles_rem<length(estadiaje)-120);
        
        
        salida=[];
         for zz=1:length(puntos)
             probando=puntos(zz);
             if probando<60
                 continue
             end    
             previos=0;
             if flanco==1
               previos=sum(estadiaje(probando-60:probando)==2);
               previos=previos+sum(estadiaje(probando-60:probando)==1);
               if(previos>15)
                  salida=[salida probando];
               end    
             else
               previos=sum(estadiaje(probando-20:probando)==3);
               if(previos>8)
                  salida=[salida probando];
               end    
             end
             
         end    
         puntos=salida;
         
        if length(puntos)<5
            continue
        end    
        
             % aceptamos el punto si tiene mas de 15 epocas de sueño previas
             % y si tiene mas de 8 rems
             % y si son más o igual de 5 epocas
        
        
        bandas=[1.5 5;7.5 9;10 14;15 25;25 45;60 90];
        numbandas=6;
        
        notas{1}='delta 1.5-5 Hz';
        notas{2}='theta 7.5-9 Hz';
        notas{3}='sigma 10-14 Hz';
        notas{4}='beta 15-25 Hz';
        notas{5}='gamma 25-45 Hz';
        notas{6}='gamma 60-90 Hz';
        
        % con fines de control, mostrar como es el estadiaje de este sueño
            figure(7)
            clf;
            hold on;
            plot(estadiaje);ylim([-1 5]);
              for zz=1:length(puntos)
                  vline(puntos(zz))
                  ylim([-1 5]);
                  drawnow;
              end
        
        for fii=1:6
            figure(fig_raw);
            subplot(3,2,fii);
            hold on;
            f1=bandas(fii,1);
            f2=bandas(fii,2);
            %length(estadiaje)
            w1s=sto_senal(ss,canal_escogido,f1,f2);
            %fii
           
            trocito=[];
            for vii=1:length(puntos)
                interesan=puntos(vii)-60:puntos(vii)+60;
                %basalin=mean(w1s(puntos(vii)-240:puntos(vii)-120));
                inicio=max(puntos(vii)-1000,1);
                final=min(puntos(vii)+1000,length(w1s));
                puntos(vii);
                
                basalin=mean(w1s(inicio:final));
                
                
                
              %  antes=puntos(vii)-180:puntos(vii)-60;
                trocin=smooth(w1s(interesan),3)';
               % trocin_antes=smooth(w1s(antes),3)';
               % trocito(vii,:)=1+trocin-mean(trocin(1:120));
                trocito(vii,:)=trocin-basalin+1;
                
            end 
            
            senal=mean(trocito);
            tiempoeje=4*length(senal)/2/60;
            
            ejet=linspace(-tiempoeje,tiempoeje,length(senal));
            fichero=promedios{fii};
            fichero(ii,:)=senal;
            promedios{fii}=fichero;
            plot(ejet,senal,color);
            title(notas{fii});
            vline(0);
            xlim([-4 4]);
       %     ylim([-0.8 0.8]);
            drawnow;
            
           
        end
        
    end
    
    figure(fig_prom)
    for fii=1:6
      subplot(3,2,fii);
      hold on
      fichero=promedios{fii};
      plot(ejet,mean(fichero),color);
      title(notas{fii});
      vline(0);
      xlim([-4 4]);
      ylim([0 2]);
      if(fii>4)
          xlabel('time (min)');
      end    
            
    end
       
 end
 
hFig=figure(fig_prom);
set(hFig, 'Color', [1 1 1]); % backgroundcolor white
print(hFig, '-dpng', nom_fig_prom);

hFig=figure(fig_raw);
set(hFig, 'Color', [1 1 1]); % backgroundcolor white
print(hFig, '-dpng', nom_fig_raw);
 

fclose(fid);

end
 
