CREATE TABLE IF NOT EXISTS finguitos_usuarios (
    cliente_documento int4,
    hotel_codigo int4,
    check_in date,
    check_out date,
    fecha_inicio date, 
    fecha_fin date,
    finguitos int,
    fecha_operacion timestamp,
    estado smallint
);

CREATE OR REPLACE FUNCTION finguitos() RETURNS TRIGGER AS $finguitos$
DECLARE 
	monto_finguitos INTEGER;
	precio_por_noche NUMERIC(5,2);
	fecha_fin date;
	fecha_inicio date;
	tipo_estado INTEGER;
BEGIN
        IF (TG_OP = 'INSERT') THEN
        	--hallar precio_noche actualizado
        	SELECT precio_noche INTO precio_por_noche FROM costos_habitacion WHERE
        	hotel_codigo = NEW.hotel_codigo AND nro_habitacion = NEW.nro_habitacion AND
			fecha_desde = (
			    SELECT MAX(fecha_desde) 
			    FROM costos_habitacion
			);
			--definición de campos
        	monto_finguitos :=  TRUNC((NEW.check_out - NEW.check_in)* precio_por_noche/10);
        	fecha_inicio := NEW.check_in + INTERVAL '1 month';
        	fecha_fin := NEW.check_out + INTERVAL '2 years';
        
        	--siempre tendra algún tipo estado, lo dejo con else if para explictés
        	IF (fecha_fin >= CURRENT_DATE) THEN
        		tipo_estado := 1;
        	ELSEIF (fecha_fin < CURRENT_DATE) THEN
        		tipo_estado := 2;
        	END IF;
        
        	--inserción nueva tupla
            INSERT INTO finguitos_usuarios (cliente_documento, hotel_codigo, check_in, check_out,
            fecha_inicio, fecha_fin, finguitos, fecha_operacion, estado) VALUES 
	            (NEW.cliente_documento, NEW.hotel_codigo, NEW.check_in, NEW.check_out, fecha_inicio, fecha_fin,
	           	monto_finguitos, now, tipo_estado);
	           
            --verificar historico finguitos
			UPDATE finguitos_usuarios SET estado = 2  WHERE --vencido
				cliente_documento = NEW.cliente_documento AND fecha_fin < CURRENT_DATE;
			
        ELSEIF (TG_OP = 'UPDATE') THEN
        	--existe tupla finguitos asociado a la estadia?
        	IF EXISTS (SELECT 1 FROM finguitos_usuarios WHERE 
        			OLD.hotel_codigo = NEW.hotel_codigo AND
        			OLD.cliente_documento = NEW.cliente_documento AND
					OLD.check_in = NEW.check_in) THEN
			--existe finguitos		
				SELECT precio_noche INTO precio_por_noche FROM costos_habitacion WHERE
		        	hotel_codigo = NEW.hotel_codigo AND nro_habitacion = NEW.nro_habitacion AND
					fecha_desde = (
					    SELECT MAX(fecha_desde) 
					    FROM costos_habitacion
					);
				--definición de campos
	        	monto_finguitos :=  TRUNC((NEW.check_out - NEW.check_in)* precio_por_noche/10);
	        	fecha_inicio := NEW.check_in + INTERVAL '1 month';
	        	fecha_fin := NEW.check_out + INTERVAL '2 years';				
	        
				UPDATE finguitos_usuarios SET check_in = NEW.check_in, check_out = NEW.check_out, fecha_operacion = now,
					finguitos = monto_finguitos, fecha_inicio = fecha_inicio, fecha_fin = fecha_fin, estado = 1 WHERE 
					cliente_documento = NEW.cliente_documento AND hotel_codigo = NEW.hotel_codigo AND 
					check_in = NEW.check_in;
        	END IF;
            --verificar historico finguitos
        	UPDATE finguitos_usuarios SET estado = 2  WHERE --vencido
				cliente_documento = NEW.cliente_documento AND fecha_fin < CURRENT_DATE;
			
        ELSEIF (TG_OP = 'DELETE') THEN 
			UPDATE finguitos_usuarios SET fecha_operacion = now, estado = 3 WHERE --vencido
				cliente_documento = OLD.cliente_documento AND hotel_codigo = OLD.hotel_codigo AND 
				check_in = OLD.check_in;
        END IF;
    END;
$finguitos$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER finguitos
AFTER INSERT OR UPDATE OR DELETE ON estadias_anteriores
    FOR EACH ROW EXECUTE FUNCTION finguitos();

   
