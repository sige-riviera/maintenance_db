-- Set NULL values as '-' for text attributes only (not condidering numeric, dates, timestamps, array and geometry types.)
DO
$$
DECLARE
rec_text record;
rec_num record;
BEGIN
FOR rec_null IN SELECT * FROM information_schema.columns WHERE table_schema = 'sige_qgis_cartoriviera' AND data_type IN ('character varying','text') LOOP
                RAISE NOTICE 'Column is %', rec.column_name;
    EXECUTE format('ALTER TABLE sige_qgis_cartoriviera.%1$I ALTER COLUMN %2$I CASE WHEN %2$I IS NULL THEN ''-'' END;', rec_null.table_name, rec_null.column_name);
END LOOP;
FOR rec_empty IN SELECT * FROM information_schema.columns WHERE table_schema = 'sige_qgis_cartoriviera' AND data_type IN ('character varying','text') LOOP
                RAISE NOTICE 'Column is %', rec_empty.column_name;
    EXECUTE format('ALTER TABLE sige_qgis_cartoriviera.%1$I ALTER COLUMN %2$I CASE WHEN %2$I = '' THEN ''-'' END;', rec_empty.table_name, rec_empty.column_name);
END LOOP;
END
$$;
