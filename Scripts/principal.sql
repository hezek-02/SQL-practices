--parte01 CORRECTO
SELECT actividad_cliente('r', 86947966, 2010) ;
SELECT actividad_cliente('R', 86947966, 2010) ;

SELECT actividad_cliente('e', 33969052, 2010) ;
SELECT actividad_cliente('E', 33969052, 2010) ;

SELECT actividad_cliente('z', 81449752, 2011) ;
SELECT actividad_cliente('z', 312, 2011) ;
SELECT actividad_cliente('E', 312, 2011) ;

SELECT cliente_documento,COUNT(*)   FROM reservas_anteriores
WHERE EXTRACT(YEAR FROM fecha_reserva) = 2010
GROUP BY cliente_documento having count(*) > 1

SELECT * FROM reservas_anteriores ra2  WHERE 
cliente_documento = 86947966

SELECT cliente_documento,COUNT(*)   FROM estadias_anteriores ea 
WHERE EXTRACT(YEAR FROM check_in) = 2010
GROUP BY cliente_documento having count(*) > 1

SELECT * FROM estadias_anteriores ra2  WHERE 
cliente_documento = 33969052


--parte02
SELECT  ea1.hotel_codigo,ea1.nro_habitacion,ea1.check_in,ea1.check_out  FROM
	estadias_anteriores ea1 EXCEPT 
		(SELECT ea.hotel_codigo,ea.nro_habitacion,ea.check_in,ea.check_out  FROM 
			estadias_anteriores ea JOIN reservas_anteriores ra ON
			ea.hotel_codigo = ra.hotel_codigo AND 
			ea.nro_habitacion = ra.nro_habitacion AND 
			ea.check_in = ra.check_in )
		
					
	SELECT tipo_habitacion_codigo AS tipohab, SUM((check_out-check_in)*precio_noche) AS monto FROM
		costos_habitacion ch  JOIN habitaciones h ON 
		h.hotel_codigo = ch.hotel_codigo AND 
		h.nro_habitacion = ch.nro_habitacion JOIN 
		estadias_anteriores ea ON 
		ea.hotel_codigo = ch.hotel_codigo  AND 
		ea.nro_habitacion = ch.nro_habitacion WHERE
			ea.hotel_codigo = 6468804 AND 
			ch.fecha_desde =
				(SELECT  MAX(fecha_desde) FROM costos_habitacion ch2 WHERE 
					ch2.hotel_codigo = ch.hotel_codigo  AND 
					ch2.nro_habitacion  = ch.nro_habitacion  AND 
					ch2.fecha_desde <= ea.check_in
					)
			AND NOT EXISTS 
				(SELECT 1 FROM 
				reservas_anteriores ra WHERE
				ea.hotel_codigo = ra.hotel_codigo AND 
				ea.nro_habitacion = ra.nro_habitacion AND 
				ea.check_in = ra.check_in 
				)
		GROUP BY tipo_habitacion_codigo
		
SELECT * FROM ingreso_extra(2);
SELECT * FROM ingreso_extra(6463694);--this
SELECT * FROM ingreso_extra(6468804);


--parte03
SELECT * FROM	hoteles h
   		WHERE h.pais_codigo = 'AF'
SELECT * FROM ingreso_extra(6525872);--this
   		
CALL  generar_reporte();

SELECT * FROM resumen ORDER BY pais_codigo,cant_estrellas  DESC
DELETE FROM resumen r 

--parte04
SELECT * FROM ingreso_extra(6463694);--this

SELECT  * FROM costos_habitacion ch JOIN estadias_anteriores e ON
	e.hotel_codigo = ch.hotel_codigo AND 
	e.nro_habitacion = ch.nro_habitacion 
	WHERE e.hotel_codigo = 6463694 AND e.check_in >= ch.fecha_desde 
	AND NOT EXISTS (
		SELECT 1 FROM 
			reservas_anteriores ra WHERE
			e.hotel_codigo = ra.hotel_codigo AND 
			e.nro_habitacion = ra.nro_habitacion AND 
			e.check_in = ra.check_in 
		)
		
--lo deje como seguro por si se borr--Lo dejo comenta
--Lo dejo comenta

--parte04
		
