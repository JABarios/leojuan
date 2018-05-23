library('lattice')
library('plyr')
library('reshape2')
library('markovchain')




longitud_epoca=5;


simbolos <- function(estadio,duracion,tiempo) {
	 n_est= round(duracion/tiempo)
	 s <- (paste0(rep(estadio, n_est),sep=""))
     return(s)
}

f <- function(x, output) {
     secuencia <-simbolos(x[[4]],as.numeric(x[[3]]),longitud_epoca)
	 vc <<- c(vc,secuencia)
}

calc_markov <- function(genotipo,MATR) {
	rr <- subset(r,r$GEN==genotipo)
	ratones <- unique(rr$cod)
	contador=1
	for ( i in ratones ){
		vc <- vector()
		vc <- apply(subset(r,r$cod==i), 1, f)
		mcfit <- markovchainFit(data=vc,confidencelevel = .95)
		print(mcfit$estimate)
		MATR[[contador]]=mcfit$estimate
		contador=contador+1
	}
	return(MATR)
}


nescala=35

r <- read.table("ko_estadios_escalas_emg5590.csv",header=T,dec=',')
r <- r[r$escala==nescala,]
r$GEN <- factor(r$GEN,levels=c('WT','KO'),labels=c("WT","KO"))
r[r$luz=='OSCURIDAD',]$GEN='WT'
#r <- subset(r, select = -c(t) )
r[r$est==0 & r$dur > 150,]$est=3
r$est <- factor(r$est,levels=c(3,2,1,0),labels=c("LONW","REM","SWS","Wake"))
r$luz <- factor(r$luz,levels=c('LUZ','OSCURIDAD'),labels=c("light","dark"))
r$cod <- paste0(r$GEN,r$cod)
r$dur <- as.numeric(r$dur)
#stop("fin");

#r <- r[!is.na(r$luz),]  # quita el WT 15, no tiene apuntada la luz
#r <- r[!(r$cod=='WT1'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='WT2'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='WT3'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='WT10'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='WT12'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='WT13'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='KO6'),] # quita el WT 5, es un outlier clarisimo
r <- r[!(r$cod=='KO12'),] # quita el WT 5, es un outlier clarisimo
r <- r[!(r$cod=='WT12'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='KO12'),] # quita el WT 5, es un outlier clarisimo



prem=matrix(data = NA, nrow = 2, ncol = 16, byrow = FALSE, dimnames = NULL)
pnrem=matrix(data = NA, nrow = 2, ncol = 16, byrow = FALSE, dimnames = NULL)
pwake=matrix(data = NA, nrow = 2, ncol = 16, byrow = FALSE, dimnames = NULL)
plwake=matrix(data = NA, nrow = 2, ncol = 16, byrow = FALSE, dimnames = NULL)

pmat=matrix(data = NA, nrow = 16, ncol = 18, byrow = FALSE, dimnames = NULL)



genotipos=list('WT','KO')	
MWTKO=list()
contador2=1
  for(vgen in genotipos){
	rr <- subset(r,r$GEN==vgen)
	ratones <- unique(rr$cod)
	contador=1
	MATR=list()

	for ( i in ratones ){
		vc <- vector()
                print(i)
# esto es el truco mas sucio que he visto en mi vida, alucino si realmente es mio
# f es una funcion!! y como efecto colateral, modifica vc
		apply(subset(rr,rr$cod==i), 1, f)  
		mcfit <- markovchainFit(data=vc,confidencelevel = .95)
		print(mcfit$estimate)
		v1=attr(mcfit$estimate,"transitionMatrix")
     		prem[contador2,contador]=v1[2,2]
		pnrem[contador2,contador]=v1[3,3]
		pwake[contador2,contador]=v1[4,4]
		plwake[contador2,contador]=v1[1,1]
		pmat[,contador+(contador2-1)*9]=as.vector(v1)
		MATR[[contador]]=v1
		contador=contador+1
	}
    MWTKO[[contador2]]=MATR	
	contador2=contador2+1
	
}	

#stop("fin")

n_ratones=7;
 a=MWTKO[[1]][[1]]*0;
 
 for(i in 1:n_ratones){
    a=a+MWTKO[[1]][[i]]	
 }
 mk_wt=a/n_ratones
 
b=MWTKO[[1]][[1]]*0;
 
 for(i in 1:n_ratones){
    b=b+MWTKO[[2]][[i]]	
 }
  mk_ko=b/n_ratones
 
#print("matrix probability transition WT")
print(mk_wt)
#print("matrix probability transition Cx36 KO")
print(mk_ko)

pmat <- t(pmat) 

#stop('ya')
r <- r[!(r$cod=='WT2'),] # quita el WT 5, es un outlier clarisimo
pmat <- data.frame(pmat[,1],pmat[,2],pmat[,3],pmat[,4],pmat[,5],pmat[,6],pmat[,7],pmat[,8],pmat[,9],pmat[,10],pmat[,11],pmat[,12],pmat[,13],pmat[,14],pmat[,15],pmat[,16])
pmat$gen <- c(rep('wt',9),rep('ko',9))
pmat$cod <- c('wt01','wt02','wt03','wt04','wt05','wt06','wt07','wt08','wt09','ko01','ko02','ko03','ko04','ko05','ko06','ko07','ko08','ko09')
names(pmat)[1] <- "LL"
names(pmat)[5] <- "LR"
names(pmat)[9] <- "LS"
names(pmat)[13] <- "LW"
names(pmat)[2] <- "RL"
names(pmat)[6] <- "RR"
names(pmat)[10] <- "RS"
names(pmat)[14] <- "RW"
names(pmat)[3] <- "SL"
names(pmat)[7] <- "SR"
names(pmat)[11] <- "SS"
names(pmat)[15] <- "SW"
names(pmat)[4] <- "WL"
names(pmat)[8] <- "WR"
names(pmat)[12] <- "WS"
names(pmat)[16] <- "WW"




melted <- melt(pmat, id.vars=c("cod","gen"))
aa  <- ddply(melted, c("gen","variable"), summarise,value = mean(value,na.rm=T), sd = sd(value,na.rm=T),periodos=length(value))
aa1<- dcast(aa,variable ~ gen, mean)
aa1 <- mutate(aa1,Diff=aa1$ko-aa1$wt)
tabla1 <- ddply(melted, .(variable), summarise,sem=sd(value,na.rm=T)/3, p_value=t.test( value ~ gen)$p.value,paired=T)
tabla1 <- merge(aa1,tabla1)
print (tabla1)


y1 <- bwplot(value~gen|variable,
  data=melted,
  layout=c(4,4), main="transition probability in sleep stages\ncx36 KO mice, light vs dark")

print(y1)


# y ahora, el report
sink("reporte_markov_ko.txt")
print("matrix probability transition DARK")
print(mk_wt)
print("matrix probability transition LIGHT")
print(mk_ko)

print("Tabla estadistica")
print (tabla1)
sink();
 
png(filename="markov_probs.png", 
    type="cairo",
    units="in", 
    width=5, 
    height=4, 
    pointsize=12, 
    res=96)
print(y1)
dev.off()

