/*
FIXME: Important note: Two proposed solutions. Further comparison is required.

When this query was designed, the idea was to consider which (if any) support
requests could be given with the available resources (money and beds). However,
a few aspects must be taken into account:
- There is a giant disparity between the received and spent funds, to the point
where any support request is automatically possible and testing is hard.
- An assumption was made regarding the value of the monetary support (800 -
salary), which may not make sense. It may be wiser to adapt the string to also
include an amount.
- Listing the support requests may not be that useful. After all, the table may
become empty right after the first one is assigned. A better way could be all
of the groups of support requests that may be given, but that would possibly be
hard to implement and read.
- Regardless, it is important to adapt the dataset in order to allow for more
realistic scenarios.
- This query could become just a statistic of the available resources, but that
could make it too similar to existing ones.
- This query could be extended to also include material support requests, which
would make it necessary to know which product is being requested.
*/

/*
Em relação aos pedidos de apoio pendentes, é importante saber quais deles
podem ser satisfeitos com os recursos existentes. Assim, as camas restantes
devem ser comparadas com os pedidos de alojamento e o saldo monetário deve ser
comparado com os pedidos de apoio monetários.
 */

SELECT PA.*
FROM PedidoApoio PA
         JOIN Necessitado N ON PA.pedinte = N.id
         CROSS JOIN
     (
         SELECT *
         FROM (
                  SELECT (valorTotalRecebido - valorTotalGasto) AS saldoDisponivel
                  FROM (
                        (
                            SELECT SUM(DM.valor) AS valorTotalRecebido
                            FROM DoacaoMonetaria DM
                        )
                           CROSS JOIN
                       (
                           SELECT SUM(AM.valor) AS valorTotalGasto
                           FROM ApoioMonetario AM
                       )
                           )
              )
                  CROSS JOIN
              (
                  SELECT (totalCamas - totalCamasOcupadas) AS totalCamasDisponiveis
                  FROM (
                        (
                            SELECT COUNT(*) AS totalCamasOcupadas
                            FROM ApoioAlojamento APA
                                     JOIN Apoio AP ON AP.id = APA.id
                            WHERE dataFim > DATE())
                           CROSS JOIN
                       (
                           SELECT SUM(numeroCamas) AS totalCamas
                           FROM Abrigo A
                       )
                           )
              )
     )
WHERE (
              (
                      PA.tipo LIKE 'Alojamento'
                      AND totalCamasDisponiveis > 0
                  )
              OR
              (
                      PA.tipo LIKE 'Monetário'
                      AND (800 - N.rendimento) < saldoDisponivel
                  )
          );

-- Selecionar pedidos de alojamento possíveis de satisfazer
SELECT PA.*
FROM PedidoApoio PA
         CROSS JOIN
     (
         -- Procurar número de camas disponíveis
         SELECT (totalCamas - totalCamasOcupadas) AS totalCamasDisponiveis
         FROM (
               (
                   -- O total de camas ocupadas é igual ao total de apoios
                   -- atribuídos que ainda não terminaram
                   SELECT COUNT(*) AS totalCamasOcupadas
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
              -- Selecionar pedidos apenas quando houver camas disponíveis.
              -- Ao colocar aqui esta condição, evita-se fazer
              -- todos os produtos cartesianos
         WHERE (totalCamasDisponiveis > 0)
     )
-- Apenas são relevantes os pedidos de alojamento
WHERE tipo LIKE 'Alojamento'

UNION

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
                  SELECT (valorTotalRecebido - valorTotalGasto) AS saldoDisponivel
                  FROM (
                        (
                            -- O valor total recebido é a soma das doações
                            SELECT SUM(DM.valor) AS valorTotalRecebido
                            FROM DoacaoMonetaria DM
                        )
                           CROSS JOIN
                       (
                           -- O valor total gasto é a soma dos apoios monetários atribuídos
                           SELECT SUM(AM.valor) AS valorTotalGasto
                           FROM ApoioMonetario AM
                       )
                           )
              )
              -- Selecionar pedidos apenas quando houver saldo disponível.
              -- Ao colocar aqui esta condição, evita-se fazer
              -- todos os produtos cartesianos
         WHERE (saldoDisponivel > 0)
     )
WHERE (PA.tipo LIKE 'Monetário' AND (800 - N.rendimento) < saldoDisponivel);