INSERT INTO public.costos_habitacion (hotel_codigo, nro_habitacion, fecha_desde, costo_noche, precio_noche) VALUES(6463694, 100, '2006-06-11', 15.67, 34.04);
SELECT * FROM costos_habitacion ch  WHERE hotel_codigo = 6461797 AND nro_habitacion=100
SELECT * FROM costos_habitacion ch  WHERE 
hotel_codigo = 6461797 AND nro_habitacion=101

INSERT INTO public.costos_habitacion
(hotel_codigo, nro_habitacion, fecha_desde, costo_noche, precio_noche)
VALUES(6461797, 100, '2019-12-09', 10.00, 23.00);

INSERT INTO public.costos_habitacion
(hotel_codigo, nro_habitacion, fecha_desde, costo_noche, precio_noche)
VALUES(6461797, 100, '2004-12-09', 10.00, 23.00);
SELECT *  FROM estadias_anteriores e NATURAL JOIN costos_habitacion ch3  WHERE --identifica si afecta una estadia
hotel_codigo = 6461797 AND        
e.nro_habitacion = 100 AND 
        ch3.fecha_desde = 	
				(SELECT  MAX(fecha_desde) FROM costos_habitacion ch2 WHERE 
					ch2.hotel_codigo = e.hotel_codigo  AND 
					ch2.nro_habitacion  = e.nro_habitacion  AND 
					ch2.fecha_desde <= e.check_in
					)   AND 
	    NOT EXISTS (SELECT 1 FROM costos_habitacion ch WHERE --No existe otro costo asociado que lo suplante
		        ch.hotel_codigo = e.hotel_codigo AND 
		        ch.nro_habitacion = e.nro_habitacion AND 
		        ch.fecha_desde < ch3.fecha_desde )

SELECT * FROM estadias e NATURAL JOIN costos_habitacion ch3 WHERE --La fecha excede el check_in, osea queda estadia sin precio
		        	e.hotel_codigo = 6461797 AND 
		        	e.nro_habitacion = 100 AND 
		       		fecha_desde > e.check_in 		        
--parte05

SELECT  * FROM registro_uso
SELECT * FROM estadias_anteriores ea ORDER BY check_in  DESC
SELECT * FROM reservas_anteriores ra   ORDER BY check_in  DESC
SELECT * FROM estadias_anteriores ea ORDER BY check_in  DESC
SELECT * FROM clientes ea ORDER BY check_in  DESC

UPDATE estadias_anteriores SET check_out='2022-12-21' WHERE hotel_codigo=6512340 


--parte06
SELECT  * FROM audit_estadia ae 
SELECT * FROM estadias_anteriores ea ORDER BY check_in  DESC
INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) 
VALUES(6462572, 103, 72560288, '2023-04-08', '2013-04-25');

SELECT hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out 
FROM estadias_anteriores WHERE hotel_codigo=6462572 AND nro_habitacion=101 
AND cliente_documento=72560288 AND check_in='2023-04-08';
--parte07

SELECT * FROM finguitos_usuarios ORDER BY fecha_operacion  DESC
SELECT * FROM estadias_anteriores ea ORDER BY check_in  DESC

INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, 
cliente_documento, check_in, check_out) 
VALUES(6462572, 101, 72560288, '2045-04-08', '2050-04-25');

SELECT check_out - check_in FROM estadias_anteriores WHERE hotel_codigo=6462572 AND nro_habitacion=103 AND cliente_documento=72560288 AND check_in='2023-04-08';


SELECT * FROM costos_habitacion ch WHERE hotel_codigo = 6462572 AND nro_habitacion = 103
SELECT precio_noche   FROM costos_habitacion ch WHERE
	hotel_codigo =6462572 AND nro_habitacion = 103 AND
	fecha_desde = (
	    SELECT MAX(fecha_desde) 
	    FROM costos_habitacion ch2 WHERE ch.hotel_codigo = ch2.hotel_codigo AND ch.nro_habitacion = ch2.nro_habitacion
	);

SELECT * FROM estadias_anteriores ea WHERE hotel_codigo = 2605099 AND 
    		 cliente_documento = 56367622 AND check_in <>'2020-12-11'  
    		 
INSERT INTO public.estadias_anteriores
(hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out)
VALUES(2605099, 101, 56367622, '2023-12-15', '2010-12-22');
