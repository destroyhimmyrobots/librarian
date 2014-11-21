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
naOfT:{ :[-4=x;:0#` ;-3=x;:""    ;-2=x;0#0.0;-1=x;:!0
                      4=x;:`   ; 3=x;:"\000"; 2=x;:0n,0i; 1=x;:0I,0N
                      5=x;:,.(); 6=x;:_n    ; 7=x;:{};'"Invalid ktype."] }
naOf:{  naOfT[_abs 4:x] }
/sym2bool:{
/    u:?x;u:u@<u
/    boolz:(,':5#`$/:"nyNY")
/    boolz:boolz@'<:'boolz
/    if[2=#u
/        if[(#boolz)>i:boolz?u
/            :@[x;boolz[i]=/:x;:;[];]
/            ]]
/}

kVecTypeGuess:{
		:[""~x;:6
		  x _sm ,/'(#:'x)#\:,"[0-9]";1 / INT
		  0=*r:@[0.0$;x;:];          2 / FLO
		  0=*r:@[  `$;x;:];	 	     4 / SYM
		  0=*r:@[ ""$;x;:];		     3 / STR
		  '"String could not be type-guessed: ",x ] }

ktypeGuess:{
		:[""~x;:6
		  x _sm ,/(#x)#,"[0-9]";:[0I=_abs 0$x;:[0i=_abs 0.0$x;4;2];1] / INT
		  0=*r:@[0.0$;x;:];     :[0i=_abs 0.0$x;4;2] / FLO
		  0=*r:@[  `$;x;:];     4 / SYM
		  0=*r:@[ ""$;x;:];    -3 / STR
		  '"String could not be type-guessed: ",x ] }

nilktype:{:[-4=x;0#`;-3=x;0#"";-2=x;0#0.0;-1=x;!0
		0=x;();1=x;0;2=x;0.0;3=x;"";4=x;`;5=x;.()
		6=x;_n 7=x;{}]}

str2ktype:{/x <- string. y <- destination type (int)
		:[4=_abs y;`$$x
		3=_abs y;$x
		2=_abs y;0.0$$x
		1=_abs y;0$$x
		0=y;,x
		5=y;.,(`$x;)
		6=y;_n
		7=y;{:$x}
		',//"Could not convert ",($x),"to type ",$y] }
