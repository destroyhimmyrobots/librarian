/ Copyright (c) 2014, Marc J. Szalkiewicz
/ ALl rights reserved.
/
/ This file is part of .k.librarian
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

.librarian[`console`c]
.librarian[`filesystem`fs]
.librarian[`ascii]

mv:{:[~(-3=4:x$:)&-3=4:y$:;:""];@[`4:;,//$"move /Y ",x," ",y;:]}
rm:{:[~-3=4:x$:;:""];@[`4:;,//$"del /F /Q ",x;:]}

drv:{#[p?"\\";p:*`4:"chdir"]}

dwhere:{ `4:"where /R \"",($x),"\" *" }
fwhere:{*`4:"where \"",($x),"\"" }

d2lower:{`4:"for /F %a in ('dir ",(,//$x)," /S /L /B') do ren %a %a"}

dnsmirror:{[x;y;z]
        to:(2#"\\"),($y),fs[`sep],fs[`abspath][(x$:)] _dv ":"
        c[`log]["Mirroring ",x," -> ",to]
        :[6=4:z;robocp[x;to];z[x;to]] }

xcp:{:[~(-3=4:x)&(-3=4:y);' "Invalid argument to dnscp."]
        `3:"xcopy \"",x,"\" \"",y,"\" /Y /E /C /I /J /O /F"}

robocp:{
        :[~(-3=4:x)&(-3=4:y);' "Invalid argument to robocp."]
        `3:"robocopy \"",x,"\" \"",y,"\" /E /MT:16 /DCOPY:T"}

/ need more to remove byte order mark (utf16 endianness)
/ superuser.com/questions/812438/combine-batch-wmic-ansi-unicode-output-formatting
fileTimeModifiedStr:{
        :[4=#r:`4:"wmic datafile where Name=",(5:x)," get LastModified | more"
	    (r 1) _dv/ascii[`space];""]}

fmts:{:[0=#r:fileTimeModifiedStr x;0N;ktime r]}
