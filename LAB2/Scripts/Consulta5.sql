SELECT c.cliente_documento, concat(c.nombre,' ',c.apellido) AS nombre_completo FROM
	estadias e	NATURAL JOIN clientes c,
	limitan l, hoteles h 
	WHERE 
		h.hotel_codigo = e.hotel_codigo AND l.pais1_codigo = c.pais_codigo AND l.pais2_codigo = h.pais_codigo 
