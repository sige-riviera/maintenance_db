-- Set boolean values as text

DO
$$
DECLARE
    rec RECORD;  -- Déclaration d'une variable pour stocker les résultats de la requête
BEGIN
    -- Boucle à travers les colonnes de type boolean dans le schéma spécifié
    FOR rec IN
        SELECT *
        FROM information_schema.columns
        WHERE table_schema = 'sige_qgis_cartoriviera' AND data_type = 'boolean'
    LOOP
        -- Affichage du nom de la colonne dans les messages de notification
        RAISE NOTICE 'Column is %', rec.column_name;

        -- Modification du type de la colonne en texte
        EXECUTE FORMAT(
            'ALTER TABLE sige_qgis_cartoriviera.%1$I ALTER COLUMN %2$I TYPE text USING CASE WHEN %2$I IS true THEN ''oui'' ELSE ''non'' END;',
            rec.table_name,
            rec.column_name
        );
    END LOOP;
END
$$;
