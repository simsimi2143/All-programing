from flask import Flask,jsonify, render_template,request as req
import random as ra
import telepot as tele 
import base64
from flask_cors import CORS

bot = tele.Bot('1476965669:AAE5aFy5OVOzoqZEqeCF-X1U8AC1Vd7JmPM')
chat_ID = 1476646604

dD = { 'k':[0,0,0,0,0] }

app = Flask(__name__)

# funcion que creara el server flask con los datos recibidos del html
CORS(app, resources={r'/*'})
@app.route('/')
def index():
    return render_template('Telegram.html')


@app.route('/telegram',methods=['POST'])
def putdata():
    dJ = req.json
    dD['k'] = [dJ['mp01'],dJ['mp25'],dJ['mp10'],dJ['amte']]    
    print(dD['k'])
    return 'Vamos Bien - OK'


@app.route('/GetData')
def getdata():
    return dD


@app.route('/postimg', methods = ['POST'])
def postimg():
    img = req.get_data()
    print(img)
    img = img.decode('utf-8')
    imgfinal = img.replace("img=","")
    imgData = base64.b64decode(imgfinal)
    filename = 'grafico.png'
    with open(filename, 'wb') as f:
       f.write(imgData)
       f.close()
    bot.sendPhoto(1476646604, open("grafico.png",'rb'))
    return "ok"

if __name__ == '__main__':
    app.run(debug=True,port=5000)