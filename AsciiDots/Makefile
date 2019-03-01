.PHONY: build compile generate vendor

MSG ?= "Across the Great Wall, we can reach every corner in the world."

build:
	cd vendor && python3 setup.py install

compile:
	asciidots AsciiDots.dots

# generate:
# 	bash resource/generator.sh $(MSG)

vendor:
	git clone https://github.com/aaronduino/asciidots vendor
