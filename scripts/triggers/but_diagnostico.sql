DROP TRIGGER IF EXISTS but_diagnostico ON public.diagnostico;

CREATE TRIGGER but_diagnostico
BEFORE UPDATE ON diagnostico
FOR EACH ROW
EXECUTE PROCEDURE fn_trigger_set_timestamp();
