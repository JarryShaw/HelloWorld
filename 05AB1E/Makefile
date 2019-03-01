.PHONY: build compile generate vendor

MSG ?= "Across the Great Wall, we can reach every corner in the world."

.ONESHELL:
build:
	set -e
	cd vendor
	mix local.hex
	mix deps.get
	MIX_ENV=prod mix escript.build

compile:
	bash resource/compiler.sh 05AB1E.abe

generate:
	python resource/generator.py $(MSG)

vendor:
	git clone https://github.com/Adriandmen/05AB1E vendor
