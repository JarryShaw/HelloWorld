makefile:
	echo "Across the Great Wall we can reach every corner in the world."

c:
	gcc C/C.c

cpp:
	gcc C++/C++.cpp

objc:
	clang -framework Foundation Objective-C/Objective-C.m

python:
	python Python/Python.py
	python3 Python/Python3.py

shell:
	bash Shell/Bourne-Again\ Shell.bash
	csh Shell/C\ Shell.csh
	ksh Shell/Korn\ Shell.ksh
	sh Shell/Shell.sh
	tcsh Shell/Tenex\ C\ Shell.tcsh
	zsh Shell/Z\ Shell.zsh

swift:
	swiftc Swift/Swift.swift
