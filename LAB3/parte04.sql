CREATE OR REPLACE FUNCTION control_costos() RETURNS TRIGGER AS $control_costos$
    BEGIN
        IF (TG_OP = 'UPDATE' AND (NEW.precio_noche IS NULL OR NEW.precio_noche <= 0)) THEN
            RAISE NOTICE 'La actualización no es correcta';
        ELSIF (TG_OP = 'DELETE' AND EXISTS (SELECT 1 FROM costos_habitacion ch JOIN estadias e ON e.hotel_codigo = OLD.hotel_codigo AND 
        e.nro_habitacion = OLD.nro_habitacion WHERE --join estadia costo hab
        OLD.fecha_desde = 	--identifica si la fecha desde
				(SELECT  MAX(fecha_desde) FROM costos_habitacion ch2 WHERE 
					ch2.hotel_codigo = e.hotel_codigo  AND 
					ch2.nro_habitacion  = e.nro_habitacion  AND 
					ch2.fecha_desde <= e.check_in
					) ) ) THEN
            RAISE NOTICE 'La operación de borrado no es correcta';
        END IF;
        RETURN NULL;
    END;
$control_costos$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER control_costos
BEFORE UPDATE OR DELETE ON costos_habitacion
    FOR EACH ROW EXECUTE FUNCTION control_costos();
