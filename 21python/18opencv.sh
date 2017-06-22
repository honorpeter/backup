install : 
        sudo apt-get install python-opencv
        pip install opencv-python
        pip install opencv-python==2.4.9
import cv2:
    打开图像：
        img = cv2.imread('messi5.jpg',0)

        cv2.IMREAD_COLOR : Loads a color image. Any transparency of image 
            will be neglected. It is the default flag.
        cv2.IMREAD_GRAYSCALE : Loads image in grayscale mode
        cv2.IMREAD_UNCHANGED : Loads image as such including alpha channel

        cv2.namedWindow('image', cv2.WINDOW_NORMAL)
        cv2.imshow('image',img)
        cv2.waitKey(0)
        cv2.destroyAllWindows() 

    Write an image:
        cv2.imwrite('messigray.png',img)

    resize image:
        res = cv2.resize(img,None,fx=2, fy=2, interpolation = cv2.INTER_CUBIC)
        或则：
        height, width = img.shape[:2]
        res = cv2.resize(img,(2*width, 2*height), interpolation = cv2.INTER_CUBIC)

    RGB图像转化为灰度图：
        img = cv2.cvtColor( img, cv2.COLOR_RGB2GRAY )

    









