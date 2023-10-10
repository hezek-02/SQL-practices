-- usando sintaxis join en el from
SELECT hotel_codigo , h . nombre AS hotel_nombre
	FROM paises p JOIN ciudades c USING ( pais_codigo )
	JOIN hoteles h
	USING ( pais_codigo , division_politica_codigo , ciudad_codigo )
		WHERE p . continente_codigo = 'EU' -- del continente europeo ( ’ EU ’)
			AND h . estrellas > 3 -- con mas de 3 estrellas
			-- cuyo nombre es igual al nombre de la ciudad donde estan
			AND h . nombre = c. nombre