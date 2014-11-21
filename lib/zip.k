.librarian[`string`str]
.librarian[`filesystem`fs]

unzipstdin:{unzip[" -p ",x;y]}
unzip:{`4:"unzip -u ",x," -d ",str[`tolower][fs[`nofext][$x]]}
unzipwd:{`4:"unzip -u ",x," -d ."}
unzipd:{`4:"unzip -u ",x," -d ",$y}
unzipfiles:{`4:"unzip ",x," ",//y,\:" "}
zip:{`4:"zip ",x,".zip ",//y,\:" "}
list:{`4:"unzip -Z1 ",x}
