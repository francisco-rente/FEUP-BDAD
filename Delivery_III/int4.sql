/*
.mode columns
.headers ON
.nullvalue NULL
*/

-- Para cada pedido de apoio de alojamento, identificar o abrigo mais apropriado,
-- considerando um abrigo apropriado sempre que não esteja demasiado longe da
-- área de residência do necessitado.

SELECT PE.primeiroNome || ' ' || PE.ultimoNome AS Necessitado,
       PE.codigoZona                           AS 'Zona Necessitado',
       AB.codigoZona                           AS 'Zona Abrigo',
       MIN(ABS(PE.codigoZona - AB.codigoZona)) AS Distancia
FROM PedidoApoio PA
         INNER JOIN Pessoa PE ON PE.id = PA.pedinte
         CROSS JOIN Abrigo AB
WHERE PA.tipo LIKE 'Alojamento'
  AND PA.id NOT IN
      (
          SELECT A.pedido
          FROM ApoioAlojamento AA
                   INNER JOIN Apoio A ON A.id = AA.id
      )
GROUP BY pedinte;




