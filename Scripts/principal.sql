
SELECT * FROM reservas_anteriores ra 
SELECT * FROM estadias_anteriores ea  
SELECT * FROM clientes   


SELECT actividad_cliente('R', 81449752, 2011) ;
SELECT actividad_cliente('e', 81449752, 2011) ;


--DROP FUNCTION actividad_cliente(char, integer, integer);