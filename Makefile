makefile:
	echo "Across the Great Wall we can reach every corner in the world."

assembly:
	nasm -f elf Assembly/Assembly.asm
	ld -m elf_i386 -s -o assembly *.o
	assembly

c:
	gcc C/c.c -o c -lm -pthread -lgmp -lreadline
	c

c#:
	mcs C#/C#.cs -out: c#.exe
	mono c#.exe

c++:
	g++ -std=c++11 C++/C++.cpp -o cpp
	cpp

clojure:
	java -jar /usr/share/java/clojure.jar -i Clojure/Clojure.clj

cobol:
	cobc -c -free -x COBOL/COBOL.cobol
	cobc -x -o cobol COBOL.o
	cobol

d:
	dmd -I./ D/D.d -of d.amx
	d.amx

erlang:
	erlc Erlang/Erlang.erl
	erl -noshell -s Erlang start -s init stop

f#:
	fs F#/F#.fs --out: f#.exe
	mono f#.exe

fortran:
	gfortran -std=f95 Fortran/Fortran.f95 -o fortran
	fortran

go:
	go run Go/Go.go

groovy:
	groovy Groovy/Groovy.groovy

haskell:
	ghc -O2 --make Haskell/Haskell.hs -o haskell -threaded -rtsopts
	haskell

javascript:
	node JavaScript/Node.js

lisp:
	clisp Lisp/Lisp.lisp

matlab:
	octave -qf --no-window-system MATLAB/MATLAB.m

objc:
	clang -framework Foundation -o objc Objective-C/Objective-C.m
	clang -framework Foundation -o objcpp Objective-C/Objective-C++.mm
	objc
	objcpp

pascal:
	fpc -v0 Pascal.pas
	Pascal

perl:
	perl Perl/Perl.pl

python:
	python Python/Python.py
	python3 Python/Python3.py

r:
	Rscript R/R.r

rexx:
	rexx Rexx/Rexx.rexx

scala:
	scalac Scala/Scala.scala
	scala -classpath . Scala

shell:
	bash Shell/Bourne-Again\ Shell.bash
	csh Shell/C\ Shell.csh
	ksh Shell/Korn\ Shell.ksh
	sh Shell/Shell.sh
	tcsh Shell/Tenex\ C\ Shell.tcsh
	zsh Shell/Z\ Shell.zsh

swift:
	swiftc Swift/Swift.swift
