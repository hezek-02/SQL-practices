SELECT c.cliente_documento, concat(c.nombre,' ',c.apellido) AS nombre_completo FROM
	estadias e	NATURAL JOIN 	clientes c,
	limitan l, hoteles h 
	WHERE 
		h.hotel_codigo = e.hotel_codigo AND l.pais1_codigo = c.pais_codigo AND l.pais2_codigo = h.pais_codigo 


/*
Devolver el documento y nombre completo de los clientes que se hospedaron en al menos un hotel de un
país limítrofe con su país de residencia. El atributo nombre_completo se forma como la concatenación3 del
nombre y apellido de los clientes, usando un espacio en blanco como separador. Por ejemplo si el cliente
tiene nombre: ‘LORI’ y apellido: ‘WOOD’ el atributo nombre_completo deberá tener el valor: 'LORI WOOD'.
Resolverla en:
• cálculo relacional (para la expresión el cálculo devuelva el nombre y el apellido separados), y
• SQL
*/

estadias: hotel_codigo, nro_habitacion, cliente_documento, check_in

cliente: cliente_documento, nombre, apellido, sexo, fecha_nacimiento, ocupacion_codigo, pais_codigo,
division_politica_codigo, ciudad_codigo

limitan (pais1_codigo, pais2_codigo)