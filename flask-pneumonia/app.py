from msilib.schema import Directory
import os
import platform
import cv2
import tensorflow as tf
import matplotlib.pyplot as plt
import numpy as np
from lime import lime_image
from skimage.segmentation import mark_boundaries, find_boundaries
from flask import Flask, request,send_from_directory
from flask_cors import CORS, cross_origin
from utils.utils import Utils
from werkzeug.utils import secure_filename
from waitress import serve

#   #return img
# test_img_url = './raio-x.jpg'
# explanation = explainer.explain_instance(Utils.imgToNpArray(test_img_url).astype('double'), model.predict,
#                                         top_labels=3, hide_color=0, num_samples=1000)
# print(explanation.top_labels)
# print(explanation.local_pred)
# temp_1, mask_1 = explanation.get_image_and_mask(explanation.top_labels[0], num_features=25,positive_only=False, hide_rest=False)
# img = cv2.imread(test_img_url)
# img = cv2.resize(img,(224,224),3)
# img_np = np.array(img)

# plt.figure(figsize=(8,8))
# plt.imshow(mark_boundaries(img_np, mask_1,color=(0,255,255),mode='outer',background_label=0))
# plt.axis('off')
# plt.savefig('prediction.jpg')


app = Flask(__name__)
cors = CORS(app, resources={
    r"/*": {
        "origins": '*'
    }
})

explainer = lime_image.LimeImageExplainer()

model = tf.keras.models.load_model('./best_model.hdf5')

'''ENDPOINT QUE RECEBE IMAGEM SALVA E REALIZA A PREDIÇÃO COM TENSORFLOW E LIME'''
@app.route("/predictImageFile", methods=["POST"])
def predictImageFile():
    body = request.form.to_dict()
    file = request.files['archive']

    '''Salvando imagem do raiox na pasta images'''
    path = secure_filename(f"{Utils.getUTCTimeStamp()}.{body['extensao']}")
    file.save(os.path.join('./images', path))
    return predict_with_lime(path,body)

'''Aplicação do LIME e retorno de um dict com as probabilidades e o nome do arquivo para consulta posterior'''

def predict_with_lime(path:str,body:dict) -> dict:
    explanation = explainer.explain_instance(Utils.imgToNpArray(f'./images/{path}').astype('double'), model.predict,
                                            top_labels=3, hide_color=0, num_samples=1000)
    temp_1, mask_1 = explanation.get_image_and_mask(explanation.top_labels[0], num_features=25,positive_only=False, hide_rest=False)
    img = cv2.imread(f'./images/{path}')
    img = cv2.resize(img,(224,224),3)
    img_np = np.array(img)

    plt.figure(figsize=(8,8))
    plt.imshow(mark_boundaries(img_np, mask_1,color=(0,255,255),mode='outer',background_label=0))
    plt.axis('off')
    lime_file_name =f"{Utils.getUTCTimeStamp()}.{body['extensao']}"
    plt.savefig(f"./images/{lime_file_name}")
    return {'predicted_class':Utils.MAP_PREDICTIONS[explanation.top_labels[0]],'confidence':explanation.local_pred[0],'lime_file_name':lime_file_name}

@app.route("/downloadArquivoByNome",methods=["GET"])
def downloadArquivoByNome():
    params = request.args.to_dict()
    print(params)
    file_name = params['file_name']
    directory = f"./images/"
    return send_from_directory(directory,file_name, as_attachment=True) 
if(platform.system() == 'Windows'):
    # Debug mode Windows
    app.run(host='0.0.0.0', port=5000)
else:
    # Production mode Ubuntu
    serve(app, host="0.0.0.0", port=443, threads=100)