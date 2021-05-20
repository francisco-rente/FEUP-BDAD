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

SELECT STRFTIME('%m', dataInicio) AS mesInicio, COUNT(*) AS numeroApoios
FROM Apoio
GROUP BY mesInicio;

SELECT mesMaiorAtividade,
       necessitadoComMaisPedidos,
       tipoDeApoioMaisRequisitado,
       numeroDePedidos,
       numeroDeApoiosAtribuidos
FROM (
      (
          SELECT STRFTIME('%m', dataInicio) AS mesMaiorAtividade
          FROM Apoio
          GROUP BY mesMaiorAtividade
          ORDER BY COUNT(*)
          LIMIT 1
      )
         CROSS JOIN
     (
         SELECT primeiroNome AS necessitadoComMaisPedidos
         FROM PedidoApoio PA
                  JOIN Necessitado N ON PA.pedinte = N.id
                  JOIN Pessoa P ON N.id = P.id
         GROUP BY PA.pedinte
         ORDER BY COUNT(*)
         LIMIT 1
     )
         CROSS JOIN
     (
         SELECT tipo AS tipoDeApoioMaisRequisitado
         FROM PedidoApoio
         GROUP BY PedidoApoio.tipo
         ORDER BY COUNT(*)
         LIMIT 1
     )
         CROSS JOIN
     (
         SELECT COUNT(*) AS numeroDePedidos
         FROM PedidoApoio
     )
         CROSS JOIN
     (
         SELECT COUNT(*) AS numeroDeApoiosAtribuidos
         FROM Apoio
     )
         );


SELECT PA.prioridade, COUNT(*) AS numeroApoios
FROM PedidoApoio PA
GROUP BY PA.prioridade;

DROP TABLE IF EXISTS Meses;
CREATE TEMPORARY TABLE Meses
(
    mes INTEGER NOT NULL
);

INSERT INTO Meses
VALUES (1),
       (2),
       (3),
       (4),
       (5),
       (6),
       (7),
       (8),
       (9),
       (10),
       (11),
       (12);

SELECT Meses.mes,
       IFNULL(apoios, 'N/A')                AS apoios,
       IFNULL(prioridadeMedia, 'N/A')       AS prioridadeMedia,
       IFNULL(doacoesMonetarias, 'N/A')     AS doacoesMonetarias,
       IFNULL(montanteRecebido, 'N/A')      AS montanteRecebido,
       IFNULL(montanteMedioRecebido, 'N/A') AS montanteMedioRecebido,
       IFNULL(apoiosMonetarios, 'N/A')      AS apoiosMonetarios,
       IFNULL(montanteGasto, 'N/A')         AS montanteGasto,
       IFNULL(montanteMedioGasto, 'N/A')    AS montanteMedioGasto,
       IFNULL(doacoesMateriais, 'N/A')      AS doacoesMateriais,
       IFNULL(apoiosMateriais, 'N/A')       AS apoiosMateriais
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
                  LEFT JOIN ApoioMonetario AMN ON A.id = AMN.id
                  LEFT JOIN ApoioMaterial AMT ON A.id = AMT.id
                  LEFT JOIN ApoioAlojamento AAL ON A.id = AAL.id
                  JOIN PedidoApoio PA ON A.pedido = PA.id
         GROUP BY mes
     ) Apoios
     ON Meses.mes = Apoios.mes
         LEFT JOIN
     (
         SELECT STRFTIME('%m', data)      AS mes,
                COUNT(DoacaoMonetaria.id) AS doacoesMonetarias,
                SUM(valor)                AS montanteRecebido,
                AVG(valor)                AS montanteMedioRecebido
         FROM DoacaoMonetaria
         GROUP BY mes
     ) DMonetaria
     ON Meses.mes = DMonetaria.mes
         LEFT JOIN
     (
         SELECT STRFTIME('%m', data)     AS mes,
                COUNT(DoacaoMaterial.id) AS doacoesMateriais
         FROM DoacaoMaterial
         GROUP BY mes
     ) DMateriais
     ON Meses.mes = DMateriais.mes
         );

DROP TABLE Meses;