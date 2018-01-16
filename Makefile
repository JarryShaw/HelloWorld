.PHONY: makefile

makefile:
	echo "Across the Great Wall, we can reach every corner in the world."

arnoldc:
	cd Arnoldc/
	java -jar utilities/ArnoldC.jar Arnoldc.arnoldc
	java Arnoldc

asciidots:
	cd AsciiDots/
	asciidots AsciiDots.dots

assembly:
	cd Assembly
	nasm -f elf Assembly.asm
	ld -m elf_i386 -s -o assembly *.o
	assembly

basic:
	cd BASIC/
	bwbasic BASIC.bac

befunge:
	cd Befunge/
	utilities/befunge-93/bin/bef Befunge.be

brainfuck:
	cd Brainfuck/
	utilities/qdb Brainfuck.bf

c:
	cd C/
	gcc C.c -o c -lm -pthread -lgmp -lreadline
	c

csharp:
	cd C#/
	mcs C#.cs -out: csharp.exe
	mono csharp.exe

c++:
	cd C++
	g++ -std=c++11 C++.cpp -o cpp
	cpp

clojure:
	cd Clojure/
	java -jar utilities/clojure.jar -i Clojure.clj

cobol:
	cd COBOL/
	cobc -c -free -x COBOL.cobol
	cobc -x -o cobol COBOL.o
	cobol

coffeescript:
	cd CoffeeScript/
	coffee CoffeeScript.coffee

d:
	cd D/
	dmd -I./ D.d -of d.amx
	d.amx

erlang:
	cd Erlang/
	erlc Erlang.erl
	erl -noshell -s Erlang start -s init stop

fsharp:
	cd F#/
	fs F#.fs --out: fsharp.exe
	mono fsharp.exe

fortran:
	cd Fortran/
	gfortran -std=f95 Fortran.f95 -o fortran
	fortran

go:
	cd Go/
	go run Go.go

groovy:
	cd Groovy/
	groovy Groovy.groovy

haskell:
	cd Haskell/
	ghc -O2 --make Haskell.hs -o haskell -threaded -rtsopts
	haskell

java:
	cd Java/
	javac Java.java
	java Java

javascript:
	cd JavaScript/
	node Node.js
	node JSFuck.js

lisp:
	cd Lisp/
	clisp Lisp.lisp

matlab:
	cd MATLAB/
	octave -qf --no-window-system MATLAB.m

objc:
	cd Objective-C/
	clang -framework Foundation -o objc Objective-C.m
	clang -framework Foundation -o objcpp Objective-C++.mm
	objc
	objcpp

pascal:
	cd Pascal/
	fpc -v0 Pascal.pas
	Pascal

perl:
	cd Perl/
	perl Perl.pl

php:
	cd PHP/
	php PHP.php

python:
	cd Python/
	python Python.py
	python3 Python3.py

r:
	cd R/
	Rscript R.r

rexx:
	cd Rexx/
	rexx Rexx.rexx

ruby:
	cd Ruby/
	ruby Ruby.rb

scala:
	cd Scala/
	scalac Scala.scala
	scala -classpath . Scala

shell:
	cd Shell/
	bash Bourne-Again\ Shell.bash
	csh C\ Shell.csh
	ksh Korn\ Shell.ksh
	sh Shell.sh
	tcsh Tenex\ C\ Shell.tcsh
	zsh Z\ Shell.zsh

swift:
	cd Swift/
	swiftc Swift.swift
