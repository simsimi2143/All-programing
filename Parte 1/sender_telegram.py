import requests as req, time as ti, random as ra, datetime as dt

sURL = 'http://127.0.0.1:5000/telegram'

def Generate():
    dData = {
             'mp01': ra.randint(5,20), #ug/m3
             'mp25': ra.randint(5,80), #ug/m3
             'mp10': ra.randint(5,80), #ug/m3
             'amte': ra.randint(10,20) #10C - 20C
            }
    return dData

while 1:
 dData = Generate()
 MyCnx = req.post(sURL,json=dData)
 print(str(dt.datetime.now())[11:19] + '->' + MyCnx.text)
 ti.sleep(5)
MyCnx.close()         