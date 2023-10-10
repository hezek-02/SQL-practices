SELECT r.hotel_codigo, h.nombre, estrellas, c.nombre AS ciudad_nombre FROM 
		reservas r NATURAL JOIN hoteles h, ciudades c WHERE
		h.ciudad_codigo = c.ciudad_codigo AND 
		h.pais_codigo = c.pais_codigo AND 
		h.division_politica_codigo = c.division_politica_codigo AND 
		(r.hotel_codigo,r.nro_habitacion,r.cliente_documento,r.check_in)  IN (
			SELECT hotel_codigo,
			       nro_habitacion,
			       cliente_documento,
			       check_in 
			FROM reservas
			EXCEPT(
			SELECT hotel_codigo,
			       nro_habitacion,
			       cliente_documento,
			       check_in 
			FROM estadias)
		)



