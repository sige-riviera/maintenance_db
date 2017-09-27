
BEGIN;

ALTER TABLE cartoriviera.sige_qgis_qgep_reach                ALTER COLUMN progression_geometry TYPE Geometry(CompoundCurveZ, 21781) USING ST_GeomFromEWKB(ST_Fineltra(progression_geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
ALTER TABLE cartoriviera.sige_qgis_qgep_wastewater_structure ALTER COLUMN situation_geometry   TYPE Geometry(MultiPoint, 21781)     USING ST_GeomFromEWKB(ST_Fineltra(situation_geometry,   'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));

COMMIT;
