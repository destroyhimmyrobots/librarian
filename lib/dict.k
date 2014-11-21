del:{.(. x)_di((!x)?/::[@y;,y;y])_dv#!x}
only:{. y,',:'x y}
diff:{(!y)@&(#!x)=(!x)?/:!y} / y ~in x
nset:{
	k:diff[x;y]
	:[(0#`)~k;x;@[x;k;:;y k]] }
req:{[d;k]
	if[~@x;{'x}"Key ",($k)," is not atomic.";:d]
	:[~k _in!d;{'x}"Key ",($k)," required in dictionary:\n",5:d;d]}
dk:{:[5-4:x;x _di y;x]}
