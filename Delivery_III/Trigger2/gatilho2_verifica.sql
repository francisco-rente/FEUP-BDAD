PRAGMA foreign_keys = ON;

INSERT INTO 'Produto' ('codigo', 'nome')
VALUES (18, 'Prozis Peanut Bar');

INSERT INTO 'ProdutoAlimentar' ('codigo', 'dataValidade', 'tipo')
VALUES (18, '2022-10-20', 4);

INSERT INTO 'DoacaoMaterial' ('id', 'pessoa', 'data')
VALUES (18, 40, '2021-11-29');

INSERT INTO 'DoacaoMaterialContemProduto'('doacao', 'produto')
VALUES (18, 18);

SELECT PA.codigo       AS ProdutoAlimentar,
       PA.dataValidade AS dataValidade,
       PA.tipo         AS tipo,
       P.nome          AS Nome

FROM ProdutoAlimentar PA
         JOIN Produto P ON P.codigo = PA.codigo
--WHERE JULIANDAY(ProdutoAlimentar.dataValidade)  JULIANDAY();
