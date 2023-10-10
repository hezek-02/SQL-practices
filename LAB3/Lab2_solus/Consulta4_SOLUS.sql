CREATE VIEW reservas AS SELECT r . hotel_codigo , r . nro_habitacion , r . cliente_documento ,
	r . fecha_reserva , r . check_in , r . check_out , c . precio_noche
	FROM reservas_anteriores_sin_precio AS r JOIN costos_habitacion AS c
	USING ( hotel_codigo , nro_Habitacion )
		WHERE r . check_in >= c . fecha_desde
		AND NOT EXISTS
		( SELECT 1
		FROM costos_habitacion c2
			WHERE r . hotel_codigo = c2 . hotel_codigo
			AND r . nro_habitacion = c2 . nro_habitacion
			AND r . check_in >= c2 . fecha_desde
			AND c2 . fecha_desde > c . fecha_desde );