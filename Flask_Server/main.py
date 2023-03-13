import os
import werkzeug
from flask import Flask, request, jsonify
from mlmodel import getPredict

app = Flask(__name__)

ALLOW_FLIE_TYPE = {'png','jpg','jpeg'}

# @app.route('/', methods=['GET'])
# def welcome():
#     return "hello world"

# def is_allowed(filename):
#     return '.' in filename and filename.rsplit('.',1)[1].lower() in ALLOW_FLIE_TYPE

# @app.route('/upload', methods=['POST'])
# def predictfn ():
#     if 'file' not in request.files:
#         return jsonify({'error': 'no-file'})

#     file = request.files['file']

#     if file.filename == '':
#         return jsonify({'error': 'no-filename'})

#     if not is_allowed(file.filename):
#         return jsonify({'error': 'not-a-valid-file-type'})

#     # perform prediction
#     prediction = getPredict(file.filename)

#     # return prediction result
#     return prediction

@app.route('/upload', methods = ['POST'])
def upload():
    if (request.method == 'POST'):
        imageFile = request.files['image']
        filename = werkzeug.utils.secure_filename(imageFile.filename)
        imageFile.save("./upload/" + filename)
        # return jsonify({
        #     "message" : "Image sucessfully Uplaoded"
        # })
        #     # perform prediction
        prediction = getPredict("./upload/" + filename)

        # return prediction result
        return prediction
    
if __name__ == '__main__':
    app.run(debug=True, port=4000)
