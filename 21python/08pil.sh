Python Image Library:
        pil能处理的图片类型
            pil可以处理光栅图片(像素数据组成的的块)。
        通道
            一个图片可以包含一到多个数据通道，如果这些通道具有相同的维数和
                深度，Pil允许将这些通道进行叠加
        模式:
            1	 1位像素，黑和白，存成8位的像素
            L	 8位像素，黑白
            P	 8位像素，使用调色板映射到任何其他模式
            RGB	 3×8位像素，真彩
            RGBA	 4×8位像素，真彩+透明通道
            CMYK	 4×8位像素，颜色隔离
            YCbCr	 3×8位像素，彩色视频格式
            I	 32位整型像素
            F	 32位浮点型像素
        
        尺寸
            通过图片对象的size属性可以得到图片的尺寸，结果这是一个二元组，
                    包含水平和垂直方向上的像素数。

            坐标
                Pil采取左上角为(0,0)的坐标系统

            调色板
                mode("P")为每个像素定义具体的颜色值

            图片信息
                可以通过info属性读取一张图片的附加信息，这个与图片的格式有关

            滤镜
                在对图片的几何操作中可能会将多个输入像素映射到单个的输出像素
                pil提供4种不同的采样滤镜(在目前的版本中
                                            后续的版本可能支持更多)
                    NEAREST	最近
                    BILINEAR	双线型
                    BICUBIC	双三次插值
                    ANTIALIAS	平滑

        打开图片:
            im = Image.open('filename')  
            调用im.show()会显示图片

        读写图片:
            pil中转换图片格式非常简单(转换图片模式是另一个概念，不要混淆)
                只需要调用img.save(filename)即可比如有一个bmp(位图)图片
                使用img = Image.open('file.bmp')打开后，只需要img.save
                ('file.jpg')即可转换。不过一般情况下，save(filename)是不
                用做这个用途的，通常，save用以保存一个临时的image对象到
                硬盘。而转换工作由一个功能更为强大的convert()方法来完成。
        拷贝，粘贴，合并:
                box = (100,100,500,500)#设置要拷贝的区域  
  
                #将im表示的图片对象拷贝到region中，大小为(400*400)像素。
                #这个region可以用来后续的操作(region其实就是一个Image对象)
                    #box变量是一个四元组(左，上，右，下)。  
                region = im.crop(box)  
  
                region = region.transpose(Image.ROTATE_180)
                    #从字面上就可以看出，先把region中的Image反转180度，
                    #然后再放回到region中。  
                im.paste(region, box)#粘贴box大小的region到原先的图片对象中
        
        前面说过，每一个RGB都是由三个通道的灰度图叠加的，
                所以pil提供了将这三个通道分离的方法
                r,g,b = im.split()#分割成三个通道  
                r.show()  
                g.show()  
                b.show()  
                im = Image.merge("RGB", (b, g, r))#将b,r两个通道进行翻转。
        几何转变:
                out = img.resize((128, 128))#resize成128*128像素大小。  
                out = img.rotate(45)#逆时针旋转45度 
        图片加强:
                import ImageFilter  
                out = im.filter(ImageFilter.DETAIL) 
            直接操作像素点:
                out = img.point(lambda i : i * 1.2)
                    #将每个像素点的亮度(不知道有没有更专业的词)增大20%
                    #注意这里用到一个匿名函数(那个可以把i的1.2倍返回的函数) 
    

