---adicionar gatilho
PRAGMA foreign_keys = ON;

---ver se é preciso incluir a eliminação da Doação? Por não fazer parte???? Ou então vai com o CASCADE

SELECT ProdutoAlimentar.codigo       AS ProdutoAlimentar,
       ProdutoAlimentar.dataValidade AS dataValidade,
       ProdutoAlimentar.tipo         AS tipo,
       Produto.nome                  AS Nome

FROM ProdutoAlimentar
         JOIN Produto ON Produto.codigo = ProdutoAlimentar.codigo
WHERE ProdutoAlimentar.dataValidade < DATE();



CREATE TRIGGER trg2
    AFTER INSERT
    ON Produto
    FOR EACH ROW
BEGIN
    DELETE
    FROM ProdutoAlimentar
    WHERE ProdutoAlimentar.dataValidade < DATE();
END;

