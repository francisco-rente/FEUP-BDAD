PRAGMA foreign_keys = ON;
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
                   RAISE(ABORT, 'O necessitado já atingiu o limite de pedidos.')
               END
    FROM PedidoApoio PA
    WHERE PA.pedinte = NEW.pedinte
      AND PA.id NOT IN (SELECT pedido FROM Apoio);
END;







