PIL：Python Imaging Library，已经是Python平台事实上的图像处理标准库了
        由于PIL仅支持到Python 2.7，加上年久失修，于是一群志愿者在PIL的基础
                上创建了兼容的版本，名字叫Pillow，支持最新Python 3.x
        安装Pillow:
            pip install pillow

    操作图像:
            from PIL import Image   #从这里导入库

            # 打开一个jpg图像文件，注意是当前路径:
            im = Image.open('test.jpg')
            # 获得图像尺寸:
            w, h = im.size
            print('Original image size: %sx%s' % (w, h))
            # 缩放到50%:
            im.thumbnail((w//2, h//2))
            print('Resize image to: %sx%s' % (w//2, h//2))
            # 把缩放后的图像用jpeg格式保存:
            im.save('thumbnail.jpg', 'jpeg')
    绘图方法:
            from PIL import Image, ImageDraw, ImageFont, ImageFilter

            import random

            # 随机字母:
            def rndChar():
                return chr(random.randint(65, 90))

            # 随机颜色1:
            def rndColor():
                return (random.randint(64, 255), random.randint(64, 255), random.randint(64, 255))

            # 随机颜色2:
            def rndColor2():
                return (random.randint(32, 127), random.randint(32, 127), random.randint(32, 127))
            
            # 240 x 60:
            width = 60 * 4
            height = 60
            image = Image.new('RGB', (width, height), (255, 255, 255))
            # 创建Font对象:
            font = ImageFont.truetype('Arial.ttf', 36)  #路径要对
            # 创建Draw对象:
            draw = ImageDraw.Draw(image)
            # 填充每个像素:
            for x in range(width):
                for y in range(height):
                    draw.point((x, y), fill=rndColor())
            # 输出文字:
            for t in range(4):
                draw.text((60 * t + 10, 10), rndChar(), font=font, fill=rndColor2())
            # 模糊:
            image = image.filter(ImageFilter.BLUR)
            image.save('code.jpg', 'jpeg')
字体类型：
        ImageFont类，类的实例存储bitmap字体，用于ImageDraw类的text()方法。
        类型：
            TrueType：
                采用几何学中二次B样条曲线及直线来描述字体的外形轮廓，
                其特点是：TrueType既可以作打印字体，又可以用作屏幕显示；
                由于它是由指令对字形进行描述，因此它与分辨率无关，输出时总
                是按照打印机的分辨率输出。无论放大或缩小，字符总是光滑的，
                不会有锯齿出现。但相对PostScript字体来说，其质量要差一些。
                特别是在文字太小时，就表现得不是很清楚。
            OpenType也叫Type 2字体:
                由Microsoft和Adobe公司开发的另外一种字体格式。它也是一种
                轮廓字体，比TrueType更为强大，最明显的一个好处就是可以在
                把PostScript字体嵌入到TrueType的软件中。并且还支持多个平
                台，支持很大的字符集，还有版权保护。可以说它是Type 1和
                TrueType的超集。
                OpenType的主要优点:
                    1）增强的跨平台功能 
                    2）更好的支持Unicode标准定义的国际字符集 
                    3）支持高级印刷控制能力 
                    4）生成的文件尺寸更小 
                    5）支持在字符集中加入数字签名，保证文件的集成功能。
    ImageFont模块的函数:
            ImageFont.load(file)
                从指定的文件中加载一种字体，该函数返回对应的字体对象
            ImageFont.load_path(file)
                和函数load()一样，但是如果没有指定当前路径的话，
                            会从sys.path开始查找指定的字体文件。
            ImageFont.truetype(file,size) :
                加载一个TrueType或者OpenType字体文件，并且创建一个字体对象。
            ImageFont.truetype(file,size, encoding=value):
                加载一个TrueType或者OpenType字体文件，并且使用指定的编码
                    方式创建一个字体对象
                    通常的编码方式有“unic”（Unicode）
                    ，“symb”（Microsoft Symbol）
                    ，“ADOB”（Adobe Standard）
                    ，“ADBE”（Adobe Expert）和“armn”（Apple Roman）
            ImageFont.load_default():
                加载一个默认的字体。
            font.getsize(text)⇒ (width, height):
                返回给定文本的宽度和高度，返回值为2元组

                









