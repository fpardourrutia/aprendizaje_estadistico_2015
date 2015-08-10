#!/usr/local/bin/python
# -*- coding: utf-8 -*-

import os
import sys
import re
import argparse
import dropbox
import zipfile
import datetime
ACCESS_TYPE = 'app_folder'

APP_KEY=os.environ['KEY_POSTS']
APP_SECRET=os.environ['APP_SECRET']
auth_token=os.environ['AUTH']


def subir_dropbox(archivo):
    client = dropbox.client.DropboxClient(auth_token)
    f = open(archivo, 'rb')
    nom_archivo = archivo.split('/')[-1]
    response = client.put_file('/'+nom_archivo, f)
    #f, metadata = client.get_file_and_metadata('/'+nom_archivo)
    liga = client.share('/'+nom_archivo, short_url=False)

    return liga



def crear_post(liga, titulo = 'post'):
    ahora = datetime.datetime.now()
    liga_down = liga.split('?')[0]+'?dl=1'
    posts_dir = '/Users/felipegonzalez/Repositorios/sitio_aprendizaje_estadistico_2015/_drafts/'
    filename = str(ahora.year)+'-'+str(ahora.month).zfill(2)+'-'+str(ahora.day).zfill(2)+'-'+titulo+'.markdown'
    print 'Crear post: ' + posts_dir+filename

    if os.path.exists(posts_dir + filename):
        print "Error: Archivo ya existe"
        return
    f = open(posts_dir + filename, 'w')
    f.write('---\n')
    f.write('layout: post\n')
    f.write('title:  \'%s\'\n' %titulo)
    f.write('categories: clase\n')
    f.write('---\n\n')
    f.write('[Material]( %s )' % liga_down)
    f.close()
    return 1







def  preparar_zip(carpeta):
    nombre_zip = carpeta.split('/')[-1]
    dst = '/Users/felipegonzalez/Downloads/'+nombre_zip
    print 'Destino zip: ' + dst
    zf = zipfile.ZipFile("%s.zip" % (dst), "w", zipfile.ZIP_DEFLATED)
    abs_src = os.path.abspath(carpeta)
    for dirname, subdirs, files in os.walk(carpeta):
        if 'temp' not in dirname: 
            for filename in files:
                absname = os.path.abspath(os.path.join(dirname, filename))
                arcname = absname[len(abs_src) + 1:]
                print 'zipping %s as %s' % (os.path.join(dirname, filename), arcname)
                zf.write(absname, arcname)
    zf.close()
    return "%s.zip" % (dst)

    



if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Crear post de jekyll, subir a dropbox.')
    parser.add_argument('carpeta', help='carpeta a procesar', action='store')
    args = parser.parse_args()
    archivos = os.listdir(args.carpeta)
    zip_nom = preparar_zip(args.carpeta)
    resultado = subir_dropbox(zip_nom)
    print resultado['url']
    res = crear_post(liga = resultado['url'])
    print res

    ## hacer post

    



