/*
.mode columns
.headers ON
.nullvalue NULL
*/

-- Para cada pedido de apoio de alojamento, identificar o abrigo mais apropriado, considerando um abrigo apropriado
-- sempre que não esteja demasiado longe da área de residência do necessitado.

SELECT pedinte                                AS necessitado,
       P.codigoZona                           AS codigoZonaNecessitado,
       A2.codigoZona                          AS codigoZonaAbrigo,
       MIN(ABS(P.codigoZona - A2.codigoZona)) AS distancia

FROM PedidoApoio
         INNER JOIN Pessoa P ON P.id = pedinte
         CROSS JOIN Abrigo A2

WHERE tipo LIKE 'Alojamento'
  AND PedidoApoio.id NOT IN (
    SELECT pedido
    FROM ApoioAlojamento
             INNER JOIN Apoio A ON A.id = ApoioAlojamento.id
)
GROUP BY pedinte;




