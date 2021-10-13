from flask import Flask,json
app = Flask(__name__)

@app.route('/tree', methods=['GET'])
def apiserver():
    return json.dumps({"myFavouriteTree":"Tree1"})


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')