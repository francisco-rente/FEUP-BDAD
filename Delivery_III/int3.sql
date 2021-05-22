/*
.mode columns
.headers ON
.nullvalue NULL
*/


--Lista os números de telefone de todos os dadores que tenham "falhado" a sua doação planeada 

SELECT primeiroNome || ' ' || ultimoNome AS Dador,
       numeroTelefone                    AS Contacto,
       morada                            AS Morada
FROM (
         SELECT pessoa, frequencia, MAX(data) AS ultima
         FROM DoacaoMonetaria
         WHERE pessoa NOT NULL
           AND frequencia > 0
         GROUP BY pessoa
     )
         INNER JOIN Pessoa P ON P.id = pessoa
WHERE JULIANDAY(ultima) + frequencia < JULIANDAY()

