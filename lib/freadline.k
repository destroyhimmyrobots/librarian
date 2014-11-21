/ ------------------------------------------------------------ gnu gpl v3 license
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
.librarian[`filesystem`fs]
/ f:(coltypes;delim) 0: ("in.csv";0;statBytes in) statBytes=0 for eof
/ ------------------------------------------------------------------------------
/ Private: (~_d) access attribute dictionary of handle _d
/ Issue: {... ~_d ...} is a fx called at runtime. use the handle h:~_d instead.
/ ------------------------------------------------------------------------------
p.file:.()
\d ~
\d ~
p.getChunk:{
  bufsz:_2^14
  if[x[`at]>x[`sz]-1;:()]
  buf:"c" 1: (x[`name];x[`at];bufsz)
  x[`at]+:*|ss:0,1+eol:&"\n"=buf
  lines:{y+!x-y+1}': ss
  x[`queue],: (buf@lines) _dv\:"\r"
  x }
/ ------------------------------------------------------------------------------
/ Public - ((~_d).`d`a) arg | p.`arg x; p .`arg ok | f apply f . x must have both spaces
/ ------------------------------------------------------------------------------
		/ Fix: check if file exists
open:   {p[`file]:.((`name;x);(`queue;());(`at;0);(`sz;__size x)) }
close:  {p[`file]:.()}
done:   {:[p[`file]~.();0;(0=p[`file;`sz]-p[`file;`at])&0=#p[`file;`queue] ] }
tally:  {:[fs.w[];-1;@[`4:;"wc -l ",p[`file;`name];:]]}

procFile:{[f] / a side-effect.
		if[(p[`file]~.())&(5=4:p[`file]);'"No file open to read."]
		if[done[];:""]
		while[~done[]
				p[`file]:p[`getChunk] p[`file]
				f p[`file;`queue]
				p[`file;`queue]:() ] }

getLine:{[f] / a side-effect.
		if[(p[`file]~.())&(5=4:p[`file]);'"No file open to read."]
		if[done[];:""]
		if[0=#p[`file;`queue]
				p[`file]:p[`getChunk] p[`file]
				if[7=4:f;p[`file;`queue]:f p[`file;`queue]] ]
		r:*p[`file;`queue]
		p[`file;`queue]:1_ p[`file;`queue]
		:[6=4:r;"";r] }
