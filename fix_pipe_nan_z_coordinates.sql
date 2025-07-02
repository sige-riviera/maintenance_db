UPDATE qwat_od.pipe
SET
  geometry = CASE
    WHEN EXISTS (
      SELECT 1 FROM ST_DumpPoints(geometry) AS dp
      WHERE ST_Z(dp.geom) = 'NaN'::double precision
    )
    THEN (
      SELECT ST_SetSRID(ST_MakeLine(ARRAY(
        SELECT ST_SetSRID(
          ST_MakePoint(
            ST_X(dp.geom),
            ST_Y(dp.geom),
            CASE WHEN ST_Z(dp.geom) = 'NaN'::double precision THEN 0 ELSE ST_Z(dp.geom) END
          ), 2056)
        FROM ST_DumpPoints(geometry) AS dp
      )), 2056)
    )
    ELSE geometry
  END,

  geometry_alt1 = CASE
    WHEN EXISTS (
      SELECT 1 FROM ST_DumpPoints(geometry_alt1) AS dp
      WHERE ST_Z(dp.geom) = 'NaN'::double precision
    )
    THEN (
      SELECT ST_SetSRID(ST_MakeLine(ARRAY(
        SELECT ST_SetSRID(
          ST_MakePoint(
            ST_X(dp.geom),
            ST_Y(dp.geom),
            CASE WHEN ST_Z(dp.geom) = 'NaN'::double precision THEN 0 ELSE ST_Z(dp.geom) END
          ), 2056)
        FROM ST_DumpPoints(geometry_alt1) AS dp
      )), 2056)
    )
    ELSE geometry_alt1
  END,

  geometry_alt2 = CASE
    WHEN EXISTS (
      SELECT 1 FROM ST_DumpPoints(geometry_alt2) AS dp
      WHERE ST_Z(dp.geom) = 'NaN'::double precision
    )
    THEN (
      SELECT ST_SetSRID(ST_MakeLine(ARRAY(
        SELECT ST_SetSRID(
          ST_MakePoint(
            ST_X(dp.geom),
            ST_Y(dp.geom),
            CASE WHEN ST_Z(dp.geom) = 'NaN'::double precision THEN 0 ELSE ST_Z(dp.geom) END
          ), 2056)
        FROM ST_DumpPoints(geometry_alt2) AS dp
      )), 2056)
    )
    ELSE geometry_alt2
  END
WHERE
  EXISTS (
    SELECT 1
    FROM (
      SELECT unnest(ARRAY[geometry, geometry_alt1, geometry_alt2]) AS geom
    ) AS all_geoms,
    LATERAL (
      SELECT 1
      FROM ST_DumpPoints(all_geoms.geom) AS dp
      WHERE ST_Z(dp.geom) = 'NaN'::double precision
      LIMIT 1
    ) AS nan_check
  );
