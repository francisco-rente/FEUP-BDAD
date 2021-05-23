/*
.mode columns
.headers ON
.nullvalue NULL
*/

/*
A a pessoa que doou mais vezes, a pessoa que doou mais dinheiro à
instituição (sem recorrer limit or max) e a pessoa que já tenha doado todos os produtos.
*/


SELECT
    DadorMonetario.nome AS "Dador Monetario",
    MAX(valorDoado) AS "Valor máximo da doação",
    DadorMaterial.nome AS "Dador Material",
    NumeroProdutosDiferentes AS "Número de produtos diferentes doados"
FROM
    (
        (
            SELECT
                PES.primeiroNome || ' ' || PES.ultimoNome AS nome,
                DMON.pessoa,
                SUM(DMON.valor) AS valorDoado
            FROM
                DoacaoMonetaria DMON
                INNER JOIN Pessoa PES ON PES.id = pessoa
            GROUP BY
                pessoa
        ) DadorMonetario
        ,(
            SELECT
                PES.primeiroNome || ' ' || PES.ultimoNome AS nome,
                COUNT(DISTINCT PROD.codigo) AS NumeroProdutosDiferentes
            FROM
                DoacaoMaterial DMON
                INNER JOIN DoacaoMaterialContemProduto DMCPROD ON DMON.id = DMCPROD.doacao
                INNER JOIN Produto PROD ON PROD.codigo = DMCPROD.produto
                INNER JOIN Pessoa PES ON PES.id = DMON.pessoa
            GROUP BY
                DMON.pessoa
            HAVING
                COUNT(DISTINCT PROD.codigo) = (
                    SELECT
                        COUNT(P.codigo)
                    FROM
                        Produto P
                )
        ) DadorMaterial
    )