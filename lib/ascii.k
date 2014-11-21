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
upper:      _ci upperRange:65+!26
lower:      _ci lowerRange:97+!26
alpha:      _ci alphaRange:upperRange,lowerRange
numeral:    _ci numeralRange:48+!10
alnum:      _ci alnumRange:numeralRange,alphaRange
symbol:     _ci asciiPunctuationRange:(33+!10),(58+!7),(91+!6),(123+!4)
space:      " \t\r\n\b"
displaying: _ci displayingRange:32+!95
quote:      "\"'`"
base64:     _ci,/46 65 97+(!12;!26;!26)
