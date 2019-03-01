.PHONY: build compile generate vendor

build:
	cd vendor && make

compile:
	vendor/befunge-93/bin/bef Befunge.be

# generate:
# 	bash resource/generator.sh $(MSG)

vendor:
	git clone https://github.com/catseye/Befunge-93 vendor
