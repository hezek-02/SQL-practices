SELECT  hotel_codigo, h.nombre FROM 
	hoteles h,
	ciudades c, 
	paises p 
	WHERE 
		c.nombre = h.nombre AND
		c.pais_codigo = h.pais_codigo AND 
		c.ciudad_codigo = h.ciudad_codigo AND 
		c.division_politica_codigo = h.division_politica_codigo AND 
		c.pais_codigo = p.pais_codigo AND
		estrellas > 3 AND 
		continente_codigo = 'EU' 
