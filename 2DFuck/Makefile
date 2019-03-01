.PHONY: compile generate vendor

MSG ?= "Across the Great Wall, we can reach every corner in the world."

compile:
	bash resource/compiler.sh 2DFuck

generate:
	bash resource/generator.sh $(MSG)

vendor:
	git clone https://gitlab.com/TheWastl/2DFuck vendor
