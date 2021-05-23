PRAGMA foreign_keys = ON;
.mode columns
.headers ON
.nullvalue NULL

-- Listar pedidos de alojamento, sendo estes agrupados por morada + localidade

SELECT P.primeiroNome || ' ' || P.ultimoNome AS Nome,
       P.morada,
       P.codigoZona,
       L.nome AS localidade
FROM Pessoa P
         INNER JOIN Localidade L ON P.codigoZona == L.codigo
WHERE P.id IN (SELECT pedinte FROM PedidoApoio WHERE tipo LIKE 'Alojamento') AND P.morada NOT NULL
ORDER BY P.codigoZona, P.morada;

-- Esta interrogação também poderia ser feita da seguinte forma.
/*
SELECT P.primeiroNome,
       P.ultimoNome,
       P.morada,
       P.codigoZona,
       L.nome AS localidade
FROM PedidoApoio PA
         JOIN Necessitado N ON N.id = PA.pedinte
         JOIN Pessoa P ON P.id = N.id
         JOIN Localidade L ON L.codigo = P.codigoZona
WHERE PA.tipo LIKE 'Alojamento';
ORDER BY P.codigoZona, P.morada;
*/
