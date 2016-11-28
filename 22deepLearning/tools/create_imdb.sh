~/caffe/build/tools/convert_imageset \
    --shuffle\
    --resize_width=100 \
    --resize_height=100 \
    ./smoke/ \
    train.txt \
    cache/img_train_lmdb
