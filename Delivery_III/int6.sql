/*
.mode columns
.headers ON
.nullvalue NULL
*/

/*
É relevante estudar a distribuição de doações pelos meses e estações do ano.
Concretamente, é importante saber os meses do ano com maior e menor volume de
doações, a pessoa que doou mais vezes, a pessoa que doou mais dinheiro à
instituição (sem recorrer limit or max) e as pessoa que já tenham doado todos os
tipos de produtos.
*/

SELECT *
FROM (SELECT pessoa FROM DoacaoMonetaria) P1,
     (SELECT pessoa FROM DoacaoMonetaria) P2
WHERE P1.pessoa < p2.pessoa
