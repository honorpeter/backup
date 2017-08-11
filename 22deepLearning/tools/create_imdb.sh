image_dir=/media/data/xljidata/age/imdb/target/ #have /
train=train.txt
val=val.txt
target_dir=""	#have /
width=104
height=104
convert_dir="" # have /
$convert convert_imageset \
    --shuffle\
    --resize_width=$width \
    --resize_height=$height \
    $image_dir \
    $train \
    $target_dir train_lmdb

$convert convert_imageset \
    --shuffle\
    --resize_width=$width \
    --resize_height=$height \
    $image_dir \
    $val \
    $target_dir val_lmdb
