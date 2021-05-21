/*
.mode columns
.headers ON
.nullvalue NULL
*/
-- COMBACK: Include all or just closest?


SELECT PNov.pedido,
       PNov.nomeNecessitado                                   AS Necessitado,
       PAnt.orientador                                        AS Orientador,
       PNov.cZonaNecessitado                                  AS 'Zona Necessitado',
       PAnt.cZonaOrientador                                   AS 'Zona Orientador',
       MIN(ABS(PAnt.cZonaOrientador - PNov.cZonaNecessitado)) AS Distancia
FROM (
      (
          SELECT PA.id                                 AS pedido,
                 N.id                                  AS necessitado,
                 P.primeiroNome || ' ' || P.ultimoNome AS nomeNecessitado,
                 P.codigoZona                          AS cZonaNecessitado
          FROM PedidoApoio PA
                   JOIN Necessitado N ON N.id = PA.pedinte
                   JOIN Pessoa P ON P.id = N.id
          WHERE NOT EXISTS(SELECT * FROM Apoio A WHERE A.pedido = PA.id)
      ) PNov
         JOIN
     (
         SELECT DISTINCT PA.pedinte,
                         PE.primeiroNome || ' ' || PE.ultimoNome AS orientador,
                         PE.codigoZona                           AS cZonaOrientador
         FROM Apoio AP
                  JOIN PedidoApoio PA ON AP.pedido = PA.id
                  JOIN Orientador O ON AP.orientador = O.id
                  JOIN Pessoa PE ON AP.orientador = PE.id
         WHERE STRFTIME('%H', 'now') BETWEEN O.horaInicio AND O.horaFim
     ) PAnt
     ON PAnt.pedinte = PNov.necessitado
         )
GROUP BY pedido
ORDER BY pedido
