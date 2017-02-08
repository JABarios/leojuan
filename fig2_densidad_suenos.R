library(lattice)
library(latticeExtra)


rr <- read.table('wt_estadios.csv',header=T)

rr$est <- factor(rr$est,levels=c(0,1,2),labels=c("WK","SWS","REM"))
my.settings <- list(
  par.main.text = list(font = 2, # make it bold
                       just = "left", 
                       x = grid::unit(5, "mm")),
  par.sub.text = list(font = 1, 
                      just = "left", 
                      x = grid::unit(5, "mm"))
  )

g1 <- densityplot(~log(dur) ,data=rr[rr$luz=='LUZ',], groups=est, type=c('density',"g"), lty=4,log="xy",xlim=c(3,9),auto.key=T,main="sleep stage duration", xlab="time(log s)",ylim=c(-0.05,0.7) )+
as.layer( g2 <- densityplot(~log(dur) ,data=rr[rr$luz=='OSCURIDAD',], groups=est,type=c('density',"g"), log="xy",xlim=c(3,9) ))
rr <- read.table('wt_estadios.csv',header=T)
rr <- rr[rr$luz=='OSCURIDAD',]




print(g1)

#pdf("densidad_estadios.pdf")
#print(g2+g1)
#dev.off()


