/*
.MODE columns
.HEADERS ON
.NULLVALUE NULL
  */

--Escolher pedidos de apoio ainda por atribuir agrupados por tipo e ordenados por prioridade.

SELECT *
FROM PedidoApoio
WHERE PedidoApoio.id NOT IN (SELECT pedido FROM Apoio)
ORDER BY tipo, prioridade DESC;

