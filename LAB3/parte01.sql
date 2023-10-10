-- Crear la función actividad_cliente
CREATE OR REPLACE FUNCTION actividad_cliente(codigo CHAR(1), clientedoc INTEGER, anio INTEGER)
RETURNS INTEGER AS $$
DECLARE
    cantidad INTEGER;
BEGIN
    -- Verificar si el cliente existe
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE doc = clientedoc) THEN
        RAISE EXCEPTION 'No existe el cliente';
    END IF;

    -- Calcular la cantidad de reservas o estadías según el código
    IF codigo = 'R' OR codigo = 'r' THEN
        SELECT COUNT(*) INTO cantidad
        FROM reservas
        WHERE cliente_doc = clientedoc
        AND EXTRACT(YEAR FROM fecha_reserva) = anio;
    ELSIF codigo = 'E' OR codigo = 'e' THEN
        SELECT COUNT(*) INTO cantidad
        FROM estadias
        WHERE cliente_doc = clientedoc
        AND EXTRACT(YEAR FROM check_in) = anio;
    ELSE
        RAISE EXCEPTION 'Código de operación incorrecto';
    END IF;

    RETURN cantidad;
END;
$$ LANGUAGE plpgsql;
