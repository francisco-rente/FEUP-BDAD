PRAGMA foreign_keys = ON;

.mode columns
.headers ON
.nullvalue NULL

SELECT PA.codigo       AS ProdutoAlimentar,
       PA.dataValidade AS dataValidade,
       PA.tipo         AS tipo,
       P.nome          AS Nome

FROM ProdutoAlimentar PA
         JOIN Produto P ON P.codigo = PA.codigo;
--WHERE PA.dataValidade < DATE();
--retirar do comentário para aparecerem apenas os que têm validade inferior


INSERT INTO 'Produto' ('codigo', 'nome')
VALUES (18, 'Prozis Peanut Bar');

INSERT INTO 'ProdutoAlimentar' ('codigo', 'dataValidade', 'tipo')
VALUES (18, '2022-10-20', 4);

INSERT INTO 'DoacaoMaterial' ('id', 'pessoa', 'data')
VALUES (22, 40, '2021-11-29');

INSERT INTO 'DoacaoMaterialContemProduto'('doacao', 'produto')
VALUES (22, 18);

SELECT PA.codigo       AS ProdutoAlimentar,
       PA.dataValidade AS dataValidade,
       PA.tipo         AS tipo,
       P.nome          AS Nome

FROM ProdutoAlimentar PA
         JOIN Produto P ON P.codigo = PA.codigo;
--WHERE JULIANDAY(PA.dataValidade) < JULIANDAY();
--retirar do comentário para aparecerem apenas os que têm validade inferior
