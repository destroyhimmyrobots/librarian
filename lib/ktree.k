dirwrap:{
	`0:($od:_d),": "
	."\\d ",n:"d",hexrand[32]
	`0:,"Operation in ",($nd:_d)," starting."
	r:x . y
	."\\d ^"
	@[od;`$n;:;_n]
	r}
slashl:{dirwrap[{."\\l ",x;._d};x]}
