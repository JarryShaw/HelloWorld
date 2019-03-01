.PHONY: compile generate

MSG ?= "Across the Great Wall, we can reach every corner in the world."

compile:
	erlc Erlang.erl
	erl -noshell -s Erlang start -s init stop

# generate:
# 	bash resource/generator.sh $(MSG)
