#Importacion de librerias necesarias
import sqlite3
from flask import Flask, render_template, jsonify, request as req
#diccionario de datos para almacenar coordenadas de cada vehiculo
gps={
    1:[],2:[],3:[],4:[],5:[],6:[],7:[],8:[],9:[],10:[]
    }
#conexion a la base de datos    
conection = sqlite3.connect("archives/gps.db")
consulta = conection.cursor()
#Varaiables que alamacenan la ejecucion de consultas de acuerdo al auto
#que se desea rastrear obteniendo longitudes y latitudes,ordenadas por fecha y hora
#para hacer un muestreo de datos mas preciso
vehiculo_1 = "SELECT lat, lon FROM data WHERE id=1 ORDER BY fecha ASC, hora ASC"
vehiculo_2 = "SELECT lat, lon FROM data WHERE id=2 ORDER BY fecha ASC, hora ASC"
vehiculo_3 = "SELECT lat, lon FROM data WHERE id=3 ORDER BY fecha ASC, hora ASC"
vehiculo_4 = "SELECT lat, lon FROM data WHERE id=4 ORDER BY fecha ASC, hora ASC"
vehiculo_5 = "SELECT lat, lon FROM data WHERE id=5 ORDER BY fecha ASC, hora ASC"
vehiculo_6 = "SELECT lat, lon FROM data WHERE id=6 ORDER BY fecha ASC, hora ASC"
vehiculo_7 = "SELECT lat, lon FROM data WHERE id=7 ORDER BY fecha ASC, hora ASC"
vehiculo_8 = "SELECT lat, lon FROM data WHERE id=8 ORDER BY fecha ASC, hora ASC"
vehiculo_9 = "SELECT lat, lon FROM data WHERE id=9 ORDER BY fecha ASC, hora ASC"
vehiculo_10 = "SELECT lat, lon FROM data WHERE id=10 ORDER BY fecha ASC, hora ASC"
#ejecutramos la consulta y con un ciclo for recorremos los datos de acuerdo 
#al vehiculo seleccionado, luego agregamos las coordendas como valores flotantes
#al diccionario que creamos para almacenar las coordenadas, deben de agregarse las
#coordenas al diccionario de acuerdo al id del autoconsultado, esto es para dar mas 
#orden al momento de almacenar. Se repite 10 veces el mismo proceso ejecutnado las 
#diez consultas por separado.

res_1 = consulta.execute(vehiculo_1)
for i in res_1:
   arr = [float(i[0]),float(i[1])]
   gps[1].append(arr)
res_2 = consulta.execute(vehiculo_2)
for i in res_2:
   arr = [float(i[0]),float(i[1])]
   gps[2].append(arr)
res_3 = consulta.execute(vehiculo_4)
for i in res_3:
   arr = [float(i[0]),float(i[1])]
   gps[3].append(arr)
res_4 = consulta.execute(vehiculo_4)
for i in res_4:
   arr = [float(i[0]),float(i[1])]
   gps[4].append(arr)
res_5 = consulta.execute(vehiculo_5)
for i in res_5:
   arr = [float(i[0]),float(i[1])]
   gps[5].append(arr)
res_6 = consulta.execute(vehiculo_6)
for i in res_6:
   arr = [float(i[0]),float(i[1])]
   gps[6].append(arr)
res_7 = consulta.execute(vehiculo_7)
for i in res_7:
   arr = [float(i[0]),float(i[1])]
   gps[7].append(arr)
res_8 = consulta.execute(vehiculo_8)
for i in res_8:
   arr = [float(i[0]),float(i[1])]
   gps[8].append(arr)
res_9 = consulta.execute(vehiculo_9)
for i in res_9:
   arr = [float(i[0]),float(i[1])]
   gps[9].append(arr)
res_10 = consulta.execute(vehiculo_10)  
for i in res_10:
   arr = [float(i[0]),float(i[1])]
   gps[10].append(arr)

#Cremaos una variable con la que arrancaremos nuestro
#server de flask 
app = Flask(__name__)
#indicamos el elemento que se cargara inicialmente al
#arrancar el server 
@app.route("/")
def index():
    return render_template("gps.html")
#en esta ruta se envian todos los datos contenidos en 
#el diccionario
@app.route('/GetData')
def getdata():
    return gps
#arrancamos el servidor de flask
if __name__ == "__main__":
   app.run(debug=True,host='127.0.0.1',port=5000)