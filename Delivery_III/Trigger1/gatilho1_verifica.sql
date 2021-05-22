PRAGMA foreign_keys = ON;

-- Valor máximo disponível pela organização atualmente: 3717
INSERT INTO 'PedidoApoio' ('id', 'justificacao', 'tipo', 'prioridade',
                           'avaliador', 'pedinte')


VALUES (32, 'Doença', 'Monetário', 5, 6, 28);


INSERT INTO 'Apoio' ('id', 'dataInicio', 'dataFim', 'pedido', 'Orientador')
VALUES (15, '2021-6-1', '2023-01-23', 1, 19);

INSERT INTO 'ApoioMonetario' ('id', 'valor')
VALUES (15, 4000);