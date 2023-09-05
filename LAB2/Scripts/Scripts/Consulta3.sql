--OPC1
CREATE VIEW  reservas_anteriores_sin_precio AS SELECT 
	ra.hotel_codigo,
	ra.nro_habitacion,
	ra.cliente_documento, 
	ra.fecha_reserva, 
	ra.check_in, 
	check_out
	FROM
	estadias_anteriores ea JOIN reservas_anteriores ra 
	ON
		ea.hotel_codigo=ra.hotel_codigo	AND 
		ea.nro_habitacion=ra.nro_habitacion AND 
		ea.check_in=ra.check_in AND 
		NOT EXISTS (
			SELECT ra2.hotel_codigo,ra2.nro_habitacion,ra2.fecha_reserva FROM reservas_anteriores ra2 
			WHERE
				ra2.hotel_codigo =ea.hotel_codigo AND 
				ea.nro_habitacion=ra2.nro_habitacion AND 
				ra2.fecha_reserva> ra.fecha_reserva
			)

--OPC2
CREATE VIEW  reservas_anteriores_sin_precio AS SELECT 
	ra.hotel_codigo,
	ra.nro_habitacion,
	ra.cliente_documento, 
	ra.fecha_reserva, 
	ra.check_in, 
	check_out
	FROM
	estadias_anteriores ea NATURAL JOIN reservas_anteriores ra WHERE 
		NOT EXISTS (
			SELECT * FROM estadias_anteriores ea2 NATURAL JOIN reservas_anteriores ra2
			WHERE
				ra2.fecha_reserva > ra.fecha_reserva
			)

			
SELECT * FROM reservas_anteriores ra, estadias_anteriores ea WHERE ra.cliente_documento<>ea.cliente_documento AND 
ea.hotel_codigo =ra.hotel_codigo AND ra.nro_habitacion =ea.nro_habitacion AND ea.check_in=ra.check_in 
			
SELECT * FROM reservas_anteriores_sin_precio
--PREGUNTAR SI CAMBIAR POR NATURAL JOIN(el mismo cliente que realiza la reserva, figura la estadia)
SELECT  
	ra.hotel_codigo,
	ra.nro_habitacion,
	ra.cliente_documento, 
	ra.fecha_reserva, 
	ra.check_in, 
	check_out
	FROM
	estadias_anteriores ea NATURAL JOIN reservas_anteriores ra WHERE
		NOT EXISTS (
			SELECT ra2.hotel_codigo,ra2.nro_habitacion,ra2.fecha_reserva FROM reservas_anteriores ra2 
			WHERE
				ra2.hotel_codigo =ea.hotel_codigo AND 
				ea.nro_habitacion=ra2.nro_habitacion AND 
				ra2.fecha_reserva> ra.fecha_reserva
			)


--Se ve los datos repetidos elimnados
SELECT * FROM reservas_anteriores ra WHERE hotel_codigo IN (6461828,6463689);
SELECT * FROM reservas_anteriores_sin_precio WHERE hotel_codigo IN (6461828,6463689);


--Se ve la diferencia de conjuntos
SELECT hotel_codigo,
       nro_habitacion,
       cliente_documento,
       check_in 
FROM estadias
EXCEPT(
SELECT hotel_codigo,
       nro_habitacion,
       cliente_documento,
       check_in 
FROM reservas_anteriores_sin_precio)

