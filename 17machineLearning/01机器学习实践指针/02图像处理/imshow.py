#!/usr/bin/env python
import cv2
fn = "hh.jpg"
print 'loading %s ..' % fn
img = cv2.imread(fn)
cv2.imshow('preview',img)
cv2.waitKey()
#cv2.destroyAllWindows()









