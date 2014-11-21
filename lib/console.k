msg:{(,//$(_ltime _t;_h;_p;_d),\:\:" "),/:$:[0=4:x;x;-3=4:x;,x;,,//$x]}
log:{
	`0:msg x
	if[`m _in !`
		if[`spork _in !`.m.
			if[7=4:.m..spork.handle
				.m..spork.handle 3: (0:;(`;msg x))]]]}
