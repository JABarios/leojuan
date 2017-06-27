source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
grid()
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')

source('fig2_densidad_suenos.R')
rr
names(rr)
rr$GEN
rr$luz
library(survival)
stime <- rr$dur
status <- rr$dur*0+1
status
fit1 <- survfit(Surv(stime,sstatus))
fit1 <- survfit(Surv(stime,status))
fit1 <- survfit(Surv(stime,status))
fit1 <- survfit(Surv(stime,status) ~ rr$estado)
fit1 <- survfit(Surv(stime,status) ~ rr$est)
plot(fit1)
fit1 <- survfit(Surv(stime[rr$est==0,],status[rr$est==0,]) ~ rr$est)
names(rr)
length(stime)
length(rr)
fit1 <- survfit(Surv(rr[rr$est==0,]$dur,rr[rr$est==0,]$dur*0+1) ~ rr$est)
fit1 <- survfit(Surv(rr[rr$est==0,]$dur,rr[rr$est==0,]$dur*0+1) ~ rr$luz)
fit1 <- survfit(Surv(rr[rr$est==0,]$dur,rr[rr$est==0,]$dur*0+1) ~ rr[rr$est==0,]$luz)
plot(fit1)
rr4luz
rr$luz
rr <- read.table('wt_estadios.csv',header=T)
names(rr)
fit1 <- survfit(Surv(rr[rr$est==0,]$dur,rr[rr$est==0,]$dur*0+1) ~ rr[rr$est==0,]$luz)
plot(fit1)
fit1 <- survfit(Surv(rr[rr$est==1,]$dur,rr[rr$est==1,]$dur*0+1) ~ rr[rr$est==1,]$luz)
plot(fit1)
fit1 <- survfit(Surv(rr[rr$est==2,]$dur,rr[rr$est==2,]$dur*0+1) ~ rr[rr$est==2,]$luz)
plot(fit1)
fit1rem <- survfit(Surv(rr[rr$est==2,]$dur,rr[rr$est==2,]$dur*0+1) ~ rr[rr$est==2,]$luz)
fit1sws <- survfit(Surv(rr[rr$est==1,]$dur,rr[rr$est==1,]$dur*0+1) ~ rr[rr$est==1,]$luz)
fit1wk <- survfit(Surv(rr[rr$est==0,]$dur,rr[rr$est==0,]$dur*0+1) ~ rr[rr$est==0,]$luz)
plot(fit1sws)
lines(fit1wk)
lines(fit1rem)
lines(fit1rem,col="red")
lines(fit1rem,col="green")
lines(fit1sws,col="red",)
plot(fit1sws)
plot(fit1sws,log="xy")
plot(fit1sws,log="x")
plot(fit1sws)
plot(fit1sws,log="x")
plot(fit1sws,log="xy")
plot(fit1wk,log="xy")
lines(fit1sws,log="xy")
lines(fit1sws,log="xy",col="red")
lines(fit1rem,log="xy",col="green")
lines(fit1rem,log="xy",col="green",main="Survival curve of sleep stages")
plot(fit1rem,log="xy",col="green",main="Survival curve of sleep stages")
plot(fit1wk,log="xy",col="blue",main="Survival curve of sleep stages")
plot(fit1wk,log="xy",col="blue",main="Survival curve of sleep stages",xlab="time")
plot(fit1wk,log="xy",col="blue",main="K-M curve of sleep stages")
plot(fit1wk,log="xy",col="blue",main="K-M curve of sleep stages",key=c("1"))
legend(2000,0.6,"aqui")
legend(2000,0.6,"a")egend(2000,9.5, # places a legend at the appropriate place c(“Health”,”Defense”), # puts text in the legend
lty=c(1,1), # gives the legend appropriate symbols (lines)
legend(2000,0.6,c("WK","SWS","REM"),col=c("blue","red","green"))
plot(fit1wk,log="xy",col="blue",main="K-M curve of sleep stages",key=c("1"))
legend(2000,0.6,c("WK","SWS","REM"),col=c("blue","red","green"))
legend(2000,0.6,c("WK","SWS","REM"),col=c("blue","red","green"),lty=c(1,1,1))
plot(fit1wk,log="xy",col="blue",main="K-M curve of sleep stages",key=c("1"))
legend(2000,0.6,c("WK","SWS","REM"),col=c("blue","red","green"),lty=c(1,1,1))
legend(1000,0.6,c("WK","SWS","REM"),col=c("blue","red","green"),lty=c(1,1,1))
plot(fit1wk,log="xy",col="blue",main="K-M curve of sleep stages",key=c("1"))
legend(1000,0.6,c("WK","SWS","REM"),col=c("blue","red","green"),lty=c(1,1,1))
legend(1000,0.7,c("WK","SWS","REM"),col=c("blue","red","green"),lty=c(1,1,1))
legend(1000,0.8,c("WK","SWS","REM"),col=c("blue","red","green"),lty=c(1,1,1))
plot(fit1wk,log="xy",col="blue",main="K-M curve of sleep stages",key=c("1"))
legend(1000,0.8,c("WK","SWS","REM"),col=c("blue","red","green"),lty=c(1,1,1))
lines(fit1sws,log="xy",col="red",main="K-M curve of sleep stages",key=c("1"))
lines(fit1rem,log="xy",col="green",main="K-M curve of sleep stages",key=c("1"))
plot(fit1wk,log="xy",col="blue",main="K-M curve of sleep stages",key=c("1"),lty=c(1,4))
plot(fit1wk,log="xy",col="blue",main="K-M curve of sleep stages duration",key=c("1"),lty=c(1,4))
savehistory('fig_km_sueno.R')
source('fig_km_sueno.R')
source('fig_km_sueno.R')
source('fig_km_sueno.R')
source('fig_km_sueno.R')
source('proc_calcmarkov_4.r')
source('fig2_densidad_suenos.R')
source('fig2_densidad_suenos.R')
rr
rr <- read.table('wt_estadios.csv',header=T)
rr
rro <- rr[rr$luz=='LUZ',]
rro
rror <- rro[rro$est==2,]
rror
cor.test(rror$dur,rror$ind)
names(rror)
cor.test(rror$dur,rror$t)
rror <- rro[rro$est==1,]
cor.test(rror$dur,rror$t)
rror <- rro[rro$est==0,]
cor.test(rror$dur,rror$t)
rro <- rr[rr$luz=='OSCURIDAD',]
rror <- rro[rro$est==0,]
cor.test(rror$dur,rror$t)
rror <- rro[rro$est==1,]
cor.test(rror$dur,rror$t)
rro <- rr[rr$luz=='LUZ',]
rror <- rro[rro$est==1,]
cor.test(rror$dur,rror$t)
rr
rr[rr$t==0,]$luz
rr[rr$t==0,]
diff
diff(rr$t)
rr[rr$t==0,]
diff(rr$luz)

diff(rr$luz=='LUZ')
find(diff(rr$luz=='LUZ'))
find(diff(rr$luz=='LUZ')==-1)
(diff(rr$luz=='LUZ')==-1)
rr[(diff(rr$luz=='LUZ')==-1)]
rr[(diff(rr$luz=='LUZ')==-1),]
rr[(diff(rr$luz=='LUZ')==1),]
rr[(diff(rr$luz=='LUZ')==1)+1,]
rr[(diff(rr$luz=='LUZ')==1),]
rr[rr$t==0,]
rr[3210]
rr[3210,]
rr[2716,]
rr[(diff(rr$luz=='LUZ')==1),]
rr[rr$t==0,]
rr[(diff(rr$luz=='LUZ')==1),]
83220-23520
85695-7195
rr <- read.table('wt_estadios_escalas_emg5590.csv',header=T)
rr <- rr[rr$escalas==35,]
rr
names(rr)
rr <- read.table('wt_estadios_escalas_emg5590.csv',header=T)
rr <- rr[rr$escala==35,]
rr
rro <- rr[rr$luz=='OSCURIDAD',]
rror <- rro[rro$est==1,]
cor.test(rror$dur,rror$t)
rro <- rr[rr$luz=='LUZ',]
rror <- rro[rro$est==1,]
cor.test(rror$dur,rror$t)
rro <- rr[rr$luz=='LUZ',]
rror <- rro[rro$est==1,]
cor.test(rror$dur,rror$t)
rr
rror
plot(rror$dur,rror$t)
plot(rror$t,rror$dur)
rro <- rr[rr$luz=='OSCURIDAD',]
rror <- rro[rro$est==1,]
plot(rror$t,rror$dur)
rr <- read.table('wt_estadios_escalas_emg5590.csv',header=T)
rr <- rr[rr$escala==35,]
rr
plot(rr$t)
plot(rr$luz)
plot(rr$t,rr$luz)

with(rr[rr$cod==2,plot(t,luz))
with(rr[rr$cod==2,],plot(t,luz))
with(rr[rr$cod==3,],plot(t,luz))
with(rr[rr$cod==6,],plot(t,luz))
rr
rr[rr$cod==6,]
with(rr[rr$cod==6,],plot(t,luz))
rr[rr$cod==6,]
rr[rr$cod==7,]
with(rr[rr$cod==7,],plot(t,luz))
with(rr[rr$cod==8,],plot(t,luz))
with(rr[rr$cod==9,],plot(t,luz))
with(rr[rr$cod==10,],plot(t,luz))
with(rr[rr$cod==11,],plot(t,luz))
with(rr[rr$cod==12,],plot(t,luz))
with(rr[rr$cod==13,],plot(t,luz))
with(rr[rr$cod==1,],plot(t,luz))
with(rr[rr$cod==2,],plot(t,luz))
with(rr[rr$cod==3,],plot(t,luz))
with(rr[rr$cod==4,],plot(t,luz))
with(rr[rr$cod==5,],plot(t,luz))
with(rr[rr$cod==6,],plot(t,luz))
with(rr[rr$cod==7,],plot(t,luz))
with(rr[rr$cod==1,],plot(t,luz))
with(rr[rr$cod==2,],plot(t,luz))
with(rr[rr$cod==2,],plot(t,luz))
source('proc_calcmarkov_4.r')
with(r[r$cod==2,],plot(t,luz))
names(r)
source('proc_calcmarkov_4.r')
with(r[r$cod==2,],plot(t,luz))
r
names(r)
r$t
with(r[r$cod==2,],plot(t,luz))
r$cod
with(r[r$cod=="WT02",],plot(t,luz))
r$cod
r
r
r[r$cod=="WT02",]
r[r$cod=="WT2",]
rr <- read.table('wt_estadios_escalas_emg5590.csv',header=T)
rr <- rr[rr$escala==35,]
with(rr[rr$cod==2,],plot(t,luz))
with(rr[rr$cod==3,],plot(t,luz))
r[r$cod=="WT3",]
source('proc_calcmarkov_4.r')
rr <- read.table('wt_estadios_escalas_emg5590.csv',header=T)
rr <- rr[rr$escala==15,]
rro <- rr[rr$luz=='LUZ',]
rror <- rro[rro$est==1,]
cor.test(rror$dur,rror$t)
rror <- rro[rro$est==2,]
cor.test(rror$dur,rror$t)
rror <- rro[rro$est==0,]
cor.test(rror$dur,rror$t)
rror <- rro[rro$est==3,]
cor.test(rror$dur,rror$t)
rr[(diff(rr$luz=='LUZ')==1),]
source('calc_ciclos.r')
r
source('calc_ciclos.r')
cambios
r$luz
r$luz=='light'
(r$luz=='light')
(r$luz=='light')==1
source('calc_ciclos.r')
cambios
cambios$t
r[10713,]
r
r[10714,]
r[222841,]
r[222841]
r[222841,]
names(r)
with(rr[rr$cod==10,],plot(t,luz))
with(rr[rr$cod==2,],plot(t,luz))
with(r[r$cod==2,],plot(t,luz))
rror <- rro[rro$est==1,]
cambios
with(r[r$cod==7,],plot(t,luz))
with(r[r$cod==3,],plot(t,luz))
with(r[r$cod==5,],plot(t,luz))
with(r[r$cod==7,],plot(t,luz))
with(r[r$cod==2,],plot(t,luz))
source('calc_ciclos.r')
cambios
source('calc_ciclos.r')
cambios
cambios[2]
source('calc_ciclos.r')
cambios
cambios[2,]
cambios[0,]
cambios[1,]
source('calc_ciclos.r')
cambios
source('calc_ciclos.r')
cambios
source('calc_ciclos.r')
source('calc_ciclos.r')
source('calc_ciclos.r')
source('calc_ciclos.r')
r
source('calc_ciclos.r')
r

cor.test(r$dur,r$t)
rror <- r[r$est==1,]
cor.test(r$dur,r$t)
cor.test(rror$dur,rror$t)
rror
r$est
rror <- r[r$est==SWS,]
rror <- r[r$est=='SWS',]
cor.test(rror$dur,rror$t)
rror <- r[r$est=='SWS' & r$luz=='light',]
cor.test(rror$dur,rror$t)
rror
BB
with(r[r$cod==3,],plot(t,luz))
cambios
with(r[r$cod==1,],plot(t,luz))
with(r[r$cod==6,],plot(t,luz))
with(r[r$cod==1,],plot(t,luz))
r
r[r$cod==1,]
source('calc_ciclos.r')
r
with(r[r$cod==1,],plot(t,luz))
with(r[r$cod==1,],plot(t,dur))
with(r[r$cod==2,],plot(t,dur))
with(r[r$cod==3,],plot(t,dur))
with(r[r$cod==4,],plot(t,dur))
with(r[r$cod==5,],plot(t,dur))
with(r[r$est==SWS,],plot(t,dur))
with(r[r$est=='SWS',],plot(t,dur))
cor.test(rror$dur,rror$t)
rror <- r[r$est=='SWS',]
cor.test(rror$dur,rror$t)
rror <- r[r$est=='LONW',]
cor.test(rror$dur,rror$t)
source('calc_ciclos.r')
rror <- r[r$est=='SWS',]
cor.test(rror$dur,rror$t)
rr
cor.test(rr$dur,rr$t)
rror <- rr[rr$est==1,]
cor.test(rr$dur,rr$t)
rror <- rr[rr$est==1 & rr$luz=='LUZ',]
cor.test(rr$dur,rr$t)
savehistory('estoes.R')
