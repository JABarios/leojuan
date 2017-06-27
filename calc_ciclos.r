library('lattice')
library('plyr')
library('reshape2')
library('markovchain')




longitud_epoca=5;


r <- read.table("wt_estadios_escalas_emg5590.csv",header=T,dec=',')
r <- r[r$escala==15,]
r[r$est==0 & r$dur > 150,]$est=3
r$est <- factor(r$est,levels=c(3,2,1,0),labels=c("LONW","REM","SWS","Wake"))
r$luz <- factor(r$luz,levels=c('LUZ','OSCURIDAD'),labels=c("light","dark"))
r$dur <- as.numeric(r$dur)


#r <- r[r$luz=="light",]
cambios <- r[(diff(r$luz=='light')==1),]
cambios <- cambios[c(-3,-6),]
cambios[5,]$t <- 1
for(ii in unique(cambios$cod)){
  r[r$cod==ii,]$t<-r[r$cod==ii,]$t-cambios[cambios$cod==ii,]$t
}

#r<-r[r$luz=='light' & r$t>0,]



