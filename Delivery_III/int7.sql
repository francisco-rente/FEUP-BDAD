PRAGMA foreign_keys = ON;
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
SELECT *
FROM (
         SELECT PA.*
         FROM PedidoApoio PA
         WHERE tipo LIKE 'Alojamento' -- Apenas pedidos de alojamento
           -- Selecionar pedidos apenas quando houver camas disponíveis.
           AND EXISTS(
             -- Procurar número de camas disponíveis.
                 SELECT (totalCamas - camasOcupadas) AS camasDisponiveis
                 FROM (
                       (
                           -- Camas ocupadas = N. pedidos alojamento ativos
                           SELECT COUNT(*) AS camasOcupadas
                           FROM ApoioAlojamento APA
                                    INNER JOIN Apoio AP ON AP.id = APA.id
                           WHERE AP.dataFim > DATE() -- Apenas apoios ativos.
                       )
                          CROSS JOIN -- permite juntar colunas não relacionadas numa só tabela
                      (
                          -- Total de camas = Soma de todos os abrigos.
                          SELECT SUM(A.numeroCamas) AS totalCamas
                          FROM Abrigo A
                      )
                          )

                 WHERE (camasDisponiveis > 0) -- Apenas com camas disponíveis.
             )

           -- UNION ALL em vez de UNION evita ordenação. Já sabemos que não há duplicados (tipo diferente)
         UNION ALL

-- Selecionar os pedidos de apoio monetário possíveis de satisfazer
         SELECT PA.*
         FROM PedidoApoio PA
                  -- Será necessário consultar a tabela de necessitados para obter o rendimento
                  JOIN Necessitado N ON PA.pedinte = N.id
                  CROSS JOIN 
              (
                  -- Procurar saldo disponível.
                  SELECT *
                  FROM (
                           SELECT (valorRecebido - valorGasto) AS valorDisponivel
                           FROM (
                                 (
                                     -- Total recebido = soma doações.
                                     SELECT SUM(DM.valor) AS valorRecebido
                                     FROM DoacaoMonetaria DM
                                 )
                                    CROSS JOIN
                                (
                                    -- Total gasto = soma apoios atribuídos.
                                    SELECT SUM(AM.valor) AS valorGasto
                                    FROM ApoioMonetario AM
                                )
                                    )
                       )
                       -- Selecionar pedidos apenas quando houver saldo disponível.
                       -- Ao colocar aqui esta condição, evita-se fazer todos os
                       -- produtos cartesianos
                  WHERE (valorDisponivel > 0)
              )
         WHERE (
                       PA.tipo LIKE 'Monetário' -- Apenas pedidos monetários
                   -- Apoio máximo = 800 - rendimento
                       AND (800 - N.rendimento) < valorDisponivel))
ORDER BY prioridade DESC;