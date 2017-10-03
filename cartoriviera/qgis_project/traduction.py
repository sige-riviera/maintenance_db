#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs

file = '{0}{1}'.format(QgsProject.instance().fileName(),'.trad')
fo = codecs.open(file, 'w', 'utf-8')

for layer in QgsMapLayerRegistry.instance().mapLayers().values():
    aliases = layer.attributeAliases()
    for field in aliases:
        print u'"{0}": "{1}",'.format(field, aliases[field])
        fo.write( u'"{0}": "{1}",\n'.format(field, aliases[field]))

fo.close()
