/ ------------------------------------------------------------------------------
/ USER INTERACTION FUNCTIONS
/ ------------------------------------------------------------------------------
stdin:{`0:,x;0,,0:`}
char_response:{if[@x;x,:];c:_n;while[0=|/x~\:c;`0:y;c:*,//0:`];c}

/ ------------------------------------------------------------------------------
/ OPERATING SYSTEM FUNCTIONS
/ ------------------------------------------------------------------------------
w:       		:[3.2=0.$_k;{1};{:[|/(. "_o")=/:`w32`w64;1;0]}]
SEPERATORS:		"/\\"
EOLS::  		(,"\n";"\r\n")
DIRSEP:: 		SEPERATORS w[]
sep:	 		SEPERATORS w[]
eol::  			EOLS w[]
WS::    		" \t\r\n"
wflags:         {,//" /",/:$x}
wls:            {"dir ",($x),wflags y}
ls:             {`4::[w[];"dir /b ";"ls "],$x}
lsr:            {`4::[w[];wls[x;"sb",,"a-d"];"ls -r ",x]}
lsdr:           {`4::[w[];wls[x;"sb",,"ad"];"find ",($x)," -type d"]}
pwd:    		{*`4::[w[];"chdir";"pwd"]}
home:   		{:[w[];,/_getenv' "HOME",/:("DRIVE";"PATH");_getenv "HOME"]}
mkdir:{ :[w[]
		@[`4:;"if not exist ",(5:x)," mkdir ",5:x;:]
		@[`4:;"if [ ! -d ",(5:x)," ];then mkdir -p ",(5:x),";fi";:] ] }
touch:			{@[`4:;:[w[];"type nul > ",x;"touch ",x];:]}
mv:      		:[w[];{`4:"move /y ",x," ",y};{`4:"mv ",x," ",y}]
rm:      		:[w[];{*|r:@[`4:;"del /Q ",x;:]};{`4:"rm -f ",x}]
pathof:   		{_[-1-*&DIRSEP=|x;x] }
basename: 		{:[DIRSEP _in x; |(*&DIRSEP=|x)#|x; x]}
abspath:        {:[w[];*lsr[x];*`4:"which ",$x]}
host:   		{:[w[];(2#sep),$_h;]}
conformsep:		{_ssr[$x;"[//\]";sep]}
dts:			{(-1*|//SEPERATORS=/:x[-1+#x])_ x}
dls:			{(   |//SEPERATORS=/:x[-1+#x])_ x}
path:			{-1_,//dts'[$x],\:sep}

fext:{:[(#x)=d:(|x)?".";"";(-d)#x]}
nofext:{:[(#x)=d:(|x)?".";x;(-1-d)_ x]}
exists:{[x]
  / k-windows can't handle else clause
  r:[w[];0$*/`4:"if exist ",($x)," (echo 1) else (echo 0)"
        :@[`4:;"sh -c -- '[ -d ",(5:x)," ] && echo 1 || echo 0'";:]]
 :[0=*r;(*|r,x);r] } / (EXIT_CODE; DIRSTR)
