--PREGUNTAR SI CAMBIAR POR JOIN (el mismo cliente que realiza la reserva, figura la estadia)
CREATE VIEW estadias AS SELECT 
	hotel_codigo, 
	nro_habitacion, 
	cliente_documento, 
	check_in 
	FROM
		estadias_anteriores ea NATURAL JOIN reservas_anteriores ra; 

