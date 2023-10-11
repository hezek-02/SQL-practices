-- Crear la función actividad_cliente
CREATE OR REPLACE FUNCTION actividad_cliente(codigo CHAR(1), clientedoc INTEGER, anio INTEGER,OUT cantidad INTEGER)
RETURNS INTEGER AS 
$$--delimita rango de la funcion
BEGIN
    -- Verificar si el cliente existe
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE cliente_documento = clientedoc) THEN
        RAISE NOTICE 'No existe el cliente';
    -- Calcular la cantidad de reservas o estadías según el código
    ELSIF codigo = 'R' OR codigo = 'r' THEN
        RETURN(
	        SELECT COUNT(*) FROM reservas_anteriores
	        WHERE cliente_documento = clientedoc
	        AND EXTRACT(YEAR FROM fecha_reserva) = anio
	       );
    ELSIF codigo = 'E' OR codigo = 'e' THEN
        RETURN(
	        SELECT COUNT(*)  FROM estadias_anteriores
	        WHERE cliente_documento = clientedoc
	        AND EXTRACT(YEAR FROM check_in) = anio
	       );
    ELSE
        RAISE NOTICE 'Código de operación incorrecto';
    END IF;

    RETURN NULL;
END;
$$
LANGUAGE plpgsql;
