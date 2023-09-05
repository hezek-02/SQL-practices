--PREGUNTAR SI CAMBIAR POR JOIN (el mismo cliente que realiza la reserva, figura la estadia)
CREATE VIEW estadias AS SELECT 
	ea.hotel_codigo, 
	ea.nro_habitacion, 
	ea.cliente_documento, 
	ea.check_in 
	FROM
		estadias_anteriores ea JOIN reservas_anteriores ra 
		ON
			ea.hotel_codigo=ra.hotel_codigo AND 
			ea.nro_habitacion=ra.nro_habitacion AND 
			ra.check_in = ea.check_in; 

SELECT * FROM estadias e 

SELECT * FROM reservas_anteriores ra WHERE hotel_codigo IN (6461828,6463689);
SELECT * FROM reservas_anteriores_sin_precio WHERE hotel_codigo IN (6461828,6463689);