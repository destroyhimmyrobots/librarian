ktime:{ / x <- a string of YYYYMMDDHHmmSS.nnnnnn+UTC. UTC offset in minutes.
  gmtoff:-4#x;t::["-"=*gmtoff;1;-1]*60*0$1_ gmtoff / shift to UTC
  t+:86400*_jd 0$8#x / add YMD
  t+/3600 60 1*100 _vs 0$6#8_ x } / add HmS
