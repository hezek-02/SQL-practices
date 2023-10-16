-- Crear la función actividad_cliente
CREATE OR REPLACE FUNCTION actividad_cliente(codigo CHAR(1), clientedoc INTEGER, anio INTEGER)
RETURNS INTEGER AS 
$actividad_cliente$--delimita rango de la funcion
DECLARE 
	cantidad INTEGER;
BEGIN
	cantidad := 0;
    -- Verificar si el cliente existe
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE cliente_documento = clientedoc) THEN
        RAISE NOTICE 'No existe el cliente';
       	cantidad := -1;
    -- Calcular la cantidad de reservas o estadías según el código
    ELSIF codigo = 'R' OR codigo = 'r' THEN
	        SELECT COUNT(*) INTO cantidad FROM reservas_anteriores
	        WHERE cliente_documento = clientedoc
	        AND EXTRACT(YEAR FROM fecha_reserva) = anio;
    ELSIF codigo = 'E' OR codigo = 'e' THEN
	        SELECT COUNT(*) INTO cantidad  FROM estadias_anteriores
	        WHERE cliente_documento = clientedoc
	        AND EXTRACT(YEAR FROM check_in) = anio;
    ELSE
        RAISE NOTICE 'Código de operación incorrecto';
       	cantidad := -1;
    END IF;

    RETURN cantidad;
END;
$actividad_cliente$
LANGUAGE plpgsql;
