
CREATE TABLE registro_uso (
    usuario TEXT NOT NULL,
    tabla name NOT NULL,
    fecha date NOT NULL,
    cantidad integer NOT NULL,
    PRIMARY KEY (usuario, tabla, fecha)
);

CREATE OR REPLACE FUNCTION registro_operaciones() RETURNS TRIGGER AS $registro_operaciones$ 
BEGIN
    -- Verificar si existe un registro para el usuario, tabla y fecha actual
    IF EXISTS (
        SELECT 1
        FROM registro_uso
        WHERE usuario = current_user
            AND tabla = TG_TABLE_NAME
            AND fecha = CURRENT_DATE
    ) THEN
        -- Actualizar la cantidad de operaciones para el usuario, tabla y fecha actual
        UPDATE registro_uso
        SET cantidad = cantidad + 1
        WHERE usuario = current_user
            AND tabla = TG_TABLE_NAME
            AND fecha = CURRENT_DATE;
    ELSE
        -- Insertar un nuevo registro si no existe
        INSERT INTO registro_uso (usuario, tabla, fecha, cantidad)
        VALUES (current_user, TG_TABLE_NAME, CURRENT_DATE, 1);
    END IF;

    RETURN NEW;
END;

$registro_operaciones$ LANGUAGE plpgsql;

CREATE TRIGGER registro_operaciones
AFTER INSERT OR UPDATE OR DELETE ON estadias_anteriores
FOR EACH ROW EXECUTE FUNCTION registro_operaciones();

CREATE TRIGGER registro_operaciones
AFTER INSERT OR UPDATE OR DELETE ON reservas_anteriores
FOR EACH ROW EXECUTE FUNCTION registro_operaciones();

CREATE TRIGGER registro_operaciones
AFTER INSERT OR UPDATE OR DELETE ON clientes
FOR EACH ROW EXECUTE FUNCTION registro_operaciones();

