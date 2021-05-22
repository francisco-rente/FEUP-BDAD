-- 3. É importante acolher/auxiliar os necessitados o mais prontamente possível.
--   - Impedir que o mesmo necessitado tenha mais do que 5 pedidos de apoio pendentes (sem um apoio atribuído).


CREATE TRIGGER trg3
    BEFORE
        INSERT
    ON PedidoApoio
    FOR EACH ROW
BEGIN
    SELECT CASE
               WHEN COUNT(*) = 5 THEN
                   RAISE(ABORT,
                         'Esse necessitado já atingiu o limite de pedidos')
               END
    FROM PedidoApoio PA2
    WHERE PA2.pedinte = New.pedinte
      AND PA2.id NOT IN (SELECT pedido FROM Apoio);
END;



-- SELECT
--     *
-- FROM
--     PedidoApoio
-- WHERE
--     PedidoApoio.id NOT IN (
--         SELECT
--             PedidoApoio.id FROM PedidoApoio JOIN Apoio ON Apoio.pedido = PedidoApoio.id
-- );
 



