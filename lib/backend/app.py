from flask import Flask, jsonify
from flask_cors import CORS, cross_origin

app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'


@cross_origin()
@app.route('/output', methods=['GET'])
def index():
    return jsonify({'poem': 'Hi! Hope this worked.'})


if __name__ == "__main__":
    app.run(debug=True)
