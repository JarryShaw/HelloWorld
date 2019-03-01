.PHONY: compile generate

MSG ?= "Across the Great Wall, we can reach every corner in the world."

compile:
	ghc -O2 --make Haskell.hs -o haskell -threaded -rtsopts
	haskell

# generate:
# 	bash resource/generator.sh $(MSG)
