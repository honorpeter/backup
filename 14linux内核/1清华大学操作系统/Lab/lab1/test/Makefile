QEMU := $(shell if which qemu-system-i386 > /dev/null; \
		then echo 'qemu-system-i386'; exit; \
		elif which i386-elf-qemu > /dev/null; \
		then echo 'i386-elf-qemu'; exit; \
		else \
		echo "***" 1>&2; \
		echo "*** Error: Couldn't find a working QEMU executable." 1>&2; \
		echo "*** Is the directory containing the qemu binary in your PATH" 1>&2; \
		echo "***" 1>&2; exit 1; fi)








