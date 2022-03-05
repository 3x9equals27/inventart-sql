CREATE OR ALTER TRIGGER TRG_AIU_PAINTING
ON [painting]
AFTER INSERT, UPDATE
AS
BEGIN
--
UPDATE D
   SET D.updated = SYSUTCDATETIME()
  FROM INSERTED I
 INNER JOIN painting D ON D.id = I.id
--
END