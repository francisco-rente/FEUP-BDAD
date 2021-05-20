/*
.mode columns
.headers ON
.nullvalue NULL
*/

/*
Em relação aos pedidos de apoio pendentes, é importante saber quais deles
podem ser satisfeitos com os recursos existentes. Assim, as camas restantes
devem ser comparadas com os pedidos de alojamento e o saldo monetário deve ser
comparado com os pedidos de apoio monetários.
 */

-- Selecionar pedidos de alojamento possíveis de satisfazer
SELECT PA.*
FROM PedidoApoio PA
     -- Apenas são relevantes os pedidos de alojamento
WHERE tipo LIKE 'Alojamento'
  -- Selecionar pedidos apenas quando houver camas disponíveis.
  AND EXISTS(
    -- Procurar número de camas disponíveis
        SELECT (totalCamas - camasOcupadas) AS camasDisponiveis
        FROM (
              (
                  -- O total de camas ocupadas é igual ao total de apoios
                  -- atribuídos que ainda não terminaram
                  SELECT COUNT(*) AS camasOcupadas
                  FROM ApoioAlojamento APA
                           JOIN Apoio AP ON AP.id = APA.id
                       -- Considerar apenas os apoios que ainda não terminaram
                  WHERE AP.dataFim > DATE()
              )
                 CROSS JOIN
             (
                 -- O total de camas é a soma das camas de todos os abrigos.
                 SELECT SUM(A.numeroCamas) AS totalCamas
                 FROM Abrigo A
             )
                 )
             -- Devolver apenas quando houver camas disponíveis.
        WHERE (camasDisponiveis > 0)
    )

-- Ao utilizar UNION ALL em vez de UNION, evitamos o processo de ordenação para
-- procurar duplicados que já sabemos não existir.
UNION ALL

-- Selecionar os pedidos de apoio monetário possíveis de satisfazer
SELECT PA.*
FROM PedidoApoio PA
         -- Será necessário consultar a tabela de necessitados para obter o rendimento
         JOIN Necessitado N ON PA.pedinte = N.id
         CROSS JOIN
     (
         -- Procurar saldo disponível para a organização
         SELECT *
         FROM (
                  SELECT (valorRecebido - valorGasto) AS valorDisponivel
                  FROM (
                        (
                            -- O valor total recebido é a soma das doações
                            SELECT SUM(DM.valor) AS valorRecebido
                            FROM DoacaoMonetaria DM
                        )
                           CROSS JOIN
                       (
                           -- O valor total gasto é a soma dos apoios monetários atribuídos
                           SELECT SUM(AM.valor) AS valorGasto
                           FROM ApoioMonetario AM
                       )
                           )
              )
              -- Selecionar pedidos apenas quando houver saldo disponível.
              -- Ao colocar aqui esta condição, evita-se fazer
              -- todos os produtos cartesianos
         WHERE (valorDisponivel > 0)
     )
WHERE (
          -- Apenas são relevantes os pedidos de apoio monetário
              PA.tipo LIKE 'Monetário'
              -- Considera-se que o apoio máximo atribuído é o necessário para
              -- que o rendimento do necessitado perfaça 800€.
              AND (800 - N.rendimento) < valorDisponivel);