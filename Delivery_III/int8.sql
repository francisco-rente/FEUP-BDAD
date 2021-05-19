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
WHERE diasRestantes >= 0