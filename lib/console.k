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
msg:{(,//$(_ltime _t;_h;_p;_d),\:\:" "),/:$:[0=4:x;x;-3=4:x;,x;,,//$x]}
log:{   `0:msg x
        if[`m _in !`
                if[`spork _in !`.m.
                        if[7=4:.m..spork.handle
                                .m..spork.handle 3: (0:;(`;msg x))]]]}
