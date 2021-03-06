library(survival)
rr <- read.table('wt_estadios.csv',header=T)
fit1rem <- survfit(Surv(rr[rr$est==2,]$dur,rr[rr$est==2,]$dur*0+1) ~ rr[rr$est==2,]$luz)
fit1sws <- survfit(Surv(rr[rr$est==1,]$dur,rr[rr$est==1,]$dur*0+1) ~ rr[rr$est==1,]$luz)
fit1wk <- survfit(Surv(rr[rr$est==0,]$dur,rr[rr$est==0,]$dur*0+1) ~ rr[rr$est==0,]$luz)
pdf('f_kp_sleep.pdf')
plot(fit1wk,log="xy",col="blue",main="K-M curve of sleep stages duration",lty=c(1,4))
legend(1000,0.8,c("WK","SWS","REM"),col=c("blue","red","green"),lty=c(1,1,1))
lines(fit1sws,log="xy",col="red",lty=c(1,4))
lines(fit1rem,log="xy",col="green",lty=c(1,4))
dev.off()

