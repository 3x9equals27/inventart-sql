DROP FUNCTION IF EXISTS list_diagnostico;
CREATE OR REPLACE FUNCTION list_diagnostico()
  RETURNS TABLE (guid uuid   -- also visible as OUT parameter inside function
               , description VARCHAR
               , has_file boolean) AS
$func$
BEGIN
    RETURN QUERY
    SELECT d.guid
         , d.description
         , d.id_file IS NOT NULL AS has_file 
      FROM diagnostico d;
END
$func$ LANGUAGE plpgsql;

