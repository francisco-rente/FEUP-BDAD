PRAGMA foreign_keys = ON;
/*
.mode columns
.headers ON
.nullvalue NULL
*/

--Tendo em conta a frequência e o valor da doação recorrente mais recente de cada cliente, estimar o fluxo de entrada
--esperado nos próximos X dias.

SELECT SUM(valor * (1 + floor((13 - diasAteSeguinte) / frequencia)))
           AS totalEsperado
FROM (
         SELECT valor,
                frequencia,
                FLOOR(
                            JULIANDAY(DATE(JULIANDAY(MAX(data)) + frequencia)) -
                            JULIANDAY()
                    )
                    AS diasAteSeguinte
         FROM DoacaoMonetaria DM
         WHERE pessoa NOT NULL
           AND frequencia > 0
         GROUP BY pessoa)
WHERE diasAteSeguinte >= 0
  AND diasAteSeguinte <= 13;