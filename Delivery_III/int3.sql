/*
.MODE columns
.HEADERS ON
.NULLVALUE NULL
 */


--Lista os números de telefone de todos os dadores que tenham "falhado" a sua doação planeada 

SELECT primeiroNome, ultimoNome, numeroTelefone, morada
FROM (
         SELECT pessoa, frequencia, MAX(data) AS ultima
         FROM DoacaoMonetaria
         WHERE pessoa NOT NULL
           AND frequencia NOT NULL
         GROUP BY pessoa
     )
         INNER JOIN Pessoa P ON P.id = pessoa
WHERE JULIANDAY(ultima) + frequencia < JULIANDAY('now')

