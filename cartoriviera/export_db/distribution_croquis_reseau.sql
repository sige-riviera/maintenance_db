--PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_croquis_reseau.sql

CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_croquis_reseau;

CREATE TABLE usr_cartoriviera.sige_qgis_croquis_reseau AS
SELECT
    '<a href=javascript:sitnExterns.openWindow("Croquis_reseau","https://map.cartoriviera.ch/files/private/sige/reseau/COMMUNES/' ||
    CASE
        WHEN "file" ~ '^82_' THEN 'BLONAY'
        WHEN "file" ~ '^84_' THEN 'CHARDONNE'
        WHEN "file" ~ '^81_' THEN 'CORSEAUX'
        WHEN "file" ~ '^80_' THEN 'CORSIER'
        WHEN "file" ~ '^88_' THEN 'JONGNY'
        WHEN "file" ~ '^95_' THEN 'LAUSANNE'
        WHEN "file" ~ '^51_' THEN 'MONTREUX'
        WHEN "file" ~ '^43_' THEN 'PORT-VALAIS'
        WHEN "file" ~ '^83_' THEN 'ST-LEGIER'
        WHEN "file" ~ '^60_' THEN 'LA_TOUR_DE_PEILZ'
        WHEN "file" ~ '^71_' THEN 'VEVEY'
        WHEN "file" ~ '^50_' THEN 'VEYTAUX'
        WHEN "file" ~ '^37_' THEN 'VILLENEUVE-NOVILLE'
        ELSE regexp_replace("file", '^(^[A-Za-z]+)_.*$', '\\1')
    END || '/Croquis_reseau/' || file || '",600,600)>' || file || '</a>' AS croquis,
    *
FROM distribution.croquis_reseau;

CREATE INDEX geoidx_sige_qgis_croquis_reseau
ON usr_cartoriviera.sige_qgis_croquis_reseau
USING gist (geometry);
