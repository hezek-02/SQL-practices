SELECT  hotel_codigo, h.nombre FROM 
	hoteles h, 
	ciudades c ,
	paises p 
	WHERE 
		c.nombre = h.nombre AND 
		h.estrellas > 3 AND 
		p.continente_codigo = 'EU' AND 
		p.pais_codigo = c.pais_codigo; 



