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
toupper:{if[~-3=4:x$:;:_n];x[lc]:_ci ic[lc:&(96<ic)&123>ic:_ic x]-32;x}
tolower:{if[~-3=4:x$:;:_n];x[uc]:_ci ic[uc:&(64<ic)& 91>ic:_ic x]+32;x}
capitalize:{
	if[~-3=4:x$:;:_n]
	1__ssr["\b",tolower[x];"[^a-zA-Z][a-z]";{x[0],_ci -32+_ic x[1]}]}
splitdate:{
	if[~-3=4:x$:;:_n]
	1_,//".",/:$10000 100 100 _vs 0$$x}
