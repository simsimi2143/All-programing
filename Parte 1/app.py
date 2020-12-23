from flask import Flask,jsonify, render_template,request as req

array = {
    0:[],
    1:[],
    2:[],
    3:[],
}

app = Flask(__name__)



@app.route('/datos',methods=['POST'])
def Almacena():
    data = req.json
    array[0] = data['01']
    array[1] = data['25']
    array[2] = data['10']
    array[3] = data['te']
    print(array)
    return 'recibido- los datos han sido almacenados'


@app.route('/GetData')
def getdata():
    return array



if __name__ == '__main__':
    app.run(debug=True,port=5000)