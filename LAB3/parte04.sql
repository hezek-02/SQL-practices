CREATE OR REPLACE FUNCTION control_costos() RETURNS TRIGGER AS $control_costos$
    BEGIN
        IF (TG_OP = 'UPDATE' AND (NEW.precio_noche IS NULL OR NEW.precio_noche <= 0)) THEN
            RAISE NOTICE 'La actualización no es correcta';
           	RETURN NULL;
        ELSIF (TG_OP = 'DELETE' AND EXISTS (SELECT 1 FROM estadias e WHERE 
        e.hotel_codigo = OLD.hotel_codigo AND 
        e.nro_habitacion = OLD.nro_habitacion AND --join estadia costo hab
        OLD.fecha_desde = 	--identifica si la fecha desde
				(SELECT  MAX(fecha_desde) FROM costos_habitacion ch2 WHERE 
					ch2.hotel_codigo = e.hotel_codigo  AND 
					ch2.nro_habitacion  = e.nro_habitacion  AND 
					ch2.fecha_desde <= e.check_in
					) ) ) THEN
            RAISE NOTICE 'La operación de borrado no es correcta';
            RETURN NULL;
        END IF;
        RETURN NEW;
    END;
$control_costos$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER control_costos
BEFORE UPDATE OR DELETE ON costos_habitacion
    FOR EACH ROW EXECUTE FUNCTION control_costos();
