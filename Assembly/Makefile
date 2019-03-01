.PHONY: compile generate

MSG ?= "Across the Great Wall, we can reach every corner in the world."

compile:
	nasm -f elf Assembly.asm
	ld -m elf_i386 -s -o assembly *.o
	assembly

# generate:
# 	bash resource/generator.sh $(MSG)
