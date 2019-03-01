.PHONY: compile generate vendor

MSG ?= "Across the Great Wall, we can reach every corner in the world."

compile:
	bash resource/compiler.sh 4

# generate:
# 	bash resource/generator.sh $(MSG)

vendor:
	git clone https://github.com/urielieli/py-four vendor/py-four
