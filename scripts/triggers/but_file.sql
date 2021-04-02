DROP TRIGGER IF EXISTS but_file ON public.file;
/*
CREATE TRIGGER but_file
BEFORE UPDATE ON file
FOR EACH ROW
EXECUTE PROCEDURE fn_trigger_set_timestamp();
*/