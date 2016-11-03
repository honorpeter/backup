#/bin/bash
gnome-terminal -e "qemu -S -s -d in_asm -D q.log -monitor stdio -hda $< -serial null"  
sleep 2
gnome-terminal -e "gdb -q -x tools/moninit"

#gnome-terminal -e "qemu -S -s -d in_asm -D q.log -monitor stdio bin/ucore.img"











