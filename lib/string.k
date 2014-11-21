toupper:{if[~-3=4:x$:;:_n];x[lc]:_ci ic[lc:&(96<ic)&123>ic:_ic x]-32;x}
tolower:{if[~-3=4:x$:;:_n];x[uc]:_ci ic[uc:&(64<ic)& 91>ic:_ic x]+32;x}
capitalize:{
	if[~-3=4:x$:;:_n]
	1__ssr["\b",tolower[x];"[^a-zA-Z][a-z]";{x[0],_ci -32+_ic x[1]}]}
splitdate:{
	if[~-3=4:x$:;:_n]
	1_,//".",/:$10000 100 100 _vs 0$$x}
