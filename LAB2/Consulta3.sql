CREATE VIEW  reservas_anteriores_sin_precio AS SELECT 
	ra.hotel_codigo,
	ra.nro_habitacion,
	ra.cliente_documento, 
	ra.fecha_reserva, 
	ra.check_in, 
	check_out
	FROM
	estadias_anteriores ea JOIN reservas_anteriores ra 
	ON
		ea.hotel_codigo=ra.hotel_codigo	AND 
		ea.nro_habitacion=ra.nro_habitacion AND 
		ea.check_in=ra.check_in AND 
		NOT EXISTS (
			SELECT ra2.hotel_codigo,ra2.nro_habitacion,ra2.fecha_reserva FROM reservas_anteriores ra2 
			WHERE
				ra2.hotel_codigo = ea.hotel_codigo AND 
				ra2.nro_habitacion = ea.nro_habitacion AND
				ra2.check_in = ea.check_in  AND 
				ra2.fecha_reserva > ra.fecha_reserva
			)
		
			
			
			