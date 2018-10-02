#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs

file = '{0}{1}'.format(QgsProject.instance().fileName(),'.trad')
fo = codecs.open(file, 'w', 'utf-8')

uniqueAliases = {}
for layer in QgsMapLayerRegistry.instance().mapLayers().values():
    layerAliases = layer.attributeAliases()
    for key in layerAliases:
        if key not in uniqueAliases:
            uniqueAliases[key] = layerAliases[key]

for field in uniqueAliases:
    print u'"{0}": "{1}",'.format(field, uniqueAliases[field])
    fo.write( u'"{0}": "{1}",\n'.format(field, uniqueAliases[field]))

fo.close()
