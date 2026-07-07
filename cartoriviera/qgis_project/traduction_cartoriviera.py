#!/usr/bin/env python
# -*- coding: utf-8 -*-

# This script write translations values between fields and alias for projects used in Cartoriviera
# TODO: It could be interesting to prefix all fields names of Cartoriviera QGIS SIGE projects with 
# something like 'sige_qwat_' in order to avoid any conflict with Cartoriviera main translation file. 
# See with Cartoriviera manager.

import os
import codecs
import time

# General parameters
wmsAttributesOnly = True

# Parameters to write translations for a list of projects (translateProjects = False) instead of the current project
translateProjects = True
folderpath = 'C:/qgis/maintenance_db/cartoriviera/qgis_project/'
projects = ['qwat_sige_cartoriviera.qgs','qgep_sige_cartoriviera.qgs','cadastre_sige_cartoriviera.qgs']
mergeTranslationFile = 'traductions_sige.txt'
hardcodedTranslationFile = 'traductions_hardcoded.txt'

def main():
    if translateProjects == True:
        QgsProject.instance().clear()
        filepaths = []
        for p in projects:
            QgsProject.instance().read(folderpath + p)
            #time.sleep(5) # Not needed because synchronous ?
            filepath = folderpath +  p + '.trad'
            filepaths.append(filepath)
            generateTranslationFile(filepath, p)
            print('Translation file generated: ' + filepath)
            
        QgsProject.instance().clear()
        
        # Merge translation files
        mergeTranslationFiles(filepaths, folderpath + mergeTranslationFile)
        print('Main translation file generated: ' + mergeTranslationFile)                
                
    else:
        filepath = '{0}{1}'.format(os.path.splitext(QgsProject.instance().fileName())[0],'.qgs.trad')
        generateTranslationFile(filepath, p)
        print('Translation file generated: ' + filepath)
        
    print('End of script execution')

def generateTranslationFile(file, projectName):
    fo = codecs.open(file, 'w', 'utf-8')

    # Nom du projet (qwat, qgep, cadastre...)
    projectPrefix = projectName.split('_')[0]

    fo.write(u'## START {0} SIGE\n\n'.format(projectPrefix))

    uniqueAliases = {}
    for layer in QgsProject().instance().mapLayers().values():
        layerAliases = layer.attributeAliases()
        for key in layerAliases:
            if wmsAttributesOnly == False or isWmsAttribute(key, layer):
                if key not in uniqueAliases:
                    uniqueAliases[key] = layerAliases[key]

    # Tri alphanumérique sur les msgid
    for field in sorted(uniqueAliases.keys()):
        translation = uniqueAliases[field]

        # Ignore les traductions vides
        if not translation:
            continue

        fo.write(u'msgid "{0}"\n'.format(field))
        fo.write(u'msgstr "{0}"\n'.format(translation))
        fo.write(u'\n')

    fo.write(u'## END {0} SIGE\n\n'.format(projectPrefix))

    fo.close()

def isWmsAttribute(attribute, layerObject):
    wmsExcludedAttributes = list(layerObject.excludeAttributesWms())
    isWmsAttribute = attribute not in wmsExcludedAttributes
    return isWmsAttribute

def mergeTranslationFiles(inputFiles, outputFile):
    with open(outputFile, 'w', encoding='utf-8') as outfile:
        outfile.write('\n# DEBUT SIGE\n\n')

        # Fusion des fichiers .trad
        for fp in inputFiles:
            with open(fp, encoding='utf-8') as infile:
                for line in infile:
                    outfile.write(line)

        # Ajout des traductions hardcodées
        hardcodedFile = os.path.join(folderpath, hardcodedTranslationFile)
        if os.path.exists(hardcodedFile):
            with open(hardcodedFile, encoding='utf-8') as infile:
                for line in infile:
                    outfile.write(line)

            # Garantit une fin de ligne si le fichier n'en possède pas
            if 'line' in locals() and not line.endswith('\n'):
                outfile.write('\n')

            # Une ligne vide avant # FIN SIGE
            outfile.write('\n')

        outfile.write('# FIN SIGE\n')
                        
main()