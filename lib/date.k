.librarian[`ascii]
.librarian[`list]
.librarian[`string]

(y:"[0-3][0-9][0-9][0-9]"),ds,(M:"[01][0-9]"),(ds:"[-/.]"),c:"[0-3][0-9]";
t24:(h24:"[0-2][0-9]"),ts,(m:"[0-5][0-9]"),(ts:"[:.]"),s:"[0-5][0-9]";
t12:(h12:"[01][0-9]"),ts,m,ts,s,ampm:"*?m";
t24ns:h24,m,s;
t12ns:h12,m,s,ampm;
@[_d;`ymd`ymd_ns`mdy`mdy_ns`dmy`dmy_ns;:;(y,ds,M,ds,c;y,M,c;M,ds,c,ds,y;M,c,y;c,ds,M,ds,y;c,M,y)];

sanitize:{list[`a2l][x] _dv\:/ ascii[`space],"-./:+"}
splitspace:{
        sid:&//(x:list[`a2l][x])?\:/:ascii[`space]
        d:sid#/:x
        t:(1+sid)_/:x
        (,:'d),',:'t }

istime: {|/'list[`a2l][x] _sm\:(t24;t12)}
isdate: {|/'list[`a2l][x] _sm\:(ymd;mdy;dmy)}
isnsdate:{|/'list[`a2l][x] _sm\:(ymd_ns;mdy_ns;dmy_ns)}
isdatetime:{ / careful of seperators
        dt:splitspace[x]
        (isdate dt[;0])&istime dt[;1] }

str2datetime:{
        dt:splitspace[x]
        (,date2ymd dt[;0]),,time2t24 dt[;1] }

time2t24:{
        :[  &/x _sm\: t24;  0$sanitize[x]
            &/(str[`tolower]'[x]) _sm\: t12; (0$8#/:sanitize[x])+:["p"=x[-2+#x];120000;0]
            -1 ] }

date2ymd:{
        :[  &/x _sm\: ymd; 0$sanitize[x]
            &/x _sm\: mdy; 0$sanitize[x][;4 5 6 7,0 1,2 3]
            &/x _sm\: dmy; 0$sanitize[x][;4 5 6 7,2 3,0 1]
            -1 ] }
