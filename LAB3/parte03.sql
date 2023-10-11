CREATE OR REPLACE PROCEDURE generar_reporte()
$$
BEGIN
	FOR pais IN
        SELECT pais_codigo FROM paises;
    LOOP
	    
        -- can do some processing here
        RETURN NEXT r; -- return current row of SELECT
    END LOOP;
END;
$$ LANGUAGE plpgsql;
	














SELECT  * FROM resumen r 


SELECT * FROM paises p 

SELECT * FROM hoteles h 

SELECT  p.pais_codigo,h.estrellas,ingreso_extra(h.hotel_codigo)  FROM  paises p JOIN hoteles h ON
	p.pais_codigo = h.pais_codigo 
	GROUP BY p.pais_codigo,h.estrellas;
	
SELECT  generar_reporte();