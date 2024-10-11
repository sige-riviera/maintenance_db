-- PGSERVICE=qwat_prod psql -v ON_ERROR_STOP=on -f cartoriviera/export_db/qwat_node.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_qwat_node;

CREATE TABLE usr_cartoriviera.sige_qgis_qwat_node AS
SELECT id,
    _pipe_node_type,
    _pipe_orientation,
    geometry
FROM qwat_od.node
WHERE _pipe_node_type IS NOT NULL;

ALTER TABLE usr_cartoriviera.sige_qgis_qwat_node ALTER COLUMN _pipe_node_type TYPE text USING _pipe_node_type::text;
ALTER TABLE usr_cartoriviera.sige_qgis_qwat_node ALTER COLUMN geometry TYPE geometry('point', 2056) USING ST_Force2D(geometry);

CREATE INDEX geoidx_sige_qgis_qwat_node
ON usr_cartoriviera.sige_qgis_qwat_node
USING gist (geometry);
