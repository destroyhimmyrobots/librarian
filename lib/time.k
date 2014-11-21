/ ------------------------------------------------------------------------------
/ Copyright (c) 2014, Marc J. Szalkiewicz
/ This file is part of .k.librarian.
/ This work is licensed under the
/ Creative Commons Attribution-NonCommercial 4.0 International License.
/ To view a copy of this license, visit http://creativecommons.org/licenses/by-nc/4.0/
/ or send a letter to 	Creative Commons,
/						444 Castro Street, Suite 900,
/						Mountain View, California, 94041, USA.
/ ------------------------------------------------------------------------------

/ ------------------------------------------------------------------------------
/ TIME FUNCTIONS
/ ------------------------------------------------------------------------------
/ need more to remove byte order mark (utf16 endianness)
/ superuser.com/questions/812438/combine-batch-wmic-ansi-unicode-output-formatting
fmts:{:[~w[]
        unix2ktime 0$*`4:"stat -f %m ",x
        :[0=#r:fileTimeModifiedStr x;0N;ktime r]]}
ktime:{ / x <- a string of YYYYMMDDHHmmSS.nnnnnn+UTC. UTC offset in minutes.
  gmtoff:-4#x;t::["-"=*gmtoff;1;-1]*60*0$1_ gmtoff / shift to UTC
  t+:86400*_jd 0$8#x / add YMD
  t+/3600 60 1*100 _vs 0$6#8_ x } / add HmS
