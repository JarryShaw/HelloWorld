.PHONY: compile generate

MSG ?= "Across the Great Wall, we can reach every corner in the world."

compile:
	fs F#.fs --out: fsharp.exe
	mono fsharp.exe

# generate:
# 	bash resource/generator.sh $(MSG)
