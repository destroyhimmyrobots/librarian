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
