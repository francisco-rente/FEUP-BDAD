PRAGMA foreign_keys = ON;
.mode columns
.headers ON
.nullvalue NULL

-- Para cada pedido de apoio de alojamento, identificar o abrigo mais apropriado,
-- considerando um abrigo apropriado sempre que não esteja demasiado longe da
-- área de residência do necessitado.

SELECT PE.primeiroNome || ' ' || PE.ultimoNome AS Necessitado, -- Concatenar nomes
       PE.codigoZona                           AS 'Zona Necessitado',
       AB.codigoZona                           AS 'Zona Abrigo',
       MIN(ABS(PE.codigoZona - AB.codigoZona)) AS Distancia
FROM PedidoApoio PA,
     Abrigo AB
         INNER JOIN Pessoa PE ON PE.id = PA.pedinte
WHERE PA.tipo LIKE 'Alojamento' -- Apenas pedidos de alojamento
  -- Apenas pedidos não atribuídos
  AND NOT EXISTS(SELECT pedido FROM Apoio WHERE Apoio.pedido = PA.id)
GROUP BY pedinte;




