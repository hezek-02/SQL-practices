CREATE TABLE IF NOT EXISTS resumen (
    pais_codigo bpchar(2) ,
    cant_estrellas int2 ,--eq smallint
    total_extra NUMERIC(10,2),
    PRIMARY KEY (pais_codigo, cant_estrellas)
);

--Lo dejo comentado por si la idea no es usar llaves foráneas
--ALTER TABLE ONLY resumen
--    ADD CONSTRAINT fpaises_resumen FOREIGN KEY (pais_codigo) REFERENCES paises(pais_codigo);
   
CREATE OR REPLACE PROCEDURE generar_reporte()
AS $generar_reporte$
DECLARE 
    pais bpchar(2);
    cant_estrellas int2;--eq smallint
    total_extra NUMERIC(10,2);
   	parcial_extra NUMERIC(10,2);
   	hotel int4;
BEGIN
	FOR pais IN
        SELECT pais_codigo  FROM paises
    LOOP
		FOR cant_estrellas IN
	        SELECT DISTINCT estrellas  FROM hoteles
	    LOOP
		    total_extra := 0;
		    IF EXISTS (SELECT  1 FROM hoteles h	WHERE h.pais_codigo = pais AND h.estrellas = cant_estrellas) THEN 
				FOR hotel IN
			        SELECT  h.hotel_codigo FROM hoteles h WHERE h.pais_codigo = pais AND h.estrellas = cant_estrellas
			    LOOP
			    	SELECT SUM(monto) INTO parcial_extra FROM ingreso_extra(hotel);-- si NO posee estadias devuelve NULL
			    	IF parcial_extra IS NOT NULL THEN
			    		total_extra := total_extra + parcial_extra;
			    	END IF;
    			END LOOP;
			END IF;
		   	INSERT INTO resumen (pais_codigo, cant_estrellas, total_extra)--insertar los valores
            	VALUES (pais, cant_estrellas, total_extra);
	    END LOOP;
    END LOOP;
END;
$generar_reporte$ LANGUAGE plpgsql;
	