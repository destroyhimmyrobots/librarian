/ definition.k
/ dynamic typing for k functions
/ 2014 11 18

/ ------------------------------------------------------------------ bsd4 license
/ Copyright (c) 2014, Marc Joseph Szalkiewicz
/ All other rights reserved.
/
/ Redistribution and use in source and binary forms, with or without
/ modification, are permitted provided that the following conditions are met:
/ 1. Redistributions of source code must retain the above copyright
/    notice, this list of conditions and the following disclaimer.
/ 2. Redistributions in binary form must reproduce the above copyright
/    notice, this list of conditions and the following disclaimer in the
/    documentation and/or other materials provided with the distribution.
/ 3. All advertising materials mentioning features or use of this software
/    must display the following acknowledgement:
/    This product includes software developed by Marc J. Szalkiewicz.
/ 4. Neither the name of Marc Joseph Szalkiewicz nor the
/    names of other contributors may be used to endorse or promote products
/    derived from this software without specific prior written permission.
/
/ THIS SOFTWARE IS PROVIDED BY Marc Joseph Szalkiewicz ''AS IS'' AND ANY
/ EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
/ WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
/ DISCLAIMED. IN NO EVENT SHALL Marc Joseph Szalkiewicz BE LIABLE FOR ANY
/ DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
/ (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
/ LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
/ ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
/ (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
/ SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
/ ----------------------------------------------------------------------- license

define:{
	:[~4=4:x	;'"Name to define must be a handle."
	  ~7=4:. x	;'"Handle must reference a function."]

	t:(~x).`type

	:[	~1=#^t
		'"Type specification has rank != 1."
		~2=*^t
		'"Type specification must take the form (`return;`arg1`arg2...`argN)."
		~4=4:*t
		'"Return type must be a symbol atom."
		~4=_abs 4:t[1]
		'"Argument types must be a symbol atom or symbol vector."]

	r:*t;	if[~@r;'"Return type must be atomic."]
	t:t 1;	if[@t;t,:]

	t[&~(#str)=(str:`$"st",\"ring")?/:t]:`vc
	if[|/r=str;r:`vc]

	h:_hash symkt:`ha`vs`vc`vf`vi`li`in`fl`ch`sy`ni`di`fu
	tolower:{x[lc]:_ci ic[lc:&(64<ic)& 91>ic:_ic x]+32;x}
	intkt:-5+!13
	deftypes::[	-4=4:t;{(symkt;h)?/:`$tolower'[2#/:$x]}[t]
				-1=4:t;{intkt?/:x}[t]
				'"Supply integer or symbol vector as argument list."]
	rtntypes::[	4=4:r;(symkt;h)?`$tolower[2#$r]
				1=4:r;intkt?r
				'"Supply integer or symbol vector as return type."]

	:[1 _in invalid:deftypes=#intkt
		'"Invalid types specified: ",/" ",/:$&invalid
	  rtntypes=#intkt
		'"Invalid return type specified."]

	t:@[intkt;deftypes]
	r:@[intkt;rtntypes]

	f:. "{[args]
	if[@args;args,:]
	:[	~=/#:'(",(5:t),";args);'\"Invalid number of arguments.\"
	  	~&/m:(",(5:t),")=4::'args;'\"Invalid types in argument indices:\",/\" \",/:$&~m]
		rt:4:returned:",(5:. x)," . args
		:[",(5:r),"=rt
			returned
			'\"Invalid type \",/($rt),\" returned from function of type ",($r),".\"] }"
	.[x;();:;f] }

/ -----------------------------------------------------------------------------
/ Documentation (kdoc)

doc:@[.();`load_arg`sdesc`desc`version`hide_undocumented`no_sort;:
	(`doc_path`make_doc
	"k function dynamic typing."
	"Documentation for k function dynamic typing."
	20141118;1;0)]

define..doc:{
	d10:"A handle referencing a function with the `type key defined in the attribute dictionary.\n"
	d20:"f..type is a list of two elements:\n"
	d21:"(1) return type (`symbol or int atom), and\n"
	d22:"(2) argument types (`symbol or int, atom or vector).\n"
	d30:"Valid type names are the integer k types [-5,7] or the equivalent symbols:\n"
	d31:"`hash`vsym`vchar`vflo`vint`list`int`flo`char`sym`dict`nil`func.\n"
	d32:"Type names may be truncated to at least two characters. For example:\n"
	d33:"f..type:(`int;`vf`in`fu); f:{_+/z[y*x]}; define[`f]; f(3 1.;37;%:).\n"
	d40:"Mistaken types cannot be determined and are considered a client error."

	d:@[.();`type`name`sdesc;:;(7;`define;"Construct a dynamically typed k function.")]
	d.args:1#.()
	d.args[0]:.((`name`f)
				(`type;4)
				(`desc;d10,d20,d21,d22,d30,d31,d32,d33,d40))
	d.default:_n
	d.return.type:4
	d.return.desc: "The handle passed as an argument.\n"
	d.return.desc,:"The referenced function is now redefined as a monad wrapped in type-checking code.\n"
	d.return.desc,:"Bracket notation should therefore be elided.\n"
	d.return.desc,:"Instead, invoke the new function using a list notation:\n"
	d.return.desc,:"f(x1;x2;...;xN)."
	d }
