from flask import Flask, jsonify, request
from flask_cors import CORS, cross_origin
import json

app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

response = ''


# PART-1 : Getting the user's input.
@cross_origin()
@app.route('/input', methods=['POST'])
def seedRoute():
    global response
    request_data = request.data
    request_data = json.loads(request_data.decode('utf-8'))
    seed = request_data['seed']
    response = seed
    return " "


# PART-2 : The variable 'response' can be used to...


# PART-3 : Sending the ML model's output to the webpage.
@cross_origin()
@app.route('/output', methods=['GET'])
def index():
    return jsonify({'poem': response})


if __name__ == "__main__":
    app.run(debug=True)
