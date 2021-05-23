PRAGMA foreign_keys = ON;
/*
.mode columns
.headers ON
.nullvalue NULL
*/

/*
É relevante estudar a distribuição de pedidos pelos meses e estações do ano.
Convém saber os meses de maior atividade, bem como o necessitado que inseriu
mais pedidos, qual o tipo mais requisitado, quantos foram atribuídos e uma
contagem relativa à prioridade.
 */

DROP TABLE IF EXISTS Meses;

-- Tabela temporária com todos os meses, necessária por sqlite não suportar FULL OUTER JOIN 
CREATE TEMPORARY TABLE Meses
(
    mes  INTEGER NOT NULL,
    nome TEXT    NOT NULL
);

INSERT INTO Meses
VALUES (1, 'Janeiro'),
       (2, 'Fevereiro'),
       (3, 'Março'),
       (4, 'Abril'),
       (5, 'Maio'),
       (6, 'Junho'),
       (7, 'Julho'),
       (8, 'Agosto'),
       (9, 'Setembro'),
       (10, 'Outubro'),
       (11, 'Novembro'),
       (12, 'Dezembro');

-- Se não existem dados sobre uma dada estatística é apresentado N/A
SELECT Meses.nome                           AS mes,
       IFNULL(apoios, 0)                    AS apoios,
       IFNULL(prioridadeMedia, 'N/A')       AS prioridadeMedia,
       IFNULL(doacoesMonetarias, 0)         AS doacoesMonetarias,
       IFNULL(montanteRecebido, 'N/A')      AS montanteRecebido,
       IFNULL(montanteMedioRecebido, 'N/A') AS montanteMedioRecebido,
       IFNULL(apoiosMonetarios, 0)          AS apoiosMonetarios,
       IFNULL(montanteGasto, 'N/A')         AS montanteGasto,
       IFNULL(montanteMedioGasto, 'N/A')    AS montanteMedioGasto,
       IFNULL(doacoesMateriais, 0)          AS doacoesMateriais,
       IFNULL(apoiosMateriais, 0)           AS apoiosMateriais
FROM (
      Meses
         LEFT JOIN
     (
         SELECT STRFTIME('%m', dataFim) AS mes,
                COUNT(A.id)             AS apoios,
                AVG(PA.prioridade)      AS prioridadeMedia,
                COUNT(AMN.id)           AS apoiosMonetarios,
                SUM(valor)              AS montanteGasto,
                AVG(valor)              AS montanteMedioGasto,
                COUNT(AMT.id)           AS apoiosMateriais,
                COUNT(AAL.id)           AS apoiosAlojamento
         FROM Apoio A 
                  -- LEFT OUTER JOIN garante que nenhum mês é descartado
                  LEFT OUTER JOIN ApoioMonetario AMN ON A.id = AMN.id 
                  LEFT OUTER JOIN ApoioMaterial AMT ON A.id = AMT.id
                  LEFT OUTER JOIN ApoioAlojamento AAL ON A.id = AAL.id
                  INNER JOIN PedidoApoio PA ON A.pedido = PA.id
         GROUP BY mes -- fazer coincidir com a tabela temporária
     ) Apoios
     ON Meses.mes = Apoios.mes
         LEFT OUTER JOIN
     (
         SELECT STRFTIME('%m', data)      AS mes,
                COUNT(DoacaoMonetaria.id) AS doacoesMonetarias,
                SUM(valor)                AS montanteRecebido,
                AVG(valor)                AS montanteMedioRecebido
         FROM DoacaoMonetaria
         GROUP BY mes
     ) DMonetaria
     ON Meses.mes = DMonetaria.mes
         LEFT OUTER JOIN
     (
         SELECT STRFTIME('%m', data)     AS mes,
                COUNT(DoacaoMaterial.id) AS doacoesMateriais
         FROM DoacaoMaterial
         GROUP BY mes
     ) DMateriais
     ON Meses.mes = DMateriais.mes
         );

DROP TABLE Meses;