---.mode columns
---.headers ON
---.nullvalue NULL

-- Para cada abrigo, calcular um conjunto de estatísticas relevantes sobre os
-- seus habitantes: média de idades, média de rendimentos, nacionalidade mais
-- comum e justificação mais comum para requerer asilo.

SELECT id,
       justificacaoMaisComum,
       percentagemJustificacoes,
       paisMaisComum,
       percentagemPais,
       idadeMedia,
       rendimentoMedio
FROM (
         SELECT AB.id,
                100 * MAX(infoJustificacoes.jCount) /
                SUM(infoJustificacoes.jCount)    AS percentagemJustificacoes,
                infoJustificacoes.justificacao   AS justificacaoMaisComum,
                100 * MAX(infoNacionalidades.pCount) /
                SUM(infoNacionalidades.pCount)   AS percentagemPais,
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
                  WHERE AP.dataFim >= DATE('now')
                  GROUP BY AB.id, PAP.justificacao) infoJustificacoes
              ON AB.id = infoJustificacoes.id
                  INNER JOIN
              (
                  SELECT AB.id, Pais.nome, COUNT(*) AS pCount
                  FROM Abrigo AB
                           INNER JOIN ApoioAlojamento APA ON AB.id = APA.abrigo
                           INNER JOIN Apoio AP ON APA.id = AP.id
                           INNER JOIN PedidoApoio PAP ON AP.pedido = PAP.id
                           INNER JOIN Necessitado NES ON PAP.pedinte = NES.id
                           INNER JOIN Pessoa PES ON NES.id = PES.id
                      -- JOIN Pessoa PES ON PAP.pedinte = PES.id
                           INNER JOIN Localidade LOC ON PES.codigoZona = LOC.codigo
                           INNER JOIN Pais ON LOC.codigoPais = Pais.codigo
                  WHERE AP.dataFim >= DATE('now')
                  GROUP BY AB.id, Pais.codigo
              ) infoNacionalidades
              ON AB.id = infoNacionalidades.id
                  INNER JOIN
              (
                  SELECT AB.id,
                         AVG(NES.rendimento) AS rendimentoMedio,
                         floor(AVG(
                                       JULIANDAY() - JULIANDAY(PES.dataNascimento)) /
                               365)          AS idadeMedia
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