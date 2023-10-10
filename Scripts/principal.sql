
SELECT * FROM reservas_anteriores ra 
SELECT * FROM estadias_anteriores ea  
SELECT * FROM clientes   
--DROP FUNCTION actividad_cliente(char, integer, integer); innecesario por replace
--parte01
SELECT actividad_cliente('r', 81449752, 2011) ;
SELECT actividad_cliente('e', 81449752, 2011) ;
SELECT actividad_cliente('z', 81449752, 2011) ;
SELECT actividad_cliente('z', 312, 2011) ;
SELECT actividad_cliente('E', 312, 2011) ;

--parte02

