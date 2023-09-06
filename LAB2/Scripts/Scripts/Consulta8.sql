SELECT cl.cliente_documento, CONCAT(cl.nombre, ' ', cl.apellido) AS nombre_completo, cl.fecha_nacimiento
	FROM clientes cl
	WHERE 
	NOT EXISTS (
		SELECT co.continente_codigo 
		FROM continentes co WHERE co.continente_codigo NOT IN(
	   	 	SELECT p.continente_codigo
	    	FROM 
	    	paises p,
	    	estadias e NATURAL JOIN hoteles h 
	   	 	WHERE 
	    	(h.pais_codigo = p.pais_codigo OR p.pais_codigo = cl.pais_codigo)  AND
	    	e.cliente_documento = cl.cliente_documento
		)
	);


