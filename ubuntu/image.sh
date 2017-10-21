图像处理命令：
    安装工具：
        sudo apt-get install imagemagick
    格式转换：
        mogrify -format jpg *.gif   讲所有的gif格式图片 转为jpg

    图像缩放：
        convert  -resize 50% source.png dest.jpg
                    reduce the size by 50%
        convert  -resize 1024X768  source.png dest.jpg




        mogrify -resize 50% *png      # keep image aspect ratio
        mogrify -resize 320x240 *png  # keep image aspect ratio
        mogrify -resize 320x240! *png # don't keep image aspect ratio
        mogrify -resize x240 *png     # don't keep image aspect ratio
        mogrify -resize 320x *png     # don't keep image aspect ratio

    图像转为灰度图：
        Gray  rgb
        convert -colorspace Gray zp.jpg zpgray.jpg
            for file in *.jpg; convert -colorspace Gray $file $file; end;
            for file in *.jpg;do  convert -colorspace Gray $file $file; done;
            

    查看图片：eog  feh很好用的命令啊








