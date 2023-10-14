CREATE TABLE IF NOT EXISTS finguitos_usuarios (
    cliente_documento int4 ,
    hotel_codigo int4 ,
    check_in date ,
    check_out date,
    fecha_inicio date, 
    fecha_fin date,
    finguitos int,
    fecha_operacion timestamp ,
    estado SMALLINT,
    PRIMARY KEY (cliente_documento, hotel_codigo, check_in)
);
   
--Lo dejo comentado por si la idea no es usar llaves foráneas
--ALTER TABLE ONLY finguitos_usuarios
--    ADD CONSTRAINT fhoteles_finguitos_usuarios FOREIGN KEY (hotel_codigo) REFERENCES hoteles(hotel_codigo);

--ALTER TABLE ONLY finguitos_usuarios
--    ADD CONSTRAINT fclientes_finguitos_usuarios FOREIGN KEY (cliente_documento) REFERENCES clientes(cliente_documento);   
   
CREATE OR REPLACE FUNCTION finguitos() RETURNS TRIGGER AS $finguitos$
DECLARE 
	monto_finguitos INTEGER;
	precio_por_noche NUMERIC(5,2);
	fecha_final date;
	fecha_inicial date;
	tipo_estado INTEGER;
BEGIN
	/*
	Innecesario por claves foráneas de estadias_anteriores lo dejo planteado
	IF NOT EXISTS (SELECT 1 FROM hoteles WHERE hotel_codigo = NEW.hotel_codigo) AND (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN 
		RAISE NOTICE 'No existe el hotel';
		ROLLBACK;
		RETURN NULL;
	ELSEIF NOT EXISTS (SELECT 1 FROM clientes WHERE cliente_documento  = NEW.cliente_documento) AND (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
		RAISE NOTICE 'No existe el cliente';
		ROLLBACK;
		RETURN NULL;
	END IF;
	*/
	
--hallar precio_noche actualizado
	SELECT precio_noche INTO precio_por_noche FROM costos_habitacion ch WHERE
		hotel_codigo = NEW.hotel_codigo AND nro_habitacion = NEW.nro_habitacion AND
		fecha_desde = (
		    SELECT MAX(fecha_desde) 
		    FROM costos_habitacion ch2 WHERE ch.hotel_codigo = ch2.hotel_codigo AND ch.nro_habitacion = ch2.nro_habitacion
		);
--definición de campos
	monto_finguitos :=  TRUNC(((NEW.check_out - NEW.check_in)* precio_por_noche/10));
	fecha_inicial := NEW.check_in + INTERVAL '1 month';
	fecha_final := NEW.check_out + INTERVAL '2 years';

    IF (TG_OP = 'INSERT') THEN
    	--siempre tendra algún tipo estado, lo dejo con else if para explictés
    	IF (fecha_final >= CURRENT_DATE) THEN
    		tipo_estado := 1;
    	ELSEIF (fecha_final < CURRENT_DATE) THEN
    		tipo_estado := 2;
    	END IF;
    	--tiene estadias previas?
    	IF EXISTS (SELECT 1 FROM estadias_anteriores ea WHERE hotel_codigo = NEW.hotel_codigo AND 
    		cliente_documento = NEW.cliente_documento AND check_in <> NEW.check_in ) THEN
    		monto_finguitos :=  monto_finguitos + 5;
    	END IF;
    	--inserción nueva tupla
        INSERT INTO finguitos_usuarios 
        (cliente_documento, 
        hotel_codigo, 
        check_in, 
        check_out,
        fecha_inicio, 
        fecha_fin, 
        finguitos, 
        fecha_operacion, 
        estado) 
        VALUES 
        (NEW.cliente_documento,
        NEW.hotel_codigo,
        NEW.check_in,
        NEW.check_out,
        fecha_inicial,
        fecha_final,
        monto_finguitos,
        NOW(),
        tipo_estado);
           
        --verificar historico finguitos
		UPDATE finguitos_usuarios SET estado = 2  WHERE --vencido
			cliente_documento = NEW.cliente_documento AND fecha_fin < CURRENT_DATE;
		
    ELSEIF (TG_OP = 'UPDATE') THEN
    	--existe tupla finguitos asociado a la estadia?
    	IF EXISTS (SELECT 1 FROM finguitos_usuarios WHERE 
    			OLD.hotel_codigo = hotel_codigo AND OLD.cliente_documento = cliente_documento AND OLD.check_in = check_in) THEN
        
			UPDATE finguitos_usuarios SET 
			cliente_documento = NEW.cliente_documento,
			hotel_codigo = NEW.hotel_codigo,
			check_in = NEW.check_in,
			check_out = NEW.check_out,
			fecha_operacion = NOW(),
			finguitos = monto_finguitos,
			fecha_inicio = fecha_inicial,
			fecha_fin = fecha_final,
			estado = 1 WHERE 
			cliente_documento = OLD.cliente_documento AND 
		    hotel_codigo = OLD.hotel_codigo AND 
		    check_in = OLD.check_in;  
	
    	END IF;
        --verificar historico finguitos
    	UPDATE finguitos_usuarios SET estado = 2  WHERE --vencido
			cliente_documento = NEW.cliente_documento AND fecha_fin < CURRENT_DATE;
		
    ELSEIF (TG_OP = 'DELETE') THEN 
    
		UPDATE finguitos_usuarios SET 
		fecha_operacion = NOW(),
		estado = 3 WHERE --vencido
		cliente_documento = OLD.cliente_documento AND 
		hotel_codigo = OLD.hotel_codigo AND 
		check_in = OLD.check_in;
	
    END IF;
   
   RETURN NEW;
  
END;
$finguitos$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER finguitos
AFTER INSERT OR UPDATE OR DELETE ON estadias_anteriores
    FOR EACH ROW EXECUTE FUNCTION finguitos();

   
