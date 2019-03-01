.PHONY: compile generate

MSG ?= "Across the Great Wall, we can reach every corner in the world."

compile: compile-objc compile-objc++

compile-objc:
	clang -framework Foundation -o Objective-C Objective-C.m
	./Objective-C

compile-objc++:
	clang -framework Foundation -o Objective-C++ Objective-C++.mm
	./Objective-C++

# generate:
# 	bash resource/generator.sh $(MSG)
