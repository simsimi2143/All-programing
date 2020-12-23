import sqlite3
import pandas as pd 

dd = pd.read_csv('archives/rutas.csv')
dd = pd.DataFrame(dd)

conexion = sqlite3.connect('archives/gps.db')
consulta = conexion.cursor()

insert = """ 
        INSERT INTO data(npk, id, lat, lon, velo, angu, fecha, hora, gnoff, nsat)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """

for e in range(len(dd['npk'])):
    arg = (int(dd['npk'][e]),int(dd['id'][e]),float(dd['lat'][e]),float(dd['lot'][e]),
            int(dd['velo'][e]),int(dd['angu'][e]),dd['fecha'][e], dd['hora'][e], int(dd['gnoff'][e]),int(dd['nsat'][e]) )
    if(consulta.execute(insert,arg)):
        print("dato ",e," ingresados")

consulta.close()
conexion.commit()