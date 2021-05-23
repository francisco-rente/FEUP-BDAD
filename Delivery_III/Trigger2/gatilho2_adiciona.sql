PRAGMA foreign_keys = ON;

CREATE TRIGGER trg2
    AFTER INSERT
    ON Produto
    FOR EACH ROW
BEGIN
    DELETE
        -- Nota: Devido às regras ON DELETE, esta entrada será também removida da
        -- tabela produto, pelo que não é necessário fazê-lo manualmente.
    FROM ProdutoAlimentar
    WHERE ProdutoAlimentar.dataValidade < DATE();
END;

