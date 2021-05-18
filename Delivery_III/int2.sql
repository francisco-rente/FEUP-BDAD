---.mode columns
---.headers ON
---.nullvalue NULL

-- Listar pedidos de alojamento, sendo estes agrupados por morada + localidade

SELECT primeiroNome, ultimoNome, morada, codigoZona, nome
FROM Pessoa JOIN Localidade ON Pessoa.codigoZona == Localidade.codigo
WHERE Pessoa.id IN (SELECT pedinte FROM PedidoApoio WHERE tipo LIKE 'Alojamento')
ORDER BY codigoZona, morada;
