SELECT rasp.hotel_codigo, 
	rasp.nro_habitacion, 
	cliente_documento, 
	fecha_reserva, 
	check_in,
	check_out, 
	precio_noche 
	FROM
		reservas_anteriores_sin_precio rasp JOIN costos_habitacion ch 
		ON 
			rasp.nro_habitacion = ch.nro_habitacion AND 
			rasp.hotel_codigo = ch.hotel_codigo 
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
	
	
/*
Aprovechando la vista definida en la consulta 3 (reservas_anteriores_sin_precio), escribir una
consulta SQL que agregue el precio por noche a esas reservas.
El precio por noche de la reserva es el último precio de la habitación con respecto a la fecha de
check_in. Por ejemplo, si la fecha de check_in de la reserva es 1/5/23 y los precios de la habitación
son (31/8/22, 100), (15/1/23, 150) y (15/8/23, 200), el precio de la reserva es 150.
Nota: Una vez definida, la vista en SQL se trabaja en las consultas como una tabla más.
Usando esta consulta, definir una vista con el nombre reservas y los atributos que se detallan en el
esquema resultado
*/costos_habitacion (hotel_codigo, nro_habitacion, fecha_desde, costo_noche, precio_noche)
