


/* PRUEBA CONS1
 * */
SELECT  hotel_codigo, h.nombre FROM 
	hoteles h,
	ciudades c, 
	paises p 
	WHERE 
		c.nombre = h.nombre AND
		c.pais_codigo = h.pais_codigo AND 
		c.ciudad_codigo = h.ciudad_codigo AND 
		c.division_politica_codigo = h.division_politica_codigo AND 
		c.pais_codigo = p.pais_codigo AND
		estrellas > 3 AND 
		continente_codigo = 'EU' 

SELECT * FROM hoteles h 	
SELECT * FROM ciudades c WHERE pais_codigo='ES'
SELECT * FROM paises p WHERE pais_codigo='ES'
--AÑADO HOTEL DE EUROPA CON NOMBRE DE PAIS Y MAS DE 3STARS, LA DIVISION Y CODIGO CIUDAD DEBEN SER EL MISMO, EN PRIMERA INSTANCIA NO LO ERAN Y NO MOSTRABA LUEGO LO UPDATEE
INSERT INTO hoteles (hotel_codigo, nombre, estrellas, latitud, longitud, pais_codigo, division_politica_codigo, ciudad_codigo) VALUES(777, 'MADRID', 5, 38.3751100, -0.4215400, 'ES', 1977, 915);
UPDATE hoteles SET nombre='Murcia', estrellas=5, latitud=38.3751100, longitud=-0.4215400, pais_codigo='ES', division_politica_codigo=1945, ciudad_codigo=110 WHERE hotel_codigo=777;



/* PRUEBA CONS2
 * */

--VERSION 1- no controla que el cliente sea el mismo
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

--VERSION 2 controla que el cliente sea el mismo
CREATE VIEW estadias AS SELECT 
	ea.hotel_codigo, 
	ea.nro_habitacion, 
	ea.cliente_documento, 
	ea.check_in 
	FROM
		estadias_anteriores ea NATURAL JOIN reservas_anteriores ra
		

/* PRUEBA CONS3
 * */
--VERSION 1 no controla cliente
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
				ra2.hotel_codigo = ea.hotel_codigo AND 
				ra2.nro_habitacion = ea.nro_habitacion AND
				ra2.check_in = ea.check_in  AND 
				ra2.fecha_reserva > ra.fecha_reserva
			)
			
--VERSION 2, controla cliente sea el right guy
CREATE VIEW  reservas_anteriores_sin_precio AS SELECT 
	ra.hotel_codigo,
	ra.nro_habitacion,
	ra.cliente_documento, 
	ra.fecha_reserva, 
	ra.check_in, 
	check_out
	FROM
	estadias_anteriores ea NATURAL JOIN reservas_anteriores ra 
		NOT EXISTS (
			SELECT ra2.hotel_codigo,ra2.nro_habitacion,ra2.fecha_reserva FROM reservas_anteriores ra2 
			WHERE
				ra2.hotel_codigo = ea.hotel_codigo AND 
				ra2.cliente_documento = ea.cliente_documento AND
				ra2.nro_habitacion = ea.nro_habitacion AND
				ra2.check_in = ea.check_in  AND 
				ra2.fecha_reserva > ra.fecha_reserva
			)
			
			
SELECT * FROM reservas_anteriores ra WHERE nro_habitacion=69
SELECT * FROM estadias_anteriores ea WHERE nro_habitacion=69
SELECT * FROM reservas r WHERE nro_habitacion=69
SELECT * FROM estadias e  WHERE nro_habitacion=69
SELECT 
	ea.hotel_codigo, 
	ea.nro_habitacion, 
	ea.cliente_documento, 
	ea.check_in 
	FROM
		estadias_anteriores ea NATURAL JOIN reservas_anteriores ra
	 WHERE ra.nro_habitacion=69
		
SELECT * FROM clientes c 
INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(1, 69, 81449752, '2027-02-02', '2023-02-17');
INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(1, 69, 81449752, '2023-02-17', '2013-12-22');
7861038
INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(1, 69, 4555872, '2030-02-02', '2038-02-17');
INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(1, 69, 96777620, '2038-02-17', '2013-12-22');

/* PRUEBA CONS4
 * */
--FUNCIONA
SELECT rasp.hotel_codigo, 
	rasp.nro_habitacion, 
	cliente_documento, 
	fecha_reserva, 
	check_in,
	check_out, 
	precio_noche 
	FROM
		reservas_anteriores_sin_precio rasp NATURAL JOIN costos_habitacion ch 
		WHERE ch.fecha_desde = (
		SELECT 
			MAX(fecha_desde)
			FROM
				costos_habitacion ch2 
				WHERE
					rasp.nro_habitacion = ch2.nro_habitacion AND 
					rasp.hotel_codigo = ch2.hotel_codigo AND 
					ch2.fecha_desde <= rasp.check_in
			) AND hotel_codigo=6325565 AND nro_habitacion=101
			
SELECT * FROM reservas_anteriores ra3 
SELECT * FROM costos_habitacion ch3 WHERE hotel_codigo=6325565 AND nro_habitacion=101--deberia traer 33,92 para la nueva res
--AÑADO NUEVA RESERVE
INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(6325565, 101, 81449752, '2011-02-02', '2070-02-17');
INSERT INTO costos_habitacion (hotel_codigo, nro_habitacion, fecha_desde, costo_noche, precio_noche) VALUES(6325565, 101, '2018-05-01', 15.55, 311.3213);
 

/*PRUEBA CONS5
 * */
SELECT c.cliente_documento, concat(c.nombre,' ',c.apellido) AS nombre_completo FROM
	estadias e	NATURAL JOIN clientes c,
	limitan l, hoteles h 
	WHERE 
		h.hotel_codigo = e.hotel_codigo AND l.pais1_codigo = c.pais_codigo AND l.pais2_codigo = h.pais_codigo 

SELECT * FROM clientes c NATURAL JOIN estadias e,limitan l,hoteles h  WHERE 	h.hotel_codigo = e.hotel_codigo AND l.pais1_codigo = c.pais_codigo AND l.pais2_codigo = h.pais_codigo 
SELECT * FROM paises p WHERE pais_codigo='CN'
SELECT * FROM estadias e2 WHERE cliente_documento=81449752

INSERT INTO estadias (hotel_codigo, nro_habitacion, cliente_documento, check_in) VALUES(6325565, 101, 81449752, '2011-02-17');
INSERT INTO estadias (hotel_codigo, nro_habitacion, cliente_documento, check_in) VALUES(6325565, 101, 81449752, '2020-02-17');

/* PRUEBA CONS6
 */

--FUNCIONA
SELECT r.hotel_codigo, h.nombre, estrellas, c.nombre AS ciudad_nombre FROM 
		reservas_anteriores r NATURAL JOIN hoteles h, ciudades c WHERE
		h.ciudad_codigo = c.ciudad_codigo AND 
		h.pais_codigo = c.pais_codigo AND 
		h.division_politica_codigo = c.division_politica_codigo AND 
		(r.hotel_codigo,r.nro_habitacion,r.cliente_documento,r.check_in)  IN (
			SELECT hotel_codigo,
			       nro_habitacion,
			       cliente_documento,
			       check_in 
			FROM reservas_anteriores ra 
			EXCEPT(
			SELECT hotel_codigo,
			       nro_habitacion,
			       cliente_documento,
			       check_in 
			FROM estadias_anteriores ea)
		)

SELECT * FROM reservas_anteriores ra 
--AÑADO RESERVA SIN ESTADIA
INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(6325565, 101, 81449752, '2012-02-02', '2020-02-17');
SELECT * FROM estadias_anteriores ea 
--AÑADO ESTADIA A LA RESERVA
INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(6325565, 101, 81449752, '2020-02-17', '2022-12-22');


/* PRUEBA CONS7
 * */
--FUNCIONA
SELECT ocupacion_codigo, descripcion, ROUND(AVG(check_out - check_in), 2)AS estadia_promedio FROM 
	clientes c NATURAL JOIN reservas r NATURAL JOIN ocupaciones o 
	WHERE ocupacion_codigo='24513'GROUP BY (ocupacion_codigo,descripcion)
	
SELECT * FROM reservas r  WHERE cliente_documento=43838886
SELECT * FROM reservas_anteriores WHERE cliente_documento=43838886
SELECT * FROM estadias_anteriores ea  WHERE cliente_documento=43838886

SELECT * FROM clientes NATURAL JOIN ocupaciones o WHERE cliente_documento=43838886

INSERT INTO reservas_anteriores  (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(6325565, 104, 43838886, '2012-11-17', '2013-10-12');
INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(6325565, 104, 43838886, '2013-10-12', '2013-10-15');

INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(6325565, 104, 43838886, '2013-10-17', '2014-10-15');
INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(6325565, 104, 43838886, '2014-10-15', '2014-10-18');


/* PRUEBA CONS8
 * */

--NO TENGO IDEA SI FUNCIONA, no existe continente, tal que no existe pais que tenga ese continente y que hayan visitado dicho pais
--creo q  no funciona si existe un continente sin pais asociado
SELECT cl.cliente_documento, concat(cl.nombre,' ',cl.apellido) AS nombre_completo, fecha_nacimiento
   	FROM
    clientes cl
	WHERE
    NOT EXISTS (
        SELECT co.continente_codigo
        FROM continentes co
        WHERE NOT EXISTS (
            SELECT p.continente_codigo
            FROM paises p
            WHERE p.continente_codigo = co.continente_codigo
            AND EXISTS (
                SELECT e.hotel_codigo
                FROM estadias e NATURAL JOIN hoteles h
                WHERE e.cliente_documento = cl.cliente_documento
                AND h.pais_codigo = p.pais_codigo OR p.pais_codigo=cl.pais_codigo
            )
        )
    );
        

--FUNCIONARIA POR INTUICION, DEMORA DEMASIADO POR EL OR COUNT Y DISTINCT, demora como 18segundos
  SELECT cl.cliente_documento, CONCAT(cl.nombre, ' ', cl.apellido) AS nombre_completo, cl.fecha_nacimiento
	FROM clientes cl
	WHERE (
	SELECT COUNT(DISTINCT co.continente_codigo)
	FROM continentes co
	) = (
    SELECT COUNT(DISTINCT p.continente_codigo)
    FROM 
    paises p,
    estadias e NATURAL JOIN
    hoteles h 
    WHERE 
    (h.pais_codigo = p.pais_codigo OR p.pais_codigo=cl.pais_codigo)  AND
    e.cliente_documento = cl.cliente_documento
	);


--CANDIDATO FUERTE, TUPLAS TLQ, NO EXISTE CODIGO DE CONTINENTE QUE NO PERTENEZCA A LOS CONTINENTES VISITADOS
SELECT cl.cliente_documento, CONCAT(cl.nombre, ' ', cl.apellido) AS nombre_completo, cl.fecha_nacimiento
	FROM clientes cl
	WHERE 
	NOT EXISTS (
		SELECT co.continente_codigo 
		FROM continentes co WHERE co.continente_codigo NOT IN(
	   	 	SELECT p.continente_codigo
	    	FROM 
	    	paises p,
	    	estadias e NATURAL JOIN hoteles h 
	   	 	WHERE 
	    	(h.pais_codigo = p.pais_codigo OR p.pais_codigo = cl.pais_codigo)  AND
	    	e.cliente_documento = cl.cliente_documento
		)
	);

SELECT cl.cliente_documento, CONCAT(cl.nombre, ' ', cl.apellido) AS nombre_completo, fecha_nacimiento
FROM clientes cl
WHERE NOT EXISTS(
    SELECT co.continente_codigo
    FROM continentes co
    WHERE co.continente_codigo NOT IN(
	    SELECT co2.continente_codigo
	    FROM paises p,continentes co2,estadias e NATURAL JOIN hoteles h    
	    WHERE e.cliente_documento = cl.cliente_documento AND
	    p.pais_codigo = co2.continente_codigo AND
	    (p.pais_codigo = h.pais_codigo  OR 
	    p.pais_codigo = cl.pais_codigo )
		)
	)
SELECT * FROM continentes c2 

AN	Antarctica

SELECT * FROM ciudades c WHERE c.pais_codigo  IN ('AQ','BV','GS','HM','TF')

SELECT * FROM hoteles h2 NATURAL JOIN habitaciones h3  WHERE h2.pais_codigo IN (SELECT pais_codigo  FROM paises p2 WHERE p2.continente_codigo='AN')

SELECT * FROM estadias e NATURAL JOIN clientes c, hoteles h, paises p,continentes c2  WHERE cliente_documento=81449752 AND e.hotel_codigo= h.hotel_codigo AND p.pais_codigo=h.pais_codigo 

SELECT * FROM estadias_anteriores  WHERE cliente_documento=81449752--AS posee
SELECT * FROM reservas_anteriores  WHERE cliente_documento=81449752

SELECT * FROM estadias e  WHERE cliente_documento=81449752
SELECT * FROM reservas r  WHERE cliente_documento=81449752


--GENERAR DATOS PARA HOTEL IN THE ARTIC ANTARTIC
INSERT INTO divisiones_politicas (pais_codigo, division_politica_codigo, nombre, zona_horaria) VALUES('TF', 0, 'ARTICO CAGADO DE FRIOOOO', 'ANTARTIDA/FRANCH');
INSERT INTO ciudades (pais_codigo, division_politica_codigo, ciudad_codigo, nombre, latitud, longitud) VALUES('TF', 0, 0, 'INUIT TERR', 128.5364000, 542.4565000);
INSERT INTO habitaciones (hotel_codigo, nro_habitacion, tipo_habitacion_codigo, m2) VALUES(1, 69, 4, 52);
INSERT INTO costos_habitacion (hotel_codigo, nro_habitacion, fecha_desde, costo_noche, precio_noche) VALUES(1, 69, '2009-02-27', 20.16, 60.07);
SELECT * FROM costos_habitacion ch

--DAR DE ALTAS HOTEL EN AN
INSERT INTO hoteles (hotel_codigo, nombre, estrellas, latitud, longitud, pais_codigo, division_politica_codigo, ciudad_codigo) VALUES(1, 'IGLU INSANO', 5, 47.6166700, 13.7666700, 'TF', 0, 	0);

--DAR ESTADIAS EN HOTELES NUEVOS

INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(6461846, 100, 81449752, '2020-02-17', '2022-12-22');--AFRICA
INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(6461846, 100, 81449752, '2012-02-02', '2020-02-17');

INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(6461804, 100, 81449752, '2020-02-17', '2022-12-22');--SA
INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(6461804, 100, 81449752, '2012-02-02', '2020-02-17');

INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(6462911, 100, 81449752, '2020-02-17', '2022-12-22');--NA
INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(6462911, 100, 81449752, '2012-02-02', '2020-02-17');

INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(6493798, 100, 81449752, '2020-02-17', '2022-12-22');--OC
INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(6493798, 100, 81449752, '2012-02-02', '2020-02-17');

INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(6461826, 100, 81449752, '2020-02-17', '2022-12-22');--EU
INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(6461826, 100, 81449752, '2012-02-02', '2020-02-17');

INSERT INTO estadias_anteriores (hotel_codigo, nro_habitacion, cliente_documento, check_in, check_out) VALUES(1, 69, 81449752, '2020-02-17', '2022-12-22');--AN
INSERT INTO reservas_anteriores (hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in) VALUES(1, 69, 81449752, '2012-02-02', '2020-02-17');

---------
SELECT * FROM hoteles h JOIN paises p ON p.pais_codigo=h.pais_codigo WHERE  p.continente_codigo='SA' 
SELECT * FROM clientes c JOIN paises p ON c.pais_codigo=p.pais_codigo WHERE p.continente_codigo='AN'
SELECT * FROM paises p2 WHERE pais_codigo='TF'
SELECT * FROM ciudades c2 WHERE pais_codigo='TF'
SELECT * FROM divisiones_politicas dp 
SELECT * FROM habitaciones h2 
SELECT * FROM  paises p WHERE  p.continente_codigo='AN' 

