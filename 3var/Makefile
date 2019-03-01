.PHONY: build compile generate vendor

MSG ?= "Across the Great Wall, we can reach every corner in the world."

build:
	cd vendor && make

# compile:
# 	bash resource/compiler.sh 3var.3var

# generate:
# 	bash resource/generator.sh $(MSG)

vendor:
	git clone https://github.com/olls/3var-interpreter vendor
