/*
.mode columns
.headers ON
.nullvalue NULL
*/

/*
A a pessoa que doou mais vezes, a pessoa que doou mais dinheiro à
instituição (sem recorrer limit or max) e as pessoa que já tenham doado todos os
tipos de produtos.
*/

SELECT PES.primeiroNome || ' ' || PES.ultimoNome
FROM (
      (
          SELECT DMON.pessoa, SUM(DMON.valor) AS valorDoado
          FROM DoacaoMonetaria DMON
          GROUP BY pessoa
      )
         INNER JOIN Pessoa PES ON PES.id = pessoa
    );

SELECT PES.primeiroNome || ' ' || PES.ultimoNome
FROM DoacaoMaterial DMON
         INNER JOIN DoacaoMaterialContemProduto DMCPROD
                    ON DMON.id = DMCPROD.doacao
         INNER JOIN Produto PROD ON PROD.codigo = DMCPROD.produto
         INNER JOIN Pessoa PES ON PES.id = DMON.pessoa
GROUP BY DMON.pessoa
HAVING COUNT(DISTINCT PROD.codigo) = (SELECT COUNT(P.codigo) FROM Produto P)