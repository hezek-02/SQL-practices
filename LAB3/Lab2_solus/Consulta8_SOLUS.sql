SELECT c . cliente_documento ,
	c . nombre || ' ' || c . apellido AS nombre_completo ,
	c . fecha_nacimiento
	FROM clientes c
	WHERE NOT EXISTS (
		SELECT * FROM continentes cn
			WHERE NOT EXISTS (
			SELECT * FROM estadias e
			NATURAL JOIN hoteles
			NATURAL JOIN paises p
			WHERE e . cliente_documento = c . cliente_documento
			AND p . continente_codigo = cn . continente_codigo)
			);