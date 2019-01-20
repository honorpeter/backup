ldd  build/lib/libcaffe-nv.so.0.17 > list.txt
awk -F"=>" '{print $2}' list.txt | awk -F" " '{print $1}' > path.txt
cp $(cat path.txt) lib
