PRAGMA foreign_keys = ON;

SELECT PA.pedinte AS Necessitado, COUNT(*) AS "Número de pedidos de apoio por atribuir"
    
FROM
    PedidoApoio PA
WHERE
    (
        PA.id NOT IN (
            SELECT
                PedidoApoio.id
            FROM
                PedidoApoio
                JOIN Apoio ON Apoio.pedido = PedidoApoio.id
        )
    )
GROUP BY PA.pedinte;


INSERT INTO 'PedidoApoio' ('id', 'justificacao', 'tipo', 'prioridade',
                           'avaliador', 'pedinte')
VALUES (32, 'Desemprego', 'Monetário', 9, 6, 7);