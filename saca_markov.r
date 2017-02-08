library('lattice')
library('plyr')
library('reshape2')
library('markovchain')


# source('saca_markov'), al acabar la matriz está en pmat

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



r <- read.table("wt_estadios_escalas_emg5590.csv",header=T,dec=',')
r <- r[r$escala==31,]
r$GEN <- factor(r$GEN,levels=c('WT','KO'),labels=c("WT","KO"))
r[r$luz=='OSCURIDAD',]$GEN='KO'
r <- subset(r, select = -c(t) )
r$est <- factor(r$est,levels=c(2,1,0),labels=c("REM","SWS","Wake"))
r$luz <- factor(r$luz,levels=c('LUZ','OSCURIDAD'),labels=c("light","dark"))
r$cod <- paste0(r$GEN,r$cod)
r$dur <- as.numeric(r$dur)
#stop("fin");

#r <- r[!is.na(r$luz),]  # quita el WT 15, no tiene apuntada la luz
#r <- r[!(r$cod=='WT5'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='WT10'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='WT12'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='WT13'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='KO6'),] # quita el WT 5, es un outlier clarisimo
r <- r[!(r$cod=='KO12'),] # quita el WT 5, es un outlier clarisimo
r <- r[!(r$cod=='WT12'),] # quita el WT 5, es un outlier clarisimo
#r <- r[!(r$cod=='KO12'),] # quita el WT 5, es un outlier clarisimo



prem=matrix(data = NA, nrow = 2, ncol = 9, byrow = FALSE, dimnames = NULL)
pnrem=matrix(data = NA, nrow = 2, ncol = 9, byrow = FALSE, dimnames = NULL)
pwake=matrix(data = NA, nrow = 2, ncol = 9, byrow = FALSE, dimnames = NULL)

pmat=matrix(data = NA, nrow = 9, ncol = 18, byrow = FALSE, dimnames = NULL)



genotipos=list('KO','WT')	
MWTKO=list()
contador2=1
  for(vgen in genotipos){
	rr <- subset(r,r$GEN==vgen)
	ratones <- unique(rr$cod)
	contador=1
	MATR=list()

	for ( i in ratones ){
		vc <- vector()
# esto es el truco mas sucio que he visto en mi vida, alucino si realmente es mio
# f es una funcion!! y como efecto colateral, modifica vc
		apply(subset(rr,rr$cod==i), 1, f)  
		mcfit <- markovchainFit(data=vc,confidencelevel = .95)
		#print(mcfit$estimate)
		v1=attr(mcfit$estimate,"transitionMatrix")
     		prem[contador2,contador]=v1[1,1]
		pnrem[contador2,contador]=v1[2,2]
		#pwake[contador2,contador]=v1[3,3]
		pmat[,contador+(contador2-1)*9]=as.vector(v1)
		MATR[[contador]]=v1
		contador=contador+1
	}
    MWTKO[[contador2]]=MATR	
	contador2=contador2+1
	
}	

#stop("fin")

 a=MWTKO[[1]][[1]]*0;
 
 for(i in 1:9){
    a=a+MWTKO[[1]][[i]]	
 }
 mk_wt=a/9
 
b=MWTKO[[1]][[1]]*0;
 
 for(i in 1:9){
    b=b+MWTKO[[2]][[i]]	
 }
  mk_ko=b/9
 
#print("matrix probability transition WT")
#print(mk_wt)
#print("matrix probability transition Cx36 KO")
#print(mk_ko)

pmat <- t(pmat) 


pmat <- data.frame(pmat[,1],pmat[,2],pmat[,3],pmat[,4],pmat[,5],pmat[,6],pmat[,7],pmat[,8],pmat[,9])
pmat$gen <- c(rep('wt',9),rep('ko',9))
pmat$cod <- c('wt01','wt02','wt03','wt04','wt05','wt06','wt07','wt08','wt09','ko01','ko02','ko03','ko04','ko05','ko06','ko07','ko08','ko09')
names(pmat)[1] <- "REM"
names(pmat)[5] <- "SWS"
names(pmat)[9] <- "WK"
names(pmat)[10] <- "gen"
names(pmat)[2] <- "SWStoREM"
names(pmat)[3] <- "WktoREM"
names(pmat)[4] <- "REMtoSWS"
names(pmat)[6] <- "WktoSWS"
names(pmat)[7] <- "REMtoWk"
names(pmat)[8] <- "SWStoWk"

write.csv(pmat,file="markov_31pt.csv")

