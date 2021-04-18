DROP FUNCTION IF EXISTS fn_list_diagnostico;
CREATE OR REPLACE FUNCTION fn_list_diagnostico()
  RETURNS TABLE (guid uuid   -- also visible as OUT parameter inside function
               , description VARCHAR
               , has_file boolean
			   , file_guid uuid) AS
$func$
BEGIN
    RETURN QUERY
    SELECT d.guid
         , d.description
         , d.id_file IS NOT NULL AS has_file
         , f.guid AS file_guid
      FROM diagnostico d
      LEFT JOIN file f ON f.id = d.id_file
	 ORDER BY d.id ASC
	;
END
$func$ LANGUAGE plpgsql;

