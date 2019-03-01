.PHONY: compile generate vendor

MSG ?= "Across the Great Wall, we can reach every corner in the world."

compile:
	bash resource/compiler.sh 2sable

generate:
	python resource/generator.py $(MSG)

vendor:
	git clone https://github.com/Adriandmen/2sable vendor
