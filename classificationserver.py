from flask import Flask, render_template, request
from werkzeug import secure_filename
import os
from keras.models import model_from_json
import tensorflow as tf
import numpy as np
from keras.preprocessing import image
import shutil
#from classifytofolders import classification
app = Flask(__name__)

@app.route('/')
def initialpage():
   return render_template('home.html',)

#replace path on which to save images
app.config['UPLOAD_PATH'] = os.getcwd() 
@app.route('/classify', methods = [ 'POST'])
def classify():
    
    if request.method == 'POST':              
        files = request.files     
        for f in files.getlist('fileinput'):
            print(f.filename)               
            f.save(os.path.join(os.getcwd(),secure_filename(f.filename)))
            filename=f.filename
            graph1 = tf.Graph()
          
            with graph1.as_default():
                session1 = tf.Session()
                with session1.as_default():
                    with open('model.json') as arch_file:
                        classifier = model_from_json(arch_file.read())           
                        classifier.load_weights("model.h5")
                        test_image = image.load_img(filename, target_size = (64, 64))
                        test_image = image.img_to_array(test_image)
                        test_image = np.expand_dims(test_image, axis = 0)
                        result = classifier.predict(test_image)
            
            if result[0][0] == 1:
                             
                newfilename=filename        
                if not os.path.exists(os.path.join(os.getcwd(), 'obd')):
                    os.mkdir(os.path.join(os.getcwd(),"obd"))
                else:
                    while(os.path.isfile(os.path.join("obd",newfilename))):
                        newfilename="1"+newfilename
            
                shutil.move(filename,os.path.join(os.path.join(os.getcwd(),"obd/"),newfilename))
            else:
                newfilename=filename
                if not os.path.exists(os.path.join(os.getcwd(), 'non_obd')):
                    os.mkdir(os.path.join(os.getcwd(),"non_obd"))
                else:
                    while(os.path.isfile(os.path.join("non_obd",newfilename))):
                        newfilename="1"+newfilename
                shutil.move(filename,os.path.join(os.path.join(os.getcwd(),"non_obd/"),newfilename))
    
        return render_template('success.html',)
  
app.run(host="0.0.0.0",port=5000)
