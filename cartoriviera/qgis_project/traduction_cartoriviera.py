#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import codecs
import time

# Parameters
translateProjects = True
folderpath = 'C:/qgis/maintenance_db/cartoriviera/qgis_project/'
projects = ['qwat_sige_cartoriviera.qgs','qgep_sige_cartoriviera.qgs','cadastre_sige_cartoriviera.qgs']

def main():
    if translateProjects == True:
        QgsProject.instance().clear()
        for p in projects:
            q = QgsProject.instance().read(folderpath + p)
            #time.sleep(5)
            f = folderpath + p + '.trad'
            generateTranslationFile(f)
            print('Translation file generated: ' + f)
            
    else:
        f = '{0}{1}'.format(os.path.splitext(QgsProject.instance().fileName())[0],'.qgs.trad')
        print('Translation file generated: ' + f)
        
    print('End of script execution')


def generateTranslationFile(filepath):
    fo = codecs.open(file, 'w', 'utf-8')

    uniqueAliases = {}
    for layer in QgsProject().instance().mapLayers().values():
        layerAliases = layer.attributeAliases()
        for key in layerAliases:
            if key not in uniqueAliases:
                uniqueAliases[key] = layerAliases[key]

    for field in uniqueAliases:
        #print u'"{0}" "{1}",'.format(field, uniqueAliases[field])
        fo.write( u'msgid "{0}"\n'.format(field))
        fo.write( u'msgstr "{0}"\n'.format(uniqueAliases[field]))
        fo.write( u'\n')

    fo.close()

main()