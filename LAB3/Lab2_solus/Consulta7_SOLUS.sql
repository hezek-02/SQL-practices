SELECT o . ocupacion_codigo , o . descripcion ,
	round ( AVG ( r . check_out - r . check_in ) , 2) AS estadia_promedio
	FROM public . ocupaciones o NATURAL JOIN public . clientes c
	NATURAL JOIN public . estadias e
	JOIN public . reservas r ON ( r . hotel_codigo = e . hotel_codigo
	AND r . nro_habitacion = e . nro_habitacion
	AND r . check_in = e . check_in )
	GROUP BY o . ocupacion_codigo , o . descripcion ;