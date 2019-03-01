.PHONY: compile generate

MSG ?= "Across the Great Wall, we can reach every corner in the world."

compile:
	bash resource/compiler.sh AppleScript.applescript

generate:
	python resource/generator.py $(MSG)
