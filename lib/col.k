/ Copyright (c) 2014, Marc J. Szalkiewicz
/ ALl rights reserved.
/
/ This file is part of frame.k
/ This program is free software: you can redistribute it and/or modify
/ it under the terms of the GNU General Public License as published by
/ the Free Software Foundation, either version 3 of the License, or
/ (at your option) any later version.
/ This program is distributed in the hope that it will be useful,
/ but WITHOUT ANY WARRANTY; without even the implied warranty of
/ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
/ GNU General Public License for more details.
/ You should have received a copy of the GNU General Public License
/ along with this program.  If not, see <http://www.gnu.org/licenses/>.
/ ----------------------------------------------------------------------- license
.librarian[`ktype]
.librarian[`date`date]
.librarian[`filesystem`fs]
.librarian[`list`list]
.librarian[`console`c]
.librarian[`string`str]

sample:{x[(2048&#x) _draw #x]}

isDateNamedCol:{:[-3=4:x;(~tl _sm "*update*")&(tl:str.tolower[x]) _sm "*date*";0]}
isDateTimeCol:{&/ date.isdatetime[sample x]}
isTimeCol:{&/ date.istime[sample x]}
isDateCol:{&/ date.isdate[sample x]}

guessColType:{ / x <- .l data
		/ t:*t@>t:stat.mode[ktypeGuess'x]
    u:(?g:ktypeGuess'x) _dv 6
	:[0=#u;4;*u[>u]] }

.tmp.creg::()
col2guesstype_:{ / x <- .l
        `0:/:$creg
        tf:0
        col:1:x
        x:str.tolower[fs.abspath[x]]
        if[isDateTimeCol col
                c.log[x," is a datetime column."]
                (x:fs.nofext[x],/:"_",/:"dt",\:".l")1:'date.str2datetime[col]
                tf:1]
        if[isDateCol col
                c.log[x," is a date column."]
                x 1:date.date2ymd[col];tf:1]
        if[isTimeCol col
                c.log[x," is a time column."]
                x 1:date.time2t24[col];tf:1]
        tt:1
		if[0=tf
                i:0;while[(i<8)&1=*tt:@[guessColType;col;:];i+:1]
                if[i=8;`+3;'"Could not guess type of ",x]
                col2ktype[col;x;*|tt]]

        { if[~(!0)~i:&.tmp.creg _sm "*",fs.basename[x]
            oldt:_abs 4::'1::'.tmp.creg[i]
            if[~&/y=oldt
                t:|/y,oldt
                c.log'["Changing ",/:(($creg[i]),'" ",/:$oldt)\:" to type ",($t),"."]
                col2ktype'[1::'.tmp.creg[i];.tmp.creg[i];t]]] / if is symbol
         }\:[list.a2l[x];tt]

       if[i~!0;.tmp.creg::.tmp.creg,:[-3=4:x;,x;x]]
       c.log[,//x," is type ",$tt];:0 }

col2guesstype:{ if[col2guesstype_[x];.gc.rm,:,x] }

col2ktype:{ / x <- .l data; y <- ktype; z <- file
		y 1: str2ktype[x;z]; z }

rows2cols:{
        / x <- directory
        / y <- filenames
		/ z <- row reordcs
		/ : -> encapsulating folder
        if[~2=#^z
				rne:recsNotEqLen[z]
				(str.tolower[x],fs.DIRSEP,"UNEQ",($_t),".l") 5: rne,'z@rne
				c.log["Removed ",($#rne),"/",($#z)," unequal records."]
				z[rne]:(#rne)#,recsLen[z]#,""
				z:z _di rne]
		5:'[(str.tolower[x],fs.DIRSEP),/:str.tolower'[y];+z] }
