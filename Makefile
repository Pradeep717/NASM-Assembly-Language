Assignment3_3641.x:Assignment3_3641.o
	ld -o Assignment3_3641.x Assignment3_3641.o
	
Assignment3_3641.o:Assignment3_3641.asm
	nasm -f elf64 -o Assignment3_3641.o Assignment3_3641.asm
	
