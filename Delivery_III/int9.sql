/*
.mode columns
.headers ON
.nullvalue NULL
*/

SELECT PNov.necessitado,
       PNov.cZonaNecessitado,
       PAnt.trabalhador,
       PAnt.cZonaTrabalhador,
       MIN(ABS(PAnt.cZonaTrabalhador - PNov.cZonaNecessitado)) AS distancia
FROM (
      (
          SELECT N.id         AS necessitado,
                 P.codigoZona AS cZonaNecessitado
          FROM PedidoApoio PA
                   JOIN Necessitado N ON N.id = PA.pedinte
                   JOIN Pessoa P ON P.id = N.id
          WHERE NOT EXISTS(SELECT * FROM Apoio A WHERE A.pedido = PA.id)
      ) PNov
         CROSS JOIN
     (
         SELECT DISTINCT PA.pedinte,
                         AP.orientador AS trabalhador,
                         PE.codigoZona AS cZonaTrabalhador
         FROM Apoio AP
                  JOIN PedidoApoio PA ON AP.pedido = PA.id
                  JOIN Orientador O ON AP.orientador = O.id
                  JOIN Pessoa PE ON AP.orientador = PE.id
         WHERE STRFTIME('%H', 'now') BETWEEN O.horaInicio AND O.horaFim
     ) PAnt
         )
WHERE PAnt.pedinte = PNov.necessitado
GROUP BY PNov.necessitado
ORDER BY distancia
LIMIT 1;

