CREATE OR REPLACE FUNCTION ingreso_extra(codhotel INTEGER, OUT tipohab SMALLINT, OUT monto NUMERIC(8,2))
RETURNS SETOF RECORD AS --RECORD es un tipo de dato especial, NO es un nombre
$$
BEGIN--Se puede plantear alternativa con FOR IN, y LOOP 
	RETURN QUERY SELECT tipo_habitacion_codigo, SUM((check_out-check_in)*precio_noche)  FROM
		costos_habitacion ch  JOIN habitaciones h ON 
		h.hotel_codigo = ch.hotel_codigo AND 
		h.nro_habitacion = ch.nro_habitacion JOIN estadias_anteriores ea ON 
		ea.hotel_codigo = ch.hotel_codigo  AND 
		ea.nro_habitacion = ch.nro_habitacion WHERE
			ea.hotel_codigo = codhotel AND 
			ch.fecha_desde =--Es la fecha mas cercana al CHECK-IN,la ultima fecha q identifica al precio_noche, alt: NOT EXISTS
				(SELECT  MAX(fecha_desde) FROM costos_habitacion ch2 WHERE 
					ch2.hotel_codigo = ch.hotel_codigo  AND 
					ch2.nro_habitacion  = ch.nro_habitacion  AND 
					ch2.fecha_desde <= ea.check_in
					)
			AND NOT EXISTS --NO existe reserva asociada
				(SELECT 1 FROM 
				reservas_anteriores ra WHERE
				ea.hotel_codigo = ra.hotel_codigo AND 
				ea.nro_habitacion = ra.nro_habitacion AND 
				ea.check_in = ra.check_in 
				)
		GROUP BY tipo_habitacion_codigo;
		
		RETURN;
END;
$$ LANGUAGE plpgsql;
				
