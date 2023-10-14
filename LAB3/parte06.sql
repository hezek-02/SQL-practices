CREATE SEQUENCE IF NOT EXISTS logidseq  
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE IF NOT EXISTS audit_estadia (
    idop int4 DEFAULT nextval('logidseq') NOT NULL ,
    accion CHAR(1) NOT NULL ,
    fecha DATE NOT NULL ,
    usuario TEXT NOT NULL ,
    cliente_documento int4 NOT NULL , 
    hotel_codigo int4 NOT NULL ,
    nro_habitacion int2 NOT NULL ,
    check_in date NOT NULL ,
    PRIMARY KEY (idop)
);


--Lo dejo comentado por si la idea no es usar llaves foráneas
--ALTER TABLE ONLY audit_estadia
--    ADD CONSTRAINT fhabitaciones_audit_estadia FOREIGN KEY (hotel_codigo,nro_habitacion) REFERENCES habitaciones(hotel_codigo,nro_habitacion);

--ALTER TABLE ONLY audit_estadia
--    ADD CONSTRAINT fclientes_audit_estadia FOREIGN KEY (cliente_documento) REFERENCES clientes(cliente_documento);   

CREATE OR REPLACE FUNCTION auditoria_estadias() RETURNS TRIGGER AS $auditoria_estadias$
    BEGIN
	--control integridad
	IF NOT EXISTS (SELECT 1 FROM habitaciones WHERE hotel_codigo = NEW.hotel_codigo AND 
		nro_habitacion = NEW.nro_habitacion) AND (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN 
		
		RAISE NOTICE 'No existe el hotel';
		ROLLBACK;
		RETURN NULL;
	ELSEIF NOT EXISTS (SELECT 1 FROM clientes WHERE cliente_documento  = NEW.cliente_documento) AND 
		(TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
		
		RAISE NOTICE 'No existe el cliente';
		ROLLBACK;
		RETURN NULL;
	END IF;   
	    
	IF (TG_OP = 'INSERT') THEN
		INSERT INTO audit_estadia (idop, accion, fecha, usuario, cliente_documento, hotel_codigo, nro_habitacion, check_in)
	    	VALUES (
	    	nextval('logidseq'),
	        'I',
	        current_date,
	        current_user,
	        NEW.cliente_documento,
	        NEW.hotel_codigo,
	        NEW.nro_habitacion,
	        NEW.check_in);
	
	ELSEIF (TG_OP = 'UPDATE') THEN
		INSERT INTO audit_estadia (idop, accion, fecha, usuario, cliente_documento, hotel_codigo, nro_habitacion, check_in)
	    	VALUES (
	    	nextval('logidseq'),
	        'U',
	        current_date,
	        current_user,
	        OLD.cliente_documento,
	        OLD.hotel_codigo,
	        OLD.nro_habitacion,
	        OLD.check_in);
	    
	ELSEIF (TG_OP = 'DELETE') THEN
		INSERT INTO audit_estadia (accion, fecha, usuario, cliente_documento, hotel_codigo, nro_habitacion, check_in)
	    	VALUES (
	        'D',
	        current_date,
	        current_user,
	        OLD.cliente_documento,
	        OLD.hotel_codigo,
	        OLD.nro_habitacion,
	        OLD.check_in);
	
	END IF;
        RETURN NEW;
    END;
$auditoria_estadias$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER auditoria_estadias
BEFORE UPDATE OR DELETE OR INSERT ON estadias_anteriores
    FOR EACH ROW EXECUTE FUNCTION auditoria_estadias();
