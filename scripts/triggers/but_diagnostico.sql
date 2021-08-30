CREATE OR ALTER TRIGGER TRG_AIU_DIAGNOSTICO
ON [diagnostico]
AFTER INSERT, UPDATE
AS
BEGIN
--
UPDATE D
   SET D.updated = SYSUTCDATETIME()
  FROM INSERTED I
 INNER JOIN diagnostico D ON D.id = I.id
--
END
