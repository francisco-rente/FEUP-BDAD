PRAGMA foreign_keys = ON;
.mode columns
.headers ON
.nullvalue NULL


SELECT primeiroNome || ' ' || ultimoNome AS Dador, -- Concatenar os dois nomes
       numeroTelefone                    AS Contacto,
       morada                            AS Morada
FROM (
         SELECT DM.pessoa, DM.frequencia, MAX(DM.data) AS ultimaDoacao
         FROM DoacaoMonetaria DM
         WHERE DM.pessoa NOT NULL -- Apenas doações identificadas.
           AND DM.frequencia > 0  -- Apenas doações recorrentes.
         GROUP BY DM.pessoa
     ) DM
         -- JOIN depois de SELECT para evitar fazê-lo em todas as linhas.
         INNER JOIN Pessoa P ON P.id = DM.pessoa
WHERE JULIANDAY(ultimaDoacao) + frequencia < JULIANDAY();

