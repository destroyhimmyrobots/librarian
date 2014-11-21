nearestInt:{_0.5+x}
binrand:{nearestInt 1 _draw 0}
hexrand:{h@x _draw#h:,/$(!10),_ci 65+!6}
dec2hex:{"0123456789ABCDEFG" :[@x;16 _vs x;16 _vs'x]}
bangpart:{:[(y>0)&(x>0)&(1=4:x);=+/+(y*1+!_ x%y)>/:!x;!0]}
