---.mode columns
---.headers ON
---.nullvalue NULL

--Tendo em conta a frequência e o valor da doação recorrente mais recente de cada cliente, estimar o fluxo de entrada
--esperado nos próximos X dias.

SELECT SUM(valorEsperado) AS totalEsperado
FROM (
         SELECT DM.frequencia,
                ceil((JULIANDAY(MAX(data)) + frequencia) -
                     JULIANDAY()) AS diasRestantes,
                (1 + floor(MAX(0, (13 -
                                   ((JULIANDAY(MAX(DM.data)) + DM.frequencia) -
                                    JULIANDAY())) /
                                  DM.frequencia))) *
                DM.valor          AS valorEsperado
         FROM DoacaoMonetaria DM
         WHERE pessoa NOT NULL
           AND frequencia > 0
         GROUP BY pessoa
     )
WHERE diasRestantes >= 0
  AND diasRestantes < 13;

SELECT SUM(valorEsperado)
FROM (
         SELECT valor * doacoesEsperadas AS valorEsperado
         FROM (
                  SELECT valor,
                         1 + floor((13 - diasAteSeguinte) / frequencia) AS doacoesEsperadas
                  FROM (
                           SELECT frequencia,
                                  valor,
                                  FLOOR(
                                          JULIANDAY(proximaDoacao) - JULIANDAY()) AS diasAteSeguinte
                           FROM (
                                    SELECT frequencia,
                                           valor,
                                           DATE(JULIANDAY(ultimaDoacao) + frequencia) AS proximaDoacao
                                    FROM (
                                             SELECT frequencia,
                                                    valor,
                                                    MAX(data) AS ultimaDoacao
                                             FROM DoacaoMonetaria DM
                                             WHERE pessoa NOT NULL
                                               AND frequencia > 0
                                             GROUP BY pessoa
                                         )
                                    WHERE proximaDoacao >= DATE()
                                )
                       )
                  WHERE diasAteSeguinte <= 13
              )
     );

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