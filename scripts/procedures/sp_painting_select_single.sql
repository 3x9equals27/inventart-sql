CREATE OR ALTER PROCEDURE sp_painting_select_single @i_tenant NVARCHAR(10), @i_guid UNIQUEIDENTIFIER
AS
BEGIN
    SELECT d.guid
		 , d.name
		 , d.author
         , d.description
         , CASE WHEN d.id_file IS NULL THEN 0 ELSE 1 END AS has_file
         , f.guid AS file_guid
      FROM painting d
	 INNER JOIN tenant t on t.id = d.id_tenant
      LEFT JOIN [file] f ON f.id = d.id_file
	 WHERE d.guid = @i_guid
	   AND t.code = @i_tenant
	;
END
