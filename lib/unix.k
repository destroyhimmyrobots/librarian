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

unix_t:{:[w[];0N;0$*`4:"date +%s"]}
k2unixtime:{_ x*unix_t[]%_t}
unix2ktime:{_ x*_t%unix_t[]}
fmts:{unix[`unix2ktime][0$*`4:"stat -f %m ",x]}
