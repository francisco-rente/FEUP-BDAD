---.mode columns
---.headers ON
---.nullvalue NULL

---Para cada abrigo, calcular um conjunto de estatísticas relevantes sobre os seus habitantes: média de idades, média de
---rendimentos, nacionalidade mais comum e justificação mais comum para requerer asilo. 
SELECT id,
       justificacaoMaisComum,
       paisMaisComum,
       idadeMedia,
       rendimentoMedio
FROM (
         WITH infoNecessitados AS (
             SELECT AB.id,
                    AVG(NES.rendimento) AS rendimentoMedio,
                    floor(AVG(
                            JULIANDAY() - JULIANDAY(PES.dataNascimento))) /
                    365                 AS idadeMedia
             FROM Abrigo AB
                      JOIN ApoioAlojamento APA ON AB.id = APA.abrigo
                      JOIN Apoio AP ON APA.id = AP.id
                      JOIN PedidoApoio PAP ON AP.pedido = PAP.id
                      JOIN Necessitado NES ON PAP.pedinte = NES.id
                      JOIN Pessoa PES ON NES.id = PES.id
             WHERE AP.dataFim >= DATE()
             GROUP BY AB.id
         ),
              infoNacionalidades AS (
                  SELECT AB.id, Pais.nome, COUNT(*) AS pCount
                  FROM Abrigo AB
                           JOIN ApoioAlojamento APA ON AB.id = APA.abrigo
                           JOIN Apoio AP ON APA.id = AP.id
                           JOIN PedidoApoio PAP ON AP.pedido = PAP.id
                           JOIN Necessitado NES ON PAP.pedinte = NES.id
                           JOIN Pessoa PES ON NES.id = PES.id
                      -- JOIN Pessoa PES ON PAP.pedinte = PES.id
                           JOIN Localidade LOC ON PES.codigoZona = LOC.codigo
                           JOIN Pais ON LOC.codigoPais = Pais.codigo
                  WHERE AP.dataFim >= DATE('now')
                  GROUP BY AB.id, Pais.codigo
              ),
              infoJustificacoes AS (
                  SELECT AB.id, PAP.justificacao, COUNT(*) AS jCount
                  FROM Abrigo AB
                           JOIN ApoioAlojamento APA ON AB.id = APA.abrigo
                           JOIN Apoio AP ON APA.id = AP.id
                           JOIN PedidoApoio PAP ON AP.pedido = PAP.id
                  WHERE AP.dataFim >= DATE('now')
                  GROUP BY AB.id, PAP.justificacao)
         SELECT AB.id,
                MAX(infoJustificacoes.jCount)    AS numeroJustificacoes,
                infoJustificacoes.justificacao   AS justificacaoMaisComum,
                MAX(infoNacionalidades.pCount)   AS numeroPessoasDoPais,
                infoNacionalidades.nome          AS paisMaisComum,
                infoNecessitados.idadeMedia      AS idadeMedia,
                infoNecessitados.rendimentoMedio AS rendimentoMedio
         FROM Abrigo AB
                  JOIN
              infoJustificacoes ON AB.id = infoJustificacoes.id
                  JOIN
              infoNacionalidades ON AB.id = infoNacionalidades.id
                  JOIN
              infoNecessitados ON AB.id = infoNecessitados.id
         GROUP BY AB.id
     );