salida_w=0;
salida_s=0;
sws_dur_luz=0;
sws_dur_dark=0;
wk_dur_luz=0;
wk_dur_dark=0;
rem_dur_luz=0;
rem_dur_dark=0;

sws_cant_luz=0;
sws_cant_dark=0;
wk_cant_luz=0;
wk_cant_dark=0;
rem_cant_luz=0;
rem_cant_dark=0;

    sws_dur_coc=0;
    rem_dur_coc=0;
    wk_dur_coc=0;
    sws_can_coc=0;
    rem_can_coc=0;
    wk_can_coc=0;



for(ii in 1:299){
    nescala=ii
    source('proc_calcmarkov.r')
    salida_w[ii]=tabla1$p_value[7]
    salida_s[ii]=tabla1$p_value[9]
    a1 <-aggregate(r$dur, by=list(est=r$est,luz=r$luz,cod=r$cod), FUN=mean)
    razonm=a1[a1$luz=='light',]$x/a1[a1$luz=='dark',]$x
    a2 <-tapply(a1$x,list(a1$est,a1$luz),mean)
    a1f=a1[a1$luz=='light',]
    a1f$cod <-razonm; 
    a1f <- a1f[a1f$cod<2,]
    dd1 <- tapply(a1f$cod,a1f$est,mean)

    b1 <-aggregate(r$dur, by=list(est=r$est,luz=r$luz,cod=r$cod), FUN=sum)
    razonm=b1[b1$luz=='light',]$x/b1[b1$luz=='dark',]$x
    b1f=b1[b1$luz=='light',]
    b1f$cod <-razonm; 
    b1f <- b1f[b1f$cod<2.5,]
    db1 <- tapply(b1f$cod,b1f$est,mean)



    razons=a1[a1$luz=='light',]$x/a1[a1$luz=='dark',]$x

    a3 <-tapply(b1$x,list(a1$est,a1$luz),mean)
     sws_dur_luz[ii]=a2[2,1]
    sws_dur_dark[ii]=a2[2,2]
    wk_dur_luz[ii]=a2[3,1]
    wk_dur_dark[ii]=a2[3,2]
    rem_dur_luz[ii]=a2[1,1]
    rem_dur_dark[ii]=a2[1,2]

    sws_cant_luz[ii]=a3[2,1]
    sws_cant_dark[ii]=a3[2,2]
    wk_cant_luz[ii]=a3[3,1]
    wk_cant_dark[ii]=a3[3,2]
    rem_cant_luz[ii]=a3[1,1]
    rem_cant_dark[ii]=a3[1,2]


    sws_dur_coc[ii]=dd1[2];
    rem_dur_coc[ii]=dd1[1];
    wk_dur_coc[ii]=dd1[3];
    sws_can_coc[ii]=db1[2];
    rem_can_coc[ii]=db1[1];
    wk_can_coc[ii]=db1[3];



}


