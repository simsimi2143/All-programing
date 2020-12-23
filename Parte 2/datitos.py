import requests as req,time as ti, random as ra

sURL = 'http://127.0.0.1:5000/datos'

def generate():
    dData = {                                               #Datos ambientales
            
            '01': [ra.randint(+5, +20) for i in range(5)], # MP 1.0 ug/m3
            '25': [ra.randint(+5, +20) for i in range (5)],# MP 2.5 ug/m3
            '10': [ra.randint(+5, +20) for i in range(5)], # MP 10 ug/m3
            }
    return dData

while 1:
    dData = generate()
    MyCnx = req.post(sURL,json=dData)
    ti.sleep(5)
MyCnx.close()

