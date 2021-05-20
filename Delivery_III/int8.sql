---.mode columns
---.headers ON
---.nullvalue NULL

--Tendo em conta a frequência e o valor da doação recorrente mais recente de cada cliente, estimar o fluxo de entrada
--esperado nos próximos X dias.

SELECT SUM(valorEsperado) AS totalEsperado
FROM (
         SELECT frequencia,
                ceil((JULIANDAY(MAX(data)) + frequencia) - JULIANDAY()) AS diasRestantes,
                (1 + floor(MAX(0, (500 - ((JULIANDAY(MAX(data)) + frequencia) - JULIANDAY())) /
                                  DoacaoMonetaria.frequencia))) * valor AS valorEsperado
         FROM DoacaoMonetaria
         WHERE pessoa NOT NULL
           AND frequencia NOT NULL
         GROUP BY pessoa
     )
WHERE diasRestantes >= 0;

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
