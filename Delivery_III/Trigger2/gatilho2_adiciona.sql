---adicionar gatilho
PRAGMA foreign_keys = ON;

---ver se é preciso incluir a eliminação da Doação? Por não fazer parte???? Ou então vai com o CASCADE

SELECT PA.codigo       AS ProdutoAlimentar,
       PA.dataValidade AS dataValidade,
       PA.tipo         AS tipo,
       P.nome          AS Nome

FROM ProdutoAlimentar PA
         JOIN Produto P ON P.codigo = PA.codigo
WHERE PA.dataValidade < DATE();



CREATE TRIGGER trg2
    AFTER INSERT
    ON Produto
    -- COMBACK: Insert on produto VS produto alimentar
    FOR EACH ROW
BEGIN
    DELETE
        -- Nota: Devido às regras ON DELETE, esta entrada será também removida da
        -- tabela produto, pelo que não é necessário fazê-lo manualmente.
    FROM ProdutoAlimentar
    WHERE ProdutoAlimentar.dataValidade < DATE();
END;

