SELECT h . hotel_codigo , h . nombre , h . estrellas , c . nombre AS ciudad_nombre
	FROM public . hoteles h JOIN public . ciudades c
	ON ( c . pais_codigo = h . pais_codigo
	AND c . division_politica_codigo = h . division_politica_codigo
	AND c . ciudad_codigo = h . ciudad_codigo )
		WHERE h . hotel_codigo IN (
		SELECT r . hotel_codigo FROM public . reservas r
			WHERE NOT EXISTS (
			SELECT * FROM public . estadias e
			WHERE r . hotel_codigo = e . hotel_codigo
			AND r . nro_habitacion = e . nro_habitacion
			AND r . check_in = e. check_in)
			);