#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import codecs
import time

# Parameters
wmsAttributesOnly = True
translateProjects = True
folderpath = 'C:/qgis/maintenance_db/cartoriviera/qgis_project/'
projects = ['qwat_sige_cartoriviera.qgs','qgep_sige_cartoriviera.qgs','cadastre_sige_cartoriviera.qgs']
mergeTranslationFile = 'traductions_qgis_server.txt'

def main():
    if translateProjects == True:
        QgsProject.instance().clear()
        filepaths = []
        for p in projects:
            QgsProject.instance().read(folderpath + p)
            #time.sleep(5) # Not needed because synchronous ?
            filepath = folderpath +  p + '.trad'
            filepaths.append(filepath)
            generateTranslationFile(filepath)
            print('Translation file generated: ' + filepath)
            
        QgsProject.instance().clear()
        
        # Merge translation files
        mergeTranslationFiles(filepaths, folderpath + mergeTranslationFile)
        print('Main translation file generated: ' + mergeTranslationFile)                
                
    else:
        filepath = '{0}{1}'.format(os.path.splitext(QgsProject.instance().fileName())[0],'.qgs.trad')
        generateTranslationFile(filepath)
        print('Translation file generated: ' + filepath)
        
    print('End of script execution')

def generateTranslationFile(file):
    fo = codecs.open(file, 'w', 'utf-8')

    uniqueAliases = {}
    for layer in QgsProject().instance().mapLayers().values():
        layerAliases = layer.attributeAliases()
        for key in layerAliases:
            if wmsAttributesOnly == False or isWmsAttribute(key, layer):
                if key not in uniqueAliases:
                    uniqueAliases[key] = layerAliases[key]

    for field in uniqueAliases:
        #print u'"{0}" "{1}",'.format(field, uniqueAliases[field])
        fo.write( u'msgid "{0}"\n'.format(field))
        fo.write( u'msgstr "{0}"\n'.format(uniqueAliases[field]))
        fo.write( u'\n')

    fo.close()

def isWmsAttribute(attribute, layerObject):
    wmsExcludedAttributes = list(layerObject.excludeAttributesWms())
    isWmsAttribute = attribute not in wmsExcludedAttributes
    return isWmsAttribute

def mergeTranslationFiles(inputFiles, outputFile):
    with open(outputFile, 'w') as outfile:
            for fp in inputFiles:
                with open(fp) as infile:
                    for line in infile:
                        outfile.write(line)
                        
main()