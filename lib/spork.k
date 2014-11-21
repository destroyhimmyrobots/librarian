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
.librarian[`console`c]
.librarian[`filesystem`fs]

/ ------------------------------------------------------------------------------
/ FORK & IPC FUNCTIONS
/ ------------------------------------------------------------------------------

fork:{[sync;cmd] / 'b' flag to hide prompt
		if[|/_o=`w32`w64
			n:4;nice:"/",/:("low";"belownormal";"normal"
					"abovenormal";"high";"realtime")
			:`4:"start /min ",nice[5&n|0],:[`sync=sync;"/wait ";" "],cmd]
		"" }

setmdict:{[h]
		h 3:(`.m..spork;,`hp;:;(_h;_p))
   		h 3:".m..spork.handle:3:.m..spork.hp"
		h 3:(`.m..spork;,`close;:;{_exit 0}) / parent exit
		h 3:(`.m;,`c;:;".m..spork.close[]") / specify callback here
		h 3:(`.m;,`s;:;{t::[4:x;. x;.[.;x]]
                        .m..spork.handle 3:(t;_h;_p) })
		h }

setselfmdict:{
    .m.c:{[x]`0:$x;"`0:\"A spork exited.\""}
    .m..spork.onError: {[h] h 3:(`.m.;,`spork.handle;3::) }
    .m..def:{if[*r::[4:x;@[.;x;:];.[.;x]];`+3]}
    .m.s:{if[((#.m..descendants)>i:.m..descendants[;1 2]?x[1 2])&3=#x
                .[4:;(.m..descendants[i;0];".m..spork.close[]");:] / don't route to .m.s override
                .m..descendants: .m..descendants _di i
                c:x
                x*:]
                :[4:x;. x; .[.;x]] } }

kfork:{[sync;prgm;script]
		cmd:,/($prgm)," ",($script)," -i ",($p:fs.randport[])
		if[*r:.[fork;(sync;cmd);:];'*|r]
		if[`sync=sync;:0]
		h:3:(`;p)
		h 3:"\\title ",($script)," ",($prgm),"@",(,/($h 4:/:("_h";"_p")),'": "),"of",/" :",'$(_h;_p)
        .m..descendants,:,(h;_h;p)
        .m..descendants: .m..descendants _dv _n
        setselfmdict[]
        setmdict h
		h }

fork_k:{[sync] kfork[sync;`k;""] }
fork_e:{[sync] kfork[sync;`e;""] }
fork_kscript:{[sync;script] kfork[sync;`k;script] }
fork_escript:{[sync;script] kfork[sync;`e;script] }
