.PHONY: 2dfuck 2sable 3var 4 05ab1e 7 99 \
		applescript arnoldc asciidots assembly \
		basic befunge brainfuck \
		c cs c++ clojure cobol coffeescript commata \
		d \
		erlang \
		fs fortran \
		go groovy \
		haskell \
		java javascript \
		lisp \
		matlab \
		objective-c \
		pascal \
		perl php python \
		r rexx ruby \
		scala shell slashes swift \
		verilog

2dfuck:
	cd 2DFuck && make compile

2sable:
	cd 2sable && make compile

3var:
	cd 3var && make compile

4:
	cd 4 && make compile

05ab1e:
	cd 05AB1E && make compile

7:
	echo "Compilation not supported yet."

99:
	echo "Compilation not supported yet."

applescript:
	cd AppleScript && make compile

arnoldc:
	cd Arnoldc && make compile

asciidots:
	cd AsciiDots && make compile

assembly:
	cd Assembly && make compile

basic:
	cd BASIC && make compile

befunge:
	cd Befunge && make compile

brainfuck:
	cd Brainfuck && make compile

c:
	cd C && make compile

cs:
	cd C# && make compile

c++:
	cd C++ && make compile

clojure:
	cd Clojure && make compile

cobol:
	cd COBOL && make compile

coffeescript:
	cd CoffeeScript && make compile

commata:
	cd Commata && make compile

d:
	cd D && make compile

erlang:
	cd Erlang && make compile

fs:
	cd F# && make compile

fortran:
	cd Fortran && make compile

go:
	cd Go && make compile

groovy:
	cd Groovy && make compile

haskell:
	cd Haskell && make compile

java:
	cd Java && make compile

javascript:
	cd JavaScript && make compile

lisp:
	cd Lisp && make compile

matlab:
	cd MATLAB && make compile

objective-c:
	cd Objective-C && make compile

pascal:
	cd Pascal && make compile

perl:
	cd Perl && make compile

php:
	cd PHP && make compile

python:
	cd Python && make compile

r:
	cd R && make compile

rexx:
	cd Rexx && make compile

ruby:
	cd Ruby && make compile

scala:
	cd Scala && make compile

shell:
	cd Shell && make compile

slashes:
	cd Slashes && make compile

sql:
	cd SQL && make compile

swift:
	cd Swift && make compile

verilog:
	cd Verilog && make compile
