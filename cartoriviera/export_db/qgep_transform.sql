
BEGIN;

create table usr_cartoriviera.sige_qgis_qgep_reach as select * from usr_cartoriviera.sige_qgis_qgep_reach_mn95;
create table usr_cartoriviera.sige_qgis_qgep_wastewater_structure as select * from usr_cartoriviera.sige_qgis_qgep_wastewater_structure_mn95;

ALTER TABLE usr_cartoriviera.sige_qgis_qgep_reach ALTER COLUMN progression_geometry TYPE Geometry(MultiLineString, 21781) USING ST_GeomFromEWKB(ST_Fineltra(progression_geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
ALTER TABLE usr_cartoriviera.sige_qgis_qgep_wastewater_structure ALTER COLUMN situation_geometry TYPE Geometry(Point, 21781) USING ST_GeomFromEWKB(ST_Fineltra(situation_geometry,   'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));

COMMIT;
