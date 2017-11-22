#!/bin/bash



gsed -r 's/"sige_qgis_cartoriviera"\."(.*?)"/"sige_qgis_cartoriviera"."\1_mn95"/g' qgep.qgs > qgep_mn95.qgs
gsed -i -r 's/21781/2056/g' qgep_mn95.qgs

gsed -r 's/"sige_qgis_cartoriviera"\."(.*?)"/"sige_qgis_cartoriviera"."\1_mn95"/g' qwat.qgs > qwat_mn95.qgs
gsed -i -r 's/21781/2056/g' qwat_mn95.qgs

gsed -r 's/"sige_qgis_cartoriviera"\."(.*?)"/"sige_qgis_cartoriviera"."\1_mn95"/g' cadastre_sige.qgs > cadastre_sige_mn95.qgs
gsed -i -r 's/21781/2056/g' cadastre_sige_mn95.qgs
