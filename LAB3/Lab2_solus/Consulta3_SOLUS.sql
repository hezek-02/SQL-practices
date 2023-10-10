CREATE VIEW  reservas_anteriores_sin_precio AS SELECT DISTINCT r1 . hotel_codigo , r1 . nro_habitacion , r1 . cliente_documento ,
	r1 . fecha_reserva , r1 . check_in , e1 . check_out
	FROM reservas_anteriores r1 JOIN estadias_anteriores e1
	USING ( hotel_codigo , nro_habitacion , check_in )
		WHERE NOT EXISTS
		( SELECT 1
		FROM reservas_anteriores r2
		WHERE r2 . hotel_codigo = e1 . hotel_codigo
			AND r2 . nro_habitacion = e1 . nro_habitacion
			AND r2 . check_in = e1 . check_in
			AND r2 . fecha_reserva > r1 . fecha_reserva )
			AND NOT EXISTS
			( SELECT 1
			FROM estadias_anteriores e2
				WHERE e2 . hotel_codigo = r1 . hotel_codigo
					AND e2 . nro_habitacion = r1 . nro_habitacion
					AND e2 . check_in = r1 . check_in
					AND e2 . check_out > e1 . check_out );