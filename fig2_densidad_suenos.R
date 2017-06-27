library(lattice)
library(latticeExtra)


rr <- read.table('wt_estadios_escalas_emg5590.csv',header=T)
rr <-rr[rr$escala==38,]

rr$est <- factor(rr$est,levels=c(0,1,2),labels=c("WK","SWS","REM"))
my.settings <- list(
  par.main.text = list(font = 2, # make it bold
                       just = "left", 
                       x = grid::unit(5, "mm")),
  par.sub.text = list(font = 1, 
                      just = "left", 
                      x = grid::unit(5, "mm"))
  )

g1 <- densityplot(~log(dur) ,data=rr[rr$luz=='LUZ',], groups=est, type=c('density',"g"), lty=1,xlim=c(3,10),auto.key=T,main="sleep stage duration", xlab="time (log s)",ylim=c(-0.05,1.5),col=c("black","red","green") )+
as.layer( g2 <- densityplot(~log(dur) ,data=rr[rr$luz=='OSCURIDAD',], groups=est,type=c('density',"g"), lty=4, xlim=c(3,9),col=c("black","red","green") ))




print(g1)

pdf("densidad_estadios.pdf")
print(g1)
dev.off()


