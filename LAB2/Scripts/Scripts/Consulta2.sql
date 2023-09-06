CREATE VIEW estadias AS SELECT 
	ea.hotel_codigo, 
	ea.nro_habitacion, 
	ea.cliente_documento, 
	ea.check_in 
	FROM
		estadias_anteriores ea JOIN reservas_anteriores ra
		ON
		ea.hotel_codigo = ra.hotel_codigo AND 
		ea.nro_habitacion = ra.nro_habitacion AND
		ea.check_in = ra.check_in 


		