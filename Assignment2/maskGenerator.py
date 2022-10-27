import cv2
import pytesseract
import os
import numpy as np
# load the original input image and display it to our screen
image = cv2.imread("dst_10.png")

# hsv=cv2.cvtColor(image,cv2.COLOR_BGR2HSV)
# lower_blue=np.array([255,255,255])
# upper_blue=np.array([255,255,255])
# mask=cv2.inRange(image,lower_blue,upper_blue)
# res=cv2.bitwise_and(image,image,mask= mask)

# kernel = np.ones((5, 5), np.uint8)
# mask = cv2.dilate(mask, kernel, iterations=1)
# mask = cv2.erode(mask, kernel, iterations=1)
# mask = cv2.dilate(mask, kernel, iterations=1)


# cv2.imshow('frame',image)
# cv2.imshow('mask',mask)
# cv2.imshow('res',res)


#calculate the 50 percent of original dimensions
width = 474
height = 355

# dsize
dsize = (width, height)

# resize image
output = cv2.resize(image, dsize)
cv2.imwrite("dst_10.png", output)





cv2.waitKey(0)