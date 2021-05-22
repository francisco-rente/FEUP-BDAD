---.mode columns
---.headers ON
---.nullvalue NULL

---Para cada abrigo, calcular um conjunto de estatísticas relevantes sobre os seus habitantes: média de idades, média de
---rendimentos, nacionalidade mais comum e justificação mais comum para requerer asilo. 
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
              (SELECT AB.id, PAP.justificacao, COUNT(*) AS jCount
               FROM Abrigo AB
                        INNER JOIN ApoioAlojamento APA ON AB.id = APA.abrigo
                        INNER JOIN Apoio AP ON APA.id = AP.id
                        INNER JOIN PedidoApoio PAP ON AP.pedido = PAP.id
               WHERE AP.dataFim >= DATE('now')
               GROUP BY AB.id, PAP.justificacao) infoJustificacoes
              ON AB.id = infoJustificacoes.id
                  INNER JOIN
              (SELECT AB.id, Pais.nome, COUNT(*) AS pCount
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
               GROUP BY AB.id, Pais.codigo) infoNacionalidades
              ON AB.id = infoNacionalidades.id
                  INNER JOIN
              (SELECT AB.id,
                      AVG(NES.rendimento) AS rendimentoMedio,
                      floor(AVG(JULIANDAY() - JULIANDAY(PES.dataNascimento)) /
                            365)          AS idadeMedia
               FROM Abrigo AB
                        INNER JOIN ApoioAlojamento APA ON AB.id = APA.abrigo
                        INNER JOIN Apoio AP ON APA.id = AP.id
                        INNER JOIN PedidoApoio PAP ON AP.pedido = PAP.id
                        INNER JOIN Necessitado NES ON PAP.pedinte = NES.id
                        INNER JOIN Pessoa PES ON NES.id = PES.id
               WHERE AP.dataFim >= DATE()
               GROUP BY AB.id) infoNecessitados ON AB.id = infoNecessitados.id
         GROUP BY AB.id
     );

SELECT infoMedias.id,
       infoJustificacoes.justificacao   AS justificacaoMaisComum,
       infoNacionalidades.nacionalidade AS paisMaisComum,
       infoMedias.idadeMedia,
       infoMedias.rendimentoMedio
FROM (
      (
          SELECT AB.id,
                 AVG(rendimento) AS rendimentoMedio,
                 floor(AVG(JULIANDAY() - JULIANDAY(dataNascimento)) /
                       365)      AS idadeMedia
          FROM Abrigo AB
                   INNER JOIN ApoioAlojamento AA2 ON AB.id = AA2.abrigo
                   INNER JOIN Apoio A2 ON AA2.id = A2.id
                   INNER JOIN PedidoApoio PA2 ON A2.pedido = PA2.id
                   INNER JOIN Necessitado N2 ON PA2.pedinte = N2.id
                   INNER JOIN Pessoa P3 ON N2.id = P3.id
          WHERE A2.dataFim >= DATE()
          GROUP BY AB.id
      ) infoMedias
         INNER JOIN
     (
         SELECT id,
                justificacao
         FROM (
                  SELECT AB.id
                       , PA.justificacao
                       , ROW_NUMBER()
                          OVER (PARTITION BY AB.id ORDER BY COUNT(PA.justificacao) DESC) rn
                  FROM Abrigo AB
                           INNER JOIN ApoioAlojamento AA ON AB.id = AA.abrigo
                           INNER JOIN Apoio A ON A.id = AA.id
                           INNER JOIN PedidoApoio PA ON PA.id = A.pedido
                  WHERE A.dataFim >= DATE()
                  GROUP BY AB.id, PA.justificacao
              )
         WHERE rn = 1
     ) infoJustificacoes ON infoMedias.id = infoJustificacoes.id
         JOIN
     (
         SELECT id,
                nacionalidade
         FROM (
                  SELECT AB.id
                       , P2.nome                                                 AS nacionalidade
                       , ROW_NUMBER()
                          OVER (PARTITION BY AB.id ORDER BY COUNT(P2.nome) DESC) AS rn
                  FROM Abrigo AB
                           INNER JOIN ApoioAlojamento AA ON AB.id = AA.abrigo
                           INNER JOIN Apoio A ON A.id = AA.id
                           INNER JOIN PedidoApoio PA ON PA.id = A.pedido
                           INNER JOIN Necessitado N ON PA.pedinte = N.id
                           INNER JOIN Pessoa P ON N.id = P.id
                           INNER JOIN Localidade L ON P.codigoZona = L.codigo
                           INNER JOIN Pais P2 ON L.codigoPais = P2.codigo
                  WHERE A.dataFim >= DATE()
                  GROUP BY AB.id, PA.justificacao
              )
         WHERE rn = 1
     ) infoNacionalidades
     ON infoMedias.id = infoNacionalidades.id
         );