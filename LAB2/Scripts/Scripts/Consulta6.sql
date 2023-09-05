/*Devolver el identificador, nombre, cantidad de estrellas y nombre de la ciudad de ubicación de los hoteles
para los cuales se tienen reservas pero ninguna estadía*/

----------------------------------------------
SELECT r.hotel_codigo, h.nombre, estrellas, c.nombre AS ciudad_nombre FROM 
		reservas r ,hoteles h, ciudades c WHERE
		r.hotel_codigo = h.hotel_codigo AND
		h.ciudad_codigo = c.ciudad_codigo AND 
		h.pais_codigo = c.pais_codigo AND 
		h.division_politica_codigo = c.division_politica_codigo AND 
		(r.hotel_codigo,r.nro_habitacion,r.cliente_documento,r.check_in)  IN (
			SELECT hotel_codigo,
			       nro_habitacion,
			       cliente_documento,
			       check_in 
			FROM reservas
			EXCEPT(
			SELECT hotel_codigo,
			       nro_habitacion,
			       cliente_documento,
			       check_in 
			FROM estadias)
		)
----------------------------------------------
SELECT * FROM hoteles h2 
		
SELECT r.hotel_codigo, h.nombre, estrellas, c.nombre AS ciudad_nombre FROM 
		reservas_anteriores r ,hoteles h, ciudades c WHERE
		r.hotel_codigo = h.hotel_codigo AND
		h.ciudad_codigo = c.ciudad_codigo AND 
		h.pais_codigo = c.pais_codigo AND 
		h.division_politica_codigo = c.division_politica_codigo AND 
		(r.hotel_codigo,r.nro_habitacion,r.cliente_documento,r.check_in) IN (
			SELECT hotel_codigo,
			       nro_habitacion,
			       cliente_documento,
			       check_in 
			FROM reservas_anteriores
			EXCEPT(
			SELECT hotel_codigo,
			       nro_habitacion,
			       cliente_documento,
			       check_in 
			FROM estadias_anteriores)
		)
		
INSERT INTO reservas_anteriores
(hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in)
VALUES(6325565, 101, 81449752, '2020-02-02', '2022-02-17');

INSERT INTO reservas_anteriores
(hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in)
VALUES(6461789, 101, 81449752, '2020-02-02', '2022-02-17');

INSERT INTO estadias_anteriores
(hotel_codigo, nro_habitacion, cliente_documento, check_in , check_out)
VALUES(6325565, 101, 81449752, '2022-02-17', '2022-02-20');

SELECT * FROM reservas_anteriores
EXCEPT
SELECT * FROM estadias_anteriores
hoteles (hotel_codigo, nombre, estrellas, latitud, longitud, pais_codigo, division_politica_codigo,
ciudad_codigo)

--Se ve la diferencia de conjuntos
SELECT r.hotel_codigo, h.nombre, estrellas, c.nombre AS ciudad_nombre FROM 
	reservas_anteriores r NATURAL JOIN hoteles h, ciudades c 
	WHERE 
		h.ciudad_codigo = c.ciudad_codigo AND 
		h.pais_codigo = c.pais_codigo AND 
		h.division_politica_codigo = c.division_politica_codigo AND
		r.hotel_codigo IN (
		SELECT hotel_codigo,
		       nro_habitacion,
		       cliente_documento,
		       check_in 
		FROM reservas_anteriores
		EXCEPT(
		SELECT hotel_codigo,
		       nro_habitacion,
		       cliente_documento,
		       check_in 
		FROM estadias_anteriores)
		)

ciudades (pais_codigo, division_politica_codigo, ciudad_codigo,nombre,latitud,longitud)

estadias: hotel_codigo, nro_habitacion, cliente_documento, check_in

reservas(nro_habitacion
hotel_codigo
cliente_documento
fecha_reserva
check_in
check_out
precio_noche)



