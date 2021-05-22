
--Verifica se uma nova doação é realizável tendo em conta o saldo da organização, se não for aborta a oparação.

CREATE TRIGGER trg1
    BEFORE INSERT
    ON ApoioMonetario
    FOR EACH ROW
BEGIN
    SELECT CASE
               WHEN New.valor > valorDisponivel
                   THEN RAISE(ABORT, 'valor máximo ultrapassado')
               END
    FROM (
             SELECT (valorRecebido - valorGasto) AS valorDisponivel
             FROM (
                   (
                       SELECT SUM(DM.valor) AS valorRecebido
                       FROM DoacaoMonetaria DM
                   )
                      CROSS JOIN (
                 SELECT SUM(AM.valor) AS valorGasto
                 FROM ApoioMonetario AM
             )
                 )
         );
END;

