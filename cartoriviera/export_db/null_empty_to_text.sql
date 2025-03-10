-- Set NULL and empty strings values as '-' for text attributes only (not condidering numeric, dates, timestamps, array and geometry types.)

DO
$$
DECLARE
    rec_null RECORD;  -- Variable pour stocker les colonnes avec des valeurs NULL
    rec_empty RECORD; -- Variable pour stocker les colonnes avec des chaînes vides
BEGIN
    -- Remplacer les valeurs NULL par '-' dans les colonnes de type texte
    FOR rec_null IN
        SELECT *
        FROM information_schema.columns
        WHERE table_schema = 'sige_qgis_cartoriviera' AND data_type IN ('character varying', 'text')
    LOOP
        -- Affichage du nom de la colonne dans les messages de notification
        RAISE NOTICE 'Column is %', rec_null.column_name;

        -- Mise à jour des valeurs NULL
        EXECUTE FORMAT(
            'UPDATE sige_qgis_cartoriviera.%1$I SET %2$I = ''-'' WHERE %2$I IS NULL;',
            rec_null.table_name,
            rec_null.column_name
        );
    END LOOP;

    -- Remplacer les chaînes vides par '-' dans les colonnes de type texte
    FOR rec_empty IN
        SELECT *
        FROM information_schema.columns
        WHERE table_schema = 'sige_qgis_cartoriviera' AND data_type IN ('character varying', 'text')
    LOOP
        -- Affichage du nom de la colonne dans les messages de notification
        RAISE NOTICE 'Column is %', rec_empty.column_name;

        -- Mise à jour des chaînes vides
        EXECUTE FORMAT(
            'UPDATE sige_qgis_cartoriviera.%1$I SET %2$I = ''-'' WHERE %2$I = '''';',
            rec_empty.table_name,
            rec_empty.column_name
        );
    END LOOP;
END
$$;
