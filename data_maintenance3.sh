#!/bin/bash

set -e 

export PGOPTIONS='--client-min-messages=warning'

# Après avoir accroché une conduite (ou toute autre ligne) à une autre sans avoir préalablement créé un nœud d'intersection,
# le découpage de la conduite à l'aide de l'outil de coupage de QGIS, au droit du T formé, génère des valeurs NaN pour la
# coordonnée Z dans une ou plusieurs géométries. Ce comportement est attendu de la part de QGIS dans ce contexte,
# cependant la présence de ces valeurs NaN pose problème lors de la génération des vues schématiques.
# Il convient donc de les détecter pour les corriger (voir script a disposition).

IDS=$(psql -U sige -d qwat_prod -c "SELECT DISTINCT pipe.id
FROM qwat_od.pipe AS pipe
WHERE
    EXISTS (
        SELECT 1 FROM st_dumppoints(pipe.geometry) AS dp
        WHERE st_z(dp.geom) = 'NaN'::double precision
    )
    OR EXISTS (
        SELECT 1 FROM st_dumppoints(pipe.geometry_alt1) AS dp
        WHERE st_z(dp.geom) = 'NaN'::double precision
    )
    OR EXISTS (
        SELECT 1 FROM st_dumppoints(pipe.geometry_alt2) AS dp
        WHERE st_z(dp.geom) = 'NaN'::double precision
    )
ORDER BY pipe.id;
")

# Format id values for better rendering
FORMATTED_IDS=$(echo "$IDS" | sed '/^\s*$/d' | sort -n)

# Print message
echo -e "These pipes (id) have NaN z-coordinates in one or more of their geometries (geometry, geometry_alt1, geometry_alt2):\n" 1>&2
echo "$FORMATTED_IDS" 1>&2


# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi
