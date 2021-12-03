import cv2
import glob
import re
import os

def numericalSort(value):
    numbers = re.compile(r'(\d+)')
    parts = numbers.split(value)
    parts[1::2] = map(int, parts[1::2])
    return parts
                     
def create_vid(video_name, img_dir, fps):
    img_array = []
    for filename in sorted(glob.glob(os.path.join(img_dir, '*.png')), key=numericalSort):
        img = cv2.imread(filename)
        img_array.append(img) 

    video = cv2.VideoWriter(video_name, cv2.VideoWriter_fourcc(*'DIVX'), fps, img.shape[1::-1])
 
    for i in range(len(img_array)):
        video.write(img_array[i])
    video.release()
