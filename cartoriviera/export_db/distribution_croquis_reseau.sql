--PGSERVICE=sige_commun psql -v ON_ERROR_STOP=on -f ~/Documents/qgis/qwat-sige/export_cartoriviera/export_croquis_reseau.sql

create schema if not exists cartoriviera;

drop table if exists cartoriviera.sige_qgis_croquis_reseau;
drop table if exists cartoriviera.sige_qgis_croquis_reseau_mn95;

create table cartoriviera.sige_qgis_croquis_reseau_mn95 as
select
  '<a href=javascript:sitnExterns.openWindow("Croquis_reseau","https://www.cartoriviera.ch/sige/reseau/COMMUNES/' ||
  CASE
  WHEN "file" ~ '^82_' THEN  'Blonay'
  WHEN "file" ~ '^84_' THEN  'Chardonne'
  WHEN "file" ~ '^81_' THEN  'Corseaux'
  WHEN "file" ~ '^80_' THEN  'Corsier'
  WHEN "file" ~ '^88_' THEN  'Jongny'
  WHEN "file" ~ '^95_' THEN  'Lausanne'
  WHEN "file" ~ '^51_' THEN  'Montreux'
  WHEN "file" ~ '^43_' THEN  'Port-Valais'
  WHEN "file" ~ '^83_' THEN  'St-Legier'
  WHEN "file" ~ '^60_' THEN  'La_Tour_de_Peilz'
  WHEN "file" ~ '^71_' THEN  'Vevey'
  WHEN "file" ~ '^50_' THEN  'Veytaux'
  WHEN "file" ~ '^37_' THEN  'Villeneuve-Noville'
  ELSE regexp_replace("file", '^(^[A-Za-z]+)_.*$', '\\1')
  END || '/Croquis_reseau/' || file || '",600,600)>'||file||'</a>' AS croquis,
  *
from distribution.croquis_reseau;

create table cartoriviera.sige_qgis_croquis_reseau as select * from cartoriviera.sige_qgis_croquis_reseau_mn95;

alter table cartoriviera.sige_qgis_croquis_reseau alter column geometry type geometry('point', 21781) using st_geomfromewkb(st_fineltra(geometry, 'chenyx06.chenyx06_triangles', 'the_geom_lv95', 'the_geom_lv03'));
