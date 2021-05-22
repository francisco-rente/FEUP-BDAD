---.mode columns
---.headers ON
---.nullvalue NULL

-- Para cada abrigo, calcular um conjunto de estatísticas relevantes sobre os
-- seus habitantes: média de idades, média de rendimentos, nacionalidade mais
-- comum e justificação mais comum para requerer asilo.

SELECT id                    AS Abrigo,
       justificacaoMaisComum AS 'Justificacao mais comum',
       nJustificacoes        AS 'N Justificacoes',
       paisMaisComum         AS 'Nacionalidade Mais Comum',
       nPais                 AS 'N. Nacionais',
       idadeMedia            AS 'Idade media',
       rendimentoMedio       AS 'Rendimento medio'
FROM (
         SELECT AB.id,
                MAX(infoJustificacoes.jCount)    AS nJustificacoes,
                infoJustificacoes.justificacao   AS justificacaoMaisComum,
                MAX(infoNacionalidades.pCount)   AS nPais,
                infoNacionalidades.nome          AS paisMaisComum,
                infoNecessitados.idadeMedia      AS idadeMedia,
                infoNecessitados.rendimentoMedio AS rendimentoMedio
         FROM Abrigo AB
                  INNER JOIN
              (
                  SELECT AB.id, PAP.justificacao, COUNT(*) AS jCount
                  FROM Abrigo AB
                           INNER JOIN ApoioAlojamento APA ON AB.id = APA.abrigo
                           INNER JOIN Apoio AP ON APA.id = AP.id
                           INNER JOIN PedidoApoio PAP ON AP.pedido = PAP.id
                  WHERE AP.dataFim >= DATE() -- Apenas apoios ativos
                  GROUP BY AB.id, PAP.justificacao
              ) infoJustificacoes
              ON AB.id = infoJustificacoes.id
                  INNER JOIN
              (
                  SELECT AB.id, Pais.nome, COUNT(*) AS pCount
                  FROM Abrigo AB
                           INNER JOIN ApoioAlojamento APA ON AB.id = APA.abrigo
                           INNER JOIN Apoio AP ON APA.id = AP.id
                           INNER JOIN PedidoApoio PAP ON AP.pedido = PAP.id
                      -- Generalização: Necessitado.id/PAP.pedinte = Pessoa.id
                           INNER JOIN Pessoa PES ON PAP.pedinte = PES.id
                           INNER JOIN Localidade LOC ON PES.codigoZona = LOC.codigo
                           INNER JOIN Pais ON LOC.codigoPais = Pais.codigo
                  WHERE AP.dataFim >= DATE() -- Apenas apoios ativos
                  GROUP BY AB.id, Pais.codigo
              ) infoNacionalidades
              ON AB.id = infoNacionalidades.id
                  INNER JOIN
              (
                  SELECT AB.id,
                         AVG(NES.rendimento) AS rendimentoMedio,
                         floor(
                                     AVG(
                                             JULIANDAY() - JULIANDAY(PES.dataNascimento)) -- Dias desde o nascimento
                                     / 365 -- Anos desde o nascimento
                             )               AS idadeMedia
                  FROM Abrigo AB
                           INNER JOIN ApoioAlojamento APA ON AB.id = APA.abrigo
                           INNER JOIN Apoio AP ON APA.id = AP.id
                           INNER JOIN PedidoApoio PAP ON AP.pedido = PAP.id
                           INNER JOIN Necessitado NES ON PAP.pedinte = NES.id
                           INNER JOIN Pessoa PES ON NES.id = PES.id
                  WHERE AP.dataFim >= DATE()
                  GROUP BY AB.id
              ) infoNecessitados
              ON AB.id = infoNecessitados.id
         GROUP BY AB.id
     );