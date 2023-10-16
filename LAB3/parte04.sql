CREATE OR REPLACE FUNCTION control_costos() RETURNS TRIGGER AS $control_costos$
BEGIN
    IF EXISTS (SELECT 1  FROM estadias_anteriores e WHERE --identifica si afecta una estadia
   		e.hotel_codigo = OLD.hotel_codigo AND 
        e.nro_habitacion = OLD.nro_habitacion AND 
        OLD.fecha_desde = 	
				(SELECT  MAX(fecha_desde) FROM costos_habitacion ch2 WHERE 
					ch2.hotel_codigo = e.hotel_codigo  AND 
					ch2.nro_habitacion  = e.nro_habitacion  AND 
					ch2.fecha_desde <= e.check_in
					)   AND 
	    NOT EXISTS (SELECT 1 FROM costos_habitacion ch WHERE --No existe otro costo asociado que lo suplante
		        ch.hotel_codigo = e.hotel_codigo AND 
		        ch.nro_habitacion = e.nro_habitacion AND 
		        ch.fecha_desde < OLD.fecha_desde ))  THEN

		-- SI cambian los codigos de las primary key, o solo fecha desde comprobar
    	IF (TG_OP = 'UPDATE' AND (OLD.hotel_codigo != NEW.hotel_codigo OR
    		OLD.nro_habitacion != NEW.nro_habitacion OR
			NEW.precio_noche <= 0 OR NEW.costo_noche < 0 OR 
			EXISTS (SELECT 1 FROM estadias_anteriores e WHERE --La fecha excede el check_in, osea queda estadia sin precio
		        	e.hotel_codigo = OLD.hotel_codigo AND 
		        	e.nro_habitacion = OLD.nro_habitacion AND 
		       		NEW.fecha_desde > e.check_in))) THEN
					
	            RAISE NOTICE 'La actualización no es correcta';
	           	RETURN NULL;
        ELSIF (TG_OP = 'DELETE' ) THEN
            RAISE NOTICE 'La operación de borrado no es correcta';
            RETURN NULL;
        END IF;
	END IF;
    IF (TG_OP = 'DELETE' ) THEN
		RETURN OLD;
    ELSE
    	RETURN NEW;
    END IF;
END;
$control_costos$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER control_costos
BEFORE UPDATE OR DELETE ON costos_habitacion
    FOR EACH ROW EXECUTE FUNCTION control_costos();
