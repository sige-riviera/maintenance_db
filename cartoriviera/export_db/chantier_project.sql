CREATE SCHEMA IF NOT EXISTS usr_cartoriviera;

DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_project_line;
DROP TABLE IF EXISTS usr_cartoriviera.sige_qgis_project_point;

CREATE TABLE usr_cartoriviera.sige_qgis_project_line AS
SELECT
    id,
    type AS prj_line_type,
    specifications AS prj_line_specifications,
    plan_reference AS prj_line_plan_reference,
    plan_name AS prj_line_plan_name,
    plan_year AS prj_line_plan_year,
    remark AS prj_line_remark,
    DATE(updated_at) AS prj_line_updated_at,
    geometry
FROM chantier.project_line
WHERE visibility_carto IS TRUE;

CREATE TABLE usr_cartoriviera.sige_qgis_project_point AS
SELECT
    id,
    type AS prj_point_type,
    specifications AS prj_point_specifications,
    plan_reference AS prj_point_plan_reference,
    plan_name AS prj_point_plan_name,
    plan_year AS prj_point_plan_year,
    remark AS prj_point_remark,
    DATE(updated_at) AS prj_point_updated_at,
    geometry
FROM chantier.project_point
WHERE visibility_carto IS TRUE;
