SELECT ocupacion_codigo, descripcion, ROUND(AVG(check_out - check_in), 2)AS estadia_promedio FROM 
	clientes c NATURAL JOIN reservas r NATURAL JOIN ocupaciones o 
	GROUP BY (ocupacion_codigo,descripcion)



