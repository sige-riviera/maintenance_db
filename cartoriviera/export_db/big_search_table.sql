

DROP  TABLE IF EXISTS sige_qgis_cartoriviera.sige_qgis_big_table;

CREATE TABLE sige_qgis_cartoriviera.sige_qgis_big_table AS (
--------------------
--  QWAT
    SELECT 'EP Ouvrages'::text AS layer_name,
        CASE
          WHEN installation_type = 'source' THEN (('Source '::text || identification::text) || ' '::text) || name::text
          WHEN installation_type = 'treatment' THEN (('Traitement '::text || identification::text) || ' '::text) || name::text
          WHEN installation_type = 'tank' THEN (('Réservoir '::text || identification::text) || ' '::text) || name::text
          WHEN installation_type = 'pressurecontrol' THEN (('Régulation de pression '::text || identification::text) || ' '::text) || name::text
          WHEN installation_type = 'pump' THEN (('Pompage '::text || identification::text) || ' '::text) || name::text
          WHEN installation_type = 'chamber' THEN (('Chambre '::text || identification::text) || ' '::text) || name::text
          ELSE NULL::text
        END AS search_text,
        st_force2d(geometry) AS geometry
      FROM  sige_qgis_cartoriviera.sige_qgis_qwat_installation
      WHERE status_functional IS TRUE
  UNION
    SELECT 'EP Hydrantes'::text AS layer_name,
        (district_name::text || ' '::text) || identification::text AS search_text,
        st_force2d(geometry) AS geometry
      FROM  sige_qgis_cartoriviera.sige_qgis_qwat_hydrant
  UNION
    SELECT 'EP Abonnés'::text AS layer_name,
        ((((subscriber_type_value_fr::text || ' '::text) || COALESCE(district_prefix::text || '_'::text, ''::text)) || identification::text) || ' '::text) || district_name::text AS search_text,
        st_force2d(geometry) AS geometry
      FROM  sige_qgis_cartoriviera.sige_qgis_qwat_subscriber
  UNION
    SELECT 'EP Compteur'::text AS layer_name,
        'Compteur ' || COALESCE(district_prefix::text || '_'::text, ''::text) || identification::text AS search_text,
        st_force2d(geometry) AS geometry
      FROM sige_qgis_cartoriviera.sige_qgis_qwat_meter
      WHERE identification IS NOT NULL
  UNION
    SELECT 'EP Vannes'::text AS layer_name,
        (((valve_function_value_fr::text || ' '::text) || identification::text) || ' '::text) || district_name::text AS search_text,
        st_force2d(geometry) AS geometry
      FROM  sige_qgis_cartoriviera.sige_qgis_qwat_valve
      WHERE identification IS NOT NULL
  UNION
    SELECT 'EP Folios'::text AS layer_name,
      'Folio ' || substr("district_name",1,1) || right("district_name",1)::text || ' '::text || name::text AS search_text,
      st_force2d(geometry) AS geometry
      FROM sige_qgis_cartoriviera.sige_qgis_qwat_printmap
      WHERE name IS NOT NULL
-------------------
--  QGEP
UNION
  SELECT 'AS Chambres' AS layer_name,
      co_identifier AS search_text,
      ST_GeometryN(situation_geometry,1)::geometry(Point,21781)
    FROM sige_qgis_cartoriviera.sige_qgis_qgep_wastewater_structure
    WHERE co_identifier IS NOT NULL
-------------------
--  CADASTRE PORT-VALAIS
UNION
  SELECT 'Adresse Valais' AS layer_name,
      rue || ' ' || numero || ', ' || commune AS search_text,
      ST_GeomFromEWKB(ST_Fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'))::geometry(Point,21781) AS geometry
    FROM adresse.geopost
    WHERE commune = 'Bouveret' OR commune = 'Les Evouettes'
UNION
  SELECT 'Cadastre Valais' AS layer_name,
      'Parcelle ' || numero || ', Port-Valais' AS search_text,
      ST_GeomFromEWKB(ST_Fineltra(ST_Centroid(geom), 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'))::geometry(Point,21781) AS geometry
    FROM cadastre.portvalais_bienfonds
);

CREATE TABLE sige_qgis_cartoriviera.sige_qgis_big_table_mn95 AS SELECT * FROM sige_qgis_cartoriviera.sige_qgis_big_table;
ALTER TABLE sige_qgis_cartoriviera.sige_qgis_big_table_mn95 ALTER COLUMN geometry TYPE geometry('geometry', 2056) USING st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv03', 'the_geom_lv95'));
