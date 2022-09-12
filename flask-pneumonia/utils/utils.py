import cv2
import numpy as np
from tensorflow.keras.applications.resnet50 import preprocess_input
import calendar
import datetime


class Utils:
    MAP_PREDICTIONS = {
        2:'Pneumonia Viral',
        1:'Pneumonia Bacteriana',
        0:'Saudável'
    }
    @staticmethod
    def imgToNpArray(image_src):
        img = cv2.imread(image_src)
        img = cv2.resize(img,(224,224),3)
        img_np = np.array(img)
        img_np = preprocess_input(img_np) 
        img_np = img_np.reshape(224,224,3)
        return img_np

    @staticmethod
    def getUTCTimeStamp():
        current_datetime = datetime.datetime.utcnow()
        current_timetuple = current_datetime.utctimetuple()
        current_timestamp = calendar.timegm(current_timetuple)
        return current_timestamp