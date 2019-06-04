# -*- coding: utf-8 -*-
"""
Created on Wed Apr  3 23:56:13 2019

@author: saikr
"""
from flask import Flask, render_template, request
from werkzeug import secure_filename
import os

app = Flask(__name__)

@app.route('/')
@app.route('/text')
def initialpage():
   return render_template('text.html',)

#replace path on which to save images
app.config['UPLOAD_PATH'] = os.getcwd() 
@app.route('/afterfileupload', methods = ['GET', 'POST'])
def upload_file():
   if request.method == 'POST':
      files = request.files
      #print(files)
      #print(files.fileinput)
      print("saving files")
      if not os.path.exists(os.path.join(os.getcwd(), 'uploaded_images')):
          os.mkdir(os.path.join(os.getcwd(),'uploaded_images'))
      alltext=""
      for f in files.getlist('fileinput'):          
          print(f.filename) 
          f.save(os.path.join(os.getcwd()+'\\uploaded_images',secure_filename(f.filename)))
          alltext+=extract_text(os.path.join(os.getcwd()+'\\uploaded_images\\'+f.filename))
          alltext=alltext.replace('\n', '<br>')          
          os.remove(os.path.join(os.getcwd()+'\\uploaded_images\\'+f.filename))
      return '<p>'+alltext+'</p>'




 
def extract_text(path):
 
  #if len(sys.argv) < 2:
    #print('Usage: python ocr_simple.py image.jpg')
    #sys.exit(1)
    #pass
  # Read image path from command line
  #imPath = sys.argv[1]
     
  # Uncomment the line below to provide path to tesseract manually
  # pytesseract.pytesseract.tesseract_cmd = '/usr/bin/tesseract'
 
  # Define config parameters.
  # '-l eng'  for using the English language
  # '--oem 1' for using LSTM OCR Engine
  config = ('-l eng --oem 1 --psm 3')
  import cv2
  import pytesseract
  from PIL import Image, ImageEnhance, ImageFilter
  image = cv2.imread(path)
  edged = cv2.Canny(image, 100, 200)
  (cnts, _) = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
  idx = 0
  for c in cnts:
    x,y,w,h = cv2.boundingRect(c)
    if w>500 and h>500:
        idx+=1
        new_img=image[y:y+h,x:x+w]
        cv2.imwrite(str(idx)+ '.jpg', new_img)
        break
  #path = input()
  #path=path+'.jpg'
  #import pytesseract
#from PIL import Image, ImageEnhance, ImageFilter
  croppath='1.jpg'
  im = Image.open(croppath) # the second one 
  im = im.filter(ImageFilter.MedianFilter())
  enhancer = ImageEnhance.Contrast(im)
  im = enhancer.enhance(2)#can change this best around 2

  #im = im.convert('1')
  im.save('temp.jpg')
  
  # Read image from disk
  #im = cv2.imread(imPath, cv2.IMREAD_COLOR)
  #im=cv2.imread("aftercanny1.jpg",cv2.IMREAD_COLOR)#cv2.IMREAD_REDUCED_COLOR_2
#  lower_white = np.array([220, 220, 220], dtype=np.uint8)
#  upper_white = np.array([255, 255, 255], dtype=np.uint8)
  img=cv2.imread('temp.jpg',cv2.IMREAD_REDUCED_COLOR_4)
  
 # im=cv2.imread('crop_0bPfceHhddd.jpg',cv2.COLOR_BGR2GRAY)
  # Run tesseract OCR on image
  #Image.fromarray(img)
  text = pytesseract.image_to_string(img, config=config)
  os.remove('1.jpg')
  os.remove('temp.jpg')
  # Print recognized text
  #print(text)
  return text

if __name__ == '__main__':
   app.run()
