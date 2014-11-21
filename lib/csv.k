.librarian[`freadline]
.librarian[`stat]
.librarian[`col]
.librarian[`ascii]

guards:"'\"" / Must be a list: ,"\""

findSeperators:{ / x <- text file
        unq:?doc:,//6:x
        syp:,/&:'(",|;\t")=\:unq
        sym:(#:'=doc)@syp
        unq[syp@>sym] }

splitOn:{1_'(&(y,x)=y)_ y,x}
headers:{[x;fsep]
		freadline.open x
		r:freadline.getLine[{splitOn\:[x;fsep]}]
		freadline.close x; r }
open: {freadline.open  x}
close:{freadline.close x}
parse:{[file;fsep;skip;f]
		csv:skip _ 0:file
		r: (first:,:'csv@'!:'csv?\:fsep),'rest:1_''(&:'fsep=/:csv)_'csv
		:[7=4:f;f r; r] }
getRecords:{
		/ x <- records to read or -1 until EOF.
		/ y <- records to skip.
   		r:(); x: :[0>x;0I;_ x]; y: :[0>y;0;y]
		do[y;freadline.getLine _n] / Skip records
   		i:0;while[(i<x)&~freadline.done[]
         		r,:,freadline.getLine _n
         		i+:1]
   		r }

recsLen:{*|stat.mode[#:'x]}
recsNotEqLen:{&~(#:'x)=recsLen[x]}

removeUnequalRecords:{[f;p]
	csv:0:f
	dc:+/'p[`delim]=csv
	if[_n~rc:#p[`cols];rc:*stat.mode[dc]]
	uneqix:&~rc=dc
	1:[,//$(_gtime _t;"-UNEQ-";fs.nofext[f];".l");uneqix,',:'csv@uneqix]
	0:[n:,//fs.nofext[f],".eq.csv";csv@[csv _di uneqiv]]
	n }

recs2l:{[file;fsep;skip]
		fs.mkdir d:fs.nofext fs.basename file
		dcf:(d,fs.DIRSEP),/:cf:(hdr:headers[file;fsep]),\:".l"
		f:{		rows2cols[d;cf;x]
				col2guesstype'dcf }
		parse[file;fsep;skip;f] }
