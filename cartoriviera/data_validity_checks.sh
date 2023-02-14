#!/bin/bash

set -e

# Save IFS
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# Check and list invalid geometries in enquete_cadastre table
echo "*** Info check: list invalid geometries in enquete_cadastre table ***" 1>&2
query1="SELECT id, date_saisie FROM cadastre.enquete_cadastre WHERE ST_IsValid(geometry) IS FALSE"
for dbvalue in $(psql -t -q -U sige -d sige_commun -c $query1); do
  echo "$dbvalue" 1>&2
done

echo "" 1>&2

# Check and list outside of bounds geometries in enquete_cadastre table
echo "*** Info check: list enquete_cadastre table geometries that are outside of SIGE perimeter ***" 1>&2
query2="SELECT * FROM (SELECT id, date_saisie, ST_Contains(ST_MakeEnvelope(2540000, 1130000, 2570000, 1160000, 2056), ec.geometry) AS is_contained FROM cadastre.enquete_cadastre ec) AS subquery WHERE subquery.is_contained IS FALSE"
for dbvalue in $(psql -t -q -U sige -d sige_commun -c $query2); do
  echo "$dbvalue" 1>&2
done

echo "" 1>&2

# List enquete_cadastre table geometries that are outside of chenyx06 table bounds
echo "*** Critical check: list enquete_cadastre table geometries that are outside of chenyx06 table bounds ***" 1>&2
query3="\
WITH subquery1 AS ( \
  SELECT ST_Union(the_geom_lv95) AS geometry \
  FROM chenyx06.chenyx06_triangles), \
  subquery2 AS ( \
  SELECT *, ec.geometry AS geo, ST_Contains(subquery1.geometry, ec.geometry) AS is_contained \
  FROM subquery1, cadastre.enquete_cadastre ec \
  ) \
SELECT id, date_saisie, is_contained FROM subquery2 \
WHERE is_contained IS FALSE"
for dbvalue in $(psql -t -q -U sige -d sige_commun -c $query3); do
  echo "$dbvalue" 1>&2
done

echo "" 1>&2

# TODO Critical check: list invalid geometries in pressures zones table

# Redirect stdout to stderr
if [[ $MAILSTDOUT = true ]]; then
  echo "End of the script file." 1>&2
fi

# Restore $IFS
IFS=$SAVEIFS

