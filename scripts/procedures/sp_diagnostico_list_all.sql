CREATE OR ALTER PROCEDURE sp_diagnostico_list_all(@i_tenant NVARCHAR(10))
AS
BEGIN
    SELECT d.guid
         , d.description
         , CASE WHEN d.id_file IS NULL THEN 0 ELSE 1 END AS has_file
         , f.guid AS file_guid
      FROM diagnostico d
	 INNER JOIN tenant t on t.id = d.id_tenant
      LEFT JOIN [file] f ON f.id = d.id_file
	 WHERE t.code = @i_tenant
	 ORDER BY d.id DESC
	;
END
