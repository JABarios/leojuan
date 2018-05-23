library(survival)

r <- read.table("ko_estadios_escalas_emg5590.csv",header=T,dec=',')
r <- r[r$escala==31,]
r[r$est==0 & r$dur > 150,]$est=3

r$est <- factor(r$est,levels=c(3,2,1,0),labels=c("LONW","REM","SWS","Wake"))
r$luz <- factor(r$luz,levels=c('LUZ','OSCURIDAD'),labels=c("light","dark"))
r$dur <- as.numeric(r$dur)

rr <- r
#stop('fin')
fit1sws <- survfit(Surv(rr[rr$est=='SWS',]$dur,rr[rr$est=='SWS',]$dur*0+1) ~ rr[rr$est=='SWS',]$luz)
fit1rem <- survfit(Surv(rr[rr$est=='REM',]$dur,rr[rr$est=='REM',]$dur*0+1) ~ rr[rr$est=='REM',]$luz)
fit1wkb <- survfit(Surv(rr[rr$est=='Wake',]$dur,rr[rr$est=='Wake',]$dur*0+1) ~ rr[rr$est=='Wake',]$luz)
fit1wkl <- survfit(Surv(rr[rr$est=='LONW',]$dur,rr[rr$est=='LONW',]$dur*0+1) ~ rr[rr$est=='LONW',]$luz)

pdf('f_ko_kp_sleep_4.pdf')
plot(fit1wkl,log="xy",col="black",main="K-M curve of sleep stages duration (KO) \n ---=activo",lty=c(1,4),xlim=c(20,10000))
legend(2000,0.9,c("WKB","WKL","SWS","REM"),col=c("blue","black","red","green"),lty=c(1,1,1,1))
lines(fit1sws,log="xy",col="red",lty=c(1,4))
lines(fit1rem,log="xy",col="green",lty=c(1,4))
lines(fit1wkb,log="xy",col="blue",lty=c(1,4))

dev.off()

