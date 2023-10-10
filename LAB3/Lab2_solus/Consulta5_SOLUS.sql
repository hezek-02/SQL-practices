SELECT C . cliente_documento ,
	C . nombre || ' ' || C . apellido AS nombre_completo
	FROM Clientes C
		WHERE EXISTS
		( SELECT 1
		FROM ( estadias E NATURAL JOIN hoteles H ) JOIN
		Limitan L ON ( L . pais1_codigo = C . pais_codigo
		AND L . pais2_codigo = H . pais_codigo )
		WHERE E . cliente_documento = C . cliente_documento);