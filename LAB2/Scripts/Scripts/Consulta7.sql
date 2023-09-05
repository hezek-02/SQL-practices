Interesa conocer las duraciones promedio de las estadías de las personas según su ocupación. AVG()

Devolver para cada ocupación el identificador, descripción y el promedio de duración de los hospedajes. 

El hospedaje promedio debe calcularse con dos dígitos decimales (utilizar la función ROUND4). No se deben
realizar redondeos intermedios.

----------------------------------------------
SELECT ocupacion_codigo, descripcion, ROUND(AVG(check_out - check_in), 2)AS estadia_promedio FROM 
clientes c NATURAL JOIN reservas r NATURAL JOIN ocupaciones o 
GROUP BY (ocupacion_codigo,descripcion)
----------------------------------------------

51691
--pruebas

SELECT * FROM reservas r  WHERE nro_habitacion=104 


SELECT * FROM reservas_anteriores ra  WHERE  cliente_documento='86947966'

SELECT * FROM estadias ea  WHERE  cliente_documento='86947966'
SELECT * FROM estadias_anteriores ea  WHERE  cliente_documento='86947966'

INSERT INTO estadias_anteriores  
(hotel_codigo, nro_habitacion, cliente_documento, check_in , check_out)--SE añaden datos probatorios
VALUES(6509195, 102, 86947966, '2013-03-20', '2014-05-01');

INSERT INTO estadias_anteriores  
(hotel_codigo, nro_habitacion, cliente_documento, check_in , check_out)--SE añaden datos probatorios
VALUES(6509195, 102, 86947966, '2013-03-20', '2014-05-01');

INSERT INTO estadias_anteriores  
(hotel_codigo, nro_habitacion, cliente_documento, check_in , check_out)--
VALUES(6509195, 103, 86947966, '2013-03-20', '2014-05-02');

INSERT INTO reservas_anteriores 
(hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in)
VALUES(6509195, 103, 86947966, '2010-05-01', '2013-03-20');

INSERT INTO estadias_anteriores  
(hotel_codigo, nro_habitacion, cliente_documento, check_in , check_out)--
VALUES(6509195, 100, 86947966, '2013-03-20', '2013-03-23');

INSERT INTO reservas_anteriores 
(hotel_codigo, nro_habitacion, cliente_documento, fecha_reserva, check_in)
VALUES(6509195, 100, 86947966, '2019-05-01', '2013-03-20');


SELECT ocupacion_codigo, descripcion, ROUND(AVG(check_out - check_in), 2)AS estadia_promedio FROM 
clientes c NATURAL JOIN reservas r NATURAL JOIN ocupaciones o WHERE cliente_documento='86947966'
GROUP BY (ocupacion_codigo,descripcion)






SELECT ocupacion_codigo,COUNT(ocupacion_codigo) FROM clientes c NATURAL JOIN ocupaciones o  
GROUP BY ocupacion_codigo 




SELECT DISTINCT(ocupacion_codigo, descripcion, AVG(check_out-check_in)) AS estadia_promedio FROM 
clientes c NATURAL JOIN estadias_anteriores r NATURAL JOIN ocupaciones o
GROUP BY (ocupacion_codigo, descripcion, check_out,check_in)

SELECT COUNT(*) FROM estadias_anteriores ea 

clientes(cliente_documento, nombre, apellido, sexo, fecha_nacimiento, ocupacion_codigo, pais_codigo,
division_politica_codigo, ciudad_codigo)

SELECT *  FROM ocupaciones o 



SELECT * FROM hoteles h JOIN paises p ON p.pais_codigo=h.pais_codigo WHERE  p.continente_codigo='AN' 
SELECT * FROM hoteles h JOIN paises p ON p.pais_codigo=h.pais_codigo WHERE  p.continente_codigo='SA' 
SELECT * FROM clientes c JOIN paises p ON c.pais_codigo=p.pais_codigo WHERE p.continente_codigo='AN'

