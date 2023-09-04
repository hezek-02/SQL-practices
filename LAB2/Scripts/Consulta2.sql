--PREGUNTAR SI CAMBIAR POR JOIN (el mismo cliente que realiza la reserva, figura la estadia)
CREATE VIEW estadias AS SELECT 
	hotel_codigo, 
	nro_habitacion, 
	cliente_documento, 
	check_in 
	FROM
		estadias_anteriores ea NATURAL JOIN reservas_anteriores ra; 

	
SELECT * FROM 	
		estadias_anteriores ea NATURAL JOIN reservas_anteriores ra; 
		
	SELECT * FROM 	
		estadias_anteriores ea JOIN reservas_anteriores ra ON ea.hotel_codigo=ra.hotel_codigo AND  
		ea.nro_habitacion=ra.nro_habitacion AND 
		ea.check_in = ra.check_in ; 