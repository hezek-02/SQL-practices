
SELECT * FROM reservas_anteriores ra 
SELECT * FROM estadias_anteriores ea  
SELECT * FROM clientes   
--DROP FUNCTION actividad_cliente(char, integer, integer); innecesario por replace
--parte01
SELECT actividad_cliente('r', 81449752, 2011) ;
SELECT actividad_cliente('e', 81449752, 2011) ;
SELECT actividad_cliente('z', 81449752, 2011) ;
SELECT actividad_cliente('z', 312, 2011) ;
SELECT actividad_cliente('E', 312, 2011) ;

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
SELECT * FROM ingreso_extra(6465286);

SELECT * FROM	hoteles h
   		WHERE h.pais_codigo = 'AD'
--parte03

CALL  generar_reporte();

SELECT * FROM resumen
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
aba		
INSERT INTO public.costos_habitacion (hotel_codigo, nro_habitacion, fecha_desde, costo_noche, precio_noche) VALUES(6463694, 100, '2006-06-11', 15.67, 34.04);
SELECT * FROM costos_habitacion ch  WHERE hotel_codigo = 6463694 AND nro_habitacion=100  AND fecha_desde ='2006-06-11'


--parte07
SELECT * FROM finguitos_usuarios ORDER BY fecha_operacion  DESC
SELECT * FROM estadias_anteriores ea ORDER BY check_in  DESC
INSERT INTO public.estadias_anteriores
(hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out)
VALUES(2605099, 101, 56367622, '2022-12-15', '2023-12-21');
SELECT * FROM costos_habitacion ch WHERE hotel_codigo = 2605099 AND nro_habitacion = 101


SELECT * FROM estadias_anteriores ea WHERE hotel_codigo = 2605099 AND 
    		 cliente_documento = 56367622 AND check_in <>'2020-12-11'  
    		 
INSERT INTO public.estadias_anteriores
(hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out)
VALUES(2605099, 101, 56367622, '2010-12-15', '2010-12-22');
