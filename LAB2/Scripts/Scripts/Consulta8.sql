----------------------------------------------
SELECT ocupacion_codigo, descripcion, ROUND(AVG(check_out - check_in), 2)AS estadia_promedio FROM 
	clientes c 
	NATURAL JOIN 
	reservas r 
	NATURAL JOIN 
	ocupaciones o 
	GROUP BY (ocupacion_codigo,descripcion)
----------------------------------------------
Devolver el documento, nombre completo y fecha de nacimiento de los clientes que han visitado todos los
continentes registrados en el sistema. Para generar el campo nombre_completo se debe aplicar el mismo
criterio que en la consulta 5.

--CANDIDATO FUERTE
SELECT cl.cliente_documento, concat(cl.nombre,' ',cl.apellido) AS nombre_completo, fecha_nacimiento
   	FROM
    clientes cl
	WHERE
    NOT EXISTS (
        SELECT co.continente_codigo
        FROM continentes co
        WHERE NOT EXISTS (
            SELECT p.continente_codigo
            FROM paises p
            WHERE p.continente_codigo = co.continente_codigo
            AND EXISTS (
                SELECT e.hotel_codigo
                FROM estadias e NATURAL JOIN hoteles h
                WHERE e.cliente_documento = cl.cliente_documento
                AND h.pais_codigo = p.pais_codigo
            )
        )
    );



SELECT cl.cliente_documento, concat(cl.nombre,' ',cl.apellido) AS nombre_completo, fecha_nacimiento FROM
	clientes cl, estadias e NATURAL JOIN hoteles h, paises p 
	WHERE
	cl.cliente_documento = e.cliente_documento AND 
	h.pais_codigo=p.pais_codigo AND 
		NOT EXISTS 
		(SELECT continente_codigo FROM continentes co WHERE
			EXISTS
			(SELECT * FROM estadias e2 NATURAL JOIN hoteles h2, paises p2 
				WHERE 
				cl.cliente_documento = e2.cliente_documento AND 
				h2.pais_codigo=p2.pais_codigo OR p2.pais_codigo=cl.pais_codigo AND
				p2.continente_codigo = co.continente_codigo
			)                                                                                               
		)
		
SELECT * FROM estadias e WHERE cliente_documento=30030157 

SELECT * FROM paises p 
WHERE 
    pais_codigo IN (
        SELECT pais_codigo 
        FROM hoteles h 
        WHERE hotel_codigo IN (6464472, 6508488)
    )
    OR
    pais_codigo IN (
        SELECT pais_codigo 
        FROM clientes c 
        WHERE cliente_documento = 30030157
    );
   
 SELECT * FROM continentes c 

	