#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import codecs

file = '{0}{1}'.format(os.path.splitext(QgsProject.instance().fileName())[0],'_v23.qgs.trad')
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
