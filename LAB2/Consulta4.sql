CREATE VIEW reservas AS SELECT rasp.hotel_codigo, 
	rasp.nro_habitacion, 
	cliente_documento, 
	fecha_reserva, 
	check_in,
	check_out, 
	precio_noche 
	FROM
		reservas_anteriores_sin_precio rasp NATURAL JOIN costos_habitacion ch 
		WHERE ch.fecha_desde = (
		SELECT 
			MAX(fecha_desde)
			FROM
				costos_habitacion ch2 
				WHERE
					rasp.nro_habitacion = ch2.nro_habitacion AND 
					rasp.hotel_codigo = ch2.hotel_codigo AND 
					ch2.fecha_desde <= rasp.check_in
			)

