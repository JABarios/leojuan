library(lattice)
library(latticeExtra)


rr <- read.table('wt_estadios.csv',header=T)
rr <- rr[rr$luz=='LUZ',]

my.settings <- list(
  par.main.text = list(font = 2, # make it bold
                       just = "left", 
                       x = grid::unit(5, "mm")),
  par.sub.text = list(font = 1, 
                      just = "left", 
                      x = grid::unit(5, "mm"))
  )

g1 <- densityplot(log(rr[rr$estadio==2,]$dur) ,type='density',xlim=c(1,9),col='green' )+
      as.layer(densityplot(log(rr[rr$est==1,]$dur) ,type='density',xlim=c(1,9),col='red' ))+
      as.layer(densityplot(log(rr[rr$est==0,]$dur) ,type='density',xlim=c(1,9),col='black'))

rr <- read.table('wt_estadios.csv',header=T)
rr <- rr[rr$luz=='OSCURIDAD',]

g2 <- densityplot(log(rr[rr$est==2,]$dur) ,type='density',xlim=c(3,9),col='green', lty=c(4,6), xlab='time (log s)',
      key=list(corner=c(1,1),lines=list(col=c("red","green","black","white","gray","gray"), lty=c(1,1,1,0,4,1), lwd=1),text=list(c("NREM"," REM", "wake", "","dark","light"))),
      main="Stage duration")+
      as.layer(densityplot(log(rr[rr$est==1,]$dur) ,type='density',xlim=c(3,9),col='red', lty=c(4,6) ))+
      as.layer(densityplot(log(rr[rr$est==0,]$dur) ,type='density',xlim=c(3,9),col='black', lty=c(4,6), xlab='duration (log s)' ))



print(g2+g1)

pdf("densidad_estadios.pdf")
print(g2+g1)
dev.off()


