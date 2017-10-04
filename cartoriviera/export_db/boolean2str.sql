
DO
$$
DECLARE
rec record;
BEGIN
FOR rec IN SELECT * FROM information_schema.columns WHERE table_schema = 'sige_qgis_cartoriviera' AND data_type = 'boolean' LOOP
		RAISE NOTICE 'Column is %', rec.column_name;
    EXECUTE format('ALTER TABLE sige_qgis_cartoriviera.%1$I ALTER COLUMN %2$I type text using CASE WHEN %2$I is true then ''oui'' else ''non'' end;', rec.table_name, rec.column_name);
	END LOOP;
END
$$;
