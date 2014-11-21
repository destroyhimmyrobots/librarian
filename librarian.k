/ librarian.k
/ Marc J. Szalkiewicz
/ 2014 Nov.
/ Library loading.

librarian:{[x]
	:[-3=4:x;x,:]
	:[~-4=4:x:`$$:[@x;,x;x]
		'"LIBRARIAN: argument '",,//($x),"' is not a symbol."]

	arg::[(1=#^x)&2=*^x / Check for lib k-tree destination
			:[`=x 1
				(x 0),0
				(x 1),1] 
		 	(x 0),0]

	libdir:"./lib"

	x:$*x;:[".kr"~-3#x;x:-3_ x;".k" ~-2#x;x:-2_ x]
	libloc:libdir,_ssr[x;".";"/"]

	kd:_d
	ud:*arg
	:[_d~ud;'"Nice try."]

	ld:`$".libraries.import.",:["."=*$ud
		"absolute", $ud
		"relative.",$ud]

	. "\\d ",$ld
	. "\\l ",$libloc
	. "\\d ",$kd

	.[ud;();:;ld] / set the handle to the library
    (kd;*arg;libloc) }

.[`;`librarian;:;(_d)`librarian]
