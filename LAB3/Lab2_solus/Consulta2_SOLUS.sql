-- utilizamos la sentencia DISTINCT porque puede haber mas
-- de una reserva por habitacion , pasajero y fecha check in
CREATE VIEW estadias AS SELECT DISTINCT ea . hotel_codigo , ea . nro_habitacion ,
	ea . cliente_documento , ea . check_in
	FROM estadias_anteriores ea
	JOIN reservas_anteriores ra
	USING ( hotel_codigo , nro_habitacion , check_in );