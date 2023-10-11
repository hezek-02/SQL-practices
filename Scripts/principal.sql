
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
		
SELECT * FROM ingreso_extra(6468804);
