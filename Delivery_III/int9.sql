/*
.mode columns
.headers ON
.nullvalue NULL
*/

SELECT PNov.pedido,
       PNov.necessitado,
       PAnt.trabalhador,
       PNov.cZonaNecessitado,
       PAnt.cZonaTrabalhador,
       MIN(ABS(PAnt.cZonaTrabalhador - PNov.cZonaNecessitado)) AS distancia
FROM (
      (
          SELECT PA.id        AS pedido,
                 N.id         AS necessitado,
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
GROUP BY pedido
