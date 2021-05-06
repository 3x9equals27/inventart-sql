DROP FUNCTION IF EXISTS fn_diagnostico_list_all;
CREATE OR REPLACE FUNCTION fn_diagnostico_list_all(i_tenant VARCHAR)
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
	 INNER JOIN tenant t on t.id = d.id_tenant
      LEFT JOIN file f ON f.id = d.id_file
	 WHERE t.code = i_tenant
	 ORDER BY d.id ASC
	;
END
$func$ LANGUAGE plpgsql;

