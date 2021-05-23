PRAGMA foreign_keys = ON;
.mode columns
.headers ON
.nullvalue NULL
SELECT
    (valorRecebido - valorGasto) AS valorDisponivel
FROM
    (
        (
            SELECT
                SUM(DM.valor) AS valorRecebido
            FROM
                DoacaoMonetaria DM
        )
        CROSS JOIN (
            SELECT
                SUM(AM.valor) AS valorGasto
            FROM
                ApoioMonetario AM
        )
    );


-- Valor máximo disponível pela organização atualmente: 3717
INSERT INTO 'PedidoApoio' ('id', 'justificacao', 'tipo', 'prioridade',
                           'avaliador', 'pedinte')

VALUES (37, 'Doença', 'Monetário', 5, 6, 28);

INSERT INTO 'Apoio' ('id', 'dataInicio', 'dataFim', 'pedido', 'Orientador')
VALUES (20, '2021-6-1', '2023-01-23', 37, 19);

INSERT INTO 'ApoioMonetario' ('id', 'valor')
VALUES (20, 7000);