from flask import Flask,jsonify
app = Flask(__name__)

@app.route('/tree', methods=['GET'])
def apiserver():
    return jsonify({"myFavouriteTree":"Tree1"})


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')