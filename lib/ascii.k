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
