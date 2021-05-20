---.mode columns
---.headers ON
---.nullvalue NULL

-- Listar pedidos de alojamento, sendo estes agrupados por morada + localidade

SELECT P.primeiroNome,
       P.ultimoNome,
       P.morada,
       P.codigoZona,
       L.nome AS localidade
FROM Pessoa P
         JOIN Localidade L ON P.codigoZona == L.codigo
WHERE P.id IN
      (SELECT pedinte FROM PedidoApoio WHERE tipo LIKE 'Alojamento')
ORDER BY P.codigoZona, P.morada;
