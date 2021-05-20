PRAGMA foreign_keys = ON;

INSERT INTO 'Pais' ('codigo', 'nome')
VALUES (12, 'Portugal'),
       (14, 'Espanha');

INSERT INTO 'Localidade' ('codigo', 'codigoPais', 'nome')
VALUES (80712126, 12, 'Porto'),
       (98803632, 12, 'Braga'),
       (18009249, 12, 'Viseu'),
       (59450903, 14, 'Madrid'),
       (84405270, 14, 'Valencia');

INSERT INTO 'Pessoa' ('id', 'primeiroNome', 'ultimoNome', 'NIF',
                      'dataNascimento', 'numeroTelefone', 'morada',
                      'codigoZona')
VALUES (1, 'Lucy', 'Powers', '561897593', '1957-03-09', '962698077',
        '2039028 Non, Street', 80712126),
       (2, 'Gary', 'Mccray', '554484337', '1994-07-24', '964472809',
        '5451 Id St.', 98803632),
       (3, 'Zeus', 'Carey', '503356430', '2004-12-20', '926444783',
        'Ap #2372644 Lorem. St.', 18009249),
       (4, 'Hakeem', 'Lambert', '057347794', '1972-07-19', '931047619', NULL,
        84405270),
       (5, 'Nolan', 'Mccall', '216393783', '1956-02-09', '913512298', NULL,
        59450903),
       (6, 'Amanda', 'Shaw', '090330256', '1981-06-24', '911513512',
        'P.O. Box 749, 9030 Mattis Rd.', 80712126),
       (7, 'Ima', 'Dejesus', '741848946', '2017-01-29', '927553624', NULL,
        98803632),
       (8, 'Colin', 'Fields', '733705068', '2003-10-06', '938292190',
        'P.O. Box 232, 8946 Arcu Road', 18009249),
       (9, 'Silas', 'Atkins', '213368800', '1979-11-08', '960940665',
        '7125 Fusce Rd.', 80712126),
       (10, 'Igor', 'Lopez', '897562001', '1962-08-10', '921145580',
        '6916288 Vulputate, Rd.', 98803632),
       (11, 'Philip', 'Burt', '876075987', '1975-11-06', '912213595',
        'Ap #1776313 Euismod Ave', 18009249),
       (12, 'Chancellor', 'Harrison', '792214648', '2003-03-18', '926001603',
        'Ap #2976425 Nunc St.', 80712126),
       (13, 'Oliver', 'Gillespie', '805403178', '1985-02-09', '962854869',
        '3286911 Ac Avenue', 98803632),
       (14, 'Brynn', 'Daugherty', '906485786', '1955-02-14', '928775499',
        'Ap #9621515 Eleifend Street', 18009249),
       (15, 'Amy', 'Page', '494828449', '1979-11-08', '933658304',
        '7545 Donec St.', 80712126),
       (16, 'Felicia', 'Spencer', '711568446', '1955-02-14', '911116871',
        'Ap #4159924 Amet St.', 98803632),
       (17, 'Curran', 'Copeland', '528576454', '1998-12-21', '913145802',
        '5305327 Sed Rd.', 18009249),
       (18, 'Murphy', 'Kemp', '811835881', '1974-04-05', '913343930',
        '9381760 Quisque St.', 84405270),
       (19, 'Anastasia', 'Beasley', '340651879', '1976-09-06', '938982382',
        'P.O. Box 315, 9951 Ipsum. Road', 59450903),
       (20, 'Renee', 'Willis', '743066401', '1950-08-27', '917123601',
        'Ap #6452031 Feugiat St.', 80712126),
       (21, 'Cecilia', 'Cohen', '557392488', '1961-12-25', '919885629',
        'P.O. Box 221, 2564 Hymenaeos. Rd.', 98803632),
       (22, 'Tatum', 'Morgan', '267289451', '2004-12-20', '917120219',
        '3362127 Dui, Rd.', 18009249),
       (23, 'Shelley', 'Wilson', '961640773', '2013-04-10', '918231528',
        '366181 Praesent Rd.', 84405270),
       (24, 'Herrod', 'Williamson', '169487017', '2016-10-07', '938243873',
        'Ap #5923344 Ornare, St.', 84405270),
       (25, 'Gannon', 'Ferrell', '579705818', '1972-12-15', '968296009',
        'P.O. Box 101, 4993 Ac Street', 59450903),
       (26, 'Lois', 'Rogers', '779842636', '2012-12-15', NULL,
        'Ap #2739201 Aliquet St.', 59450903),
       (27, 'Vladimir', 'Aguilar', '344558304', '2016-10-07', '920946150',
        'P.O. Box 656, 6892 Aliquet St.', 80712126),
       (28, 'Ralph', 'Velasquez', '910547134', '2017-06-25', '920412277',
        '1979 Mauris Street', 98803632),
       (29, 'Naida', 'Reese', '766979560', '1949-07-25', NULL,
        '1079 Egestas Street', 18009249),
       (30, 'Hayes', 'Kennedy', '457635477', '1954-12-23', '932735783',
        '2197745 Sed St.', 84405270),
       (31, 'Uma', 'Mckinney', '779859636', '1988-03-01', '914433253',
        '9432 Placerat Av.', 84405270),
       (32, 'Pearl', 'Meadows', '267959451', '1978-05-08', '931589092',
        'P.O. Box 132, 2588 Euismod Rd.', 84405270),
       (33, 'Janna', 'Santos', '167389451', '2013-02-09', '928493957',
        '459 Risus Road', 84405270),
       (34, 'Angelica', 'Wall', '163282451', '1973-08-01', '960881154',
        '3514 Faucibus St.', 84405270),
       (35, 'Cassandra', 'Sexton', '178289451', '1957-09-20', '964134676',
        'Ap #860-6325 Volutpat Av.', 84405270),
       (36, 'Quemby', 'Edwards', '967289451', '1992-04-21', '912634932',
        'P.O. Box 954, 3513 Ornare Rd.', 59450903),
       (37, 'Beverly', 'Maxwell', '667289451', '1969-01-14', '921625606',
        '7458 Nec, St.', 59450903),
       (38, 'Elizabeth', 'Raymond', '913134672', '1985-02-09', '921692689',
        '7156 Libero Street', 59450903),
       (39, 'Duncan', 'Porter', '167333451', '2017-06-25', '911149362',
        'P.O. Box 183, 5684 Ut Ave', 59450903),
       (40, 'Sybil', 'Kelley', '779255666', '1993-05-02', '1949-07-25',
        'Ap #722-7219 Elit. Street', 59450903),
       (41, 'Savate', 'Carey', '507776422', '2004-12-20', '956487393',
        'Ap #2372644 Lorem. St.', 84405270);

INSERT INTO 'Necessitado' ('id', 'rendimento')
VALUES (2, 403),
       (3, 56),
       (4, 367),
       (5, 339),
       (7, 366),
       (8, 764),
       (9, 43),
       (13, 402),
       (14, 700),
       (17, 495),
       (18, 272),
       (21, 700),
       (22, 45),
       (25, 191),
       (26, 73),
       (27, 103),
       (28, 707),
       (29, 257),
       (41, 200);

INSERT INTO 'Abrigo' ('id', 'morada', 'numeroCamas', 'codigoZona')
VALUES (1, 'P.O. Box 656, 6892 Aliquet St.', 20, 80712126),
       (2, '1979 Mauris Street', 15, 98803632),
       (3, '1079 Egestas Street', 15, 18009249);

INSERT INTO 'Voluntario' ('id', 'abrigo')
VALUES (30, 2),
       (1, 3),
       (23, 1),
       (24, NULL);

INSERT INTO 'Orientador' ('id', 'horaInicio', 'horaFim')
VALUES (19, 14, 18),
       (20, 8, 12),
       (10, 10, 14),
       (11, 18, 20);

INSERT INTO 'Administrador' ('id', 'horaInicio', 'horaFim', 'numeroEscritorio')
VALUES (12, 14, 18, 1),
       (6, 10, 14, 2);

INSERT INTO 'DoacaoMonetaria' ('id', 'pessoa', 'data', 'valor', 'frequencia')
VALUES (1, 37, '2021-05-06', 489, 4),
       (2, 37, '2020-12-05', 162, 20),
       (3, 39, '2021-09-07', 4, 11),
       (4, 31, '2021-11-15', 318, 6),
       (5, 33, '2021-05-27', 494, 7),
       (6, 35, '2020-08-03', 284, 16),
       (7, 32, '2021-12-19', 493, 0),
       (8, 31, '2021-10-03', 390, 14),
       (9, 34, '2021-12-05', 113, 24),
       (10, NULL, '2020-10-19', 354, 0),
       (11, 37, '2021-06-11', 339, 6),
       (12, 35, '2021-04-23', 139, 13),
       (13, 36, '2021-10-06', 56, 15),
       (14, 39, '2021-06-24', 401, 5),
       (15, 36, '2020-09-23', 464, 0),
       (16, 40, '2020-12-07', 410, 16),
       (17, 37, '2022-02-12', 123, 22),
       (18, 35, '2021-02-02', 74, 13),
       (19, 32, '2022-01-07', 20, 13),
       (20, 33, '2021-01-27', 390, 0);

INSERT INTO 'DoacaoMaterial' ('id', 'pessoa', 'data')
VALUES (1, 39, '2020-07-04'),
       (2, 40, '2020-06-06'),
       (3, 32, '2021-10-14'),
       (4, 36, '2021-07-08'),
       (5, 35, '2021-05-31'),
       (6, 39, '2021-03-16'),
       (7, 40, '2020-04-22'),
       (8, NULL, '2021-05-31'),
       (9, 37, '2020-09-03'),
       (10, 34, '2021-02-21'),
       (11, 37, '2021-12-21'),
       (12, 34, '2022-01-22'),
       (13, 34, '2020-12-30'),
       (14, 31, '2020-05-09'),
       (15, 40, '2021-11-29');

INSERT INTO 'PedidoApoio' ('id', 'justificacao', 'tipo', 'prioridade',
                           'avaliador', 'pedinte')
VALUES (1, 'Violência doméstica', 'Alojamento', 9, 6, 7),
       (2, 'Desastre Natural', 'Alojamento', 10, 6, 3),
       (3, 'Sem abrigo', 'Alojamento', 10, 12, 4),
       (4, 'Orfão', 'Monetário', 4, 12, 2),
       (5, 'Doença', 'Monetário', 3, 12, 21),
       (6, 'Desintoxicação', 'Monetário', 9, 6, 5),
       (7, 'Desemprego', 'Material', 5, 6, 26),
       (8, 'Fome', 'Material', 7, 6, 29),
       (9, 'Fome', 'Material', 3, 12, 17),
       (10, 'Incêndio', 'Material', 6, 12, 7),
       (11, 'Incêndio', 'Monetário', 1, 6, 7),
       (12, 'Doença', 'Material', 7, 6, 26),
       (13, 'Incêndio', 'Material', 10, 12, 5),
       (14, 'Casa Precária', 'Alojamento', 5, 12, 41),
       (15, 'Casa Precária', 'Alojamento', 5, 6, 13),
       (16, 'Prédio Caiu', 'Alojamento', 1, 6, 3),
       (17, 'Prédio Caiu', 'Alojamento', 1, 6, 26), 
       (18, 'Prédio Caiu', 'Alojamento', 1, 6, 29),
       (19, 'Prédio Caiu', 'Alojamento', 1, 6, 2),
       (20, 'Prédio Caiu', 'Alojamento', 1, 6, 5),
       (21, 'Prédio Caiu', 'Alojamento', 1, 6, 7),
       (22, 'Prédio Caiu', 'Alojamento', 1, 6, 4),
       (23, 'Fome', 'Material', 5, 12, 3);

INSERT INTO 'Produto' ('codigo', 'nome')
VALUES (1, 'Massa'),
       (2, 'Feijão enlatado'),
       (3, 'Atum enlatado'),
       (4, 'Cereais'),
       (5, 'Arroz'),
       (6, 'Shampoo'),
       (7, 'Escova de dentes'),
       (8, 'Pensos higiénicos'),
       (9, 'Pasta de dentes'),
       (10, 'Pensos higiénicos'),
       (11, 'T-shirts'),
       (12, 'Jeans'),
       (13, 'Sweats'),
       (14, 'Meias'),
       (15, 'Casacos'),
       (16, 'Azeite');

INSERT INTO 'TipoProdutoAlimentar' ('id', 'tipo')
VALUES (1, 'Hidratos'),
       (2, 'Enlatados carne e peixe'),
       (3, 'Cereais'),
       (4, 'Enlatados leguminosas'),
       (5, 'Óleos'),
       (6, 'Especiarias'),
       (7, 'Doces');

INSERT INTO 'ProdutoAlimentar' ('codigo', 'dataValidade', 'tipo')
VALUES (1, '2021-11-29', 1),
       (2, '2022-10-20', 4),
       (3, '2022-01-17', 2),
       (4, '2021-11-29', 3),
       (5, '2021-01-08', 1),
       (16, '2021-05-13', 5);

INSERT INTO 'ProdutoHigiene' ('codigo', 'genero')
VALUES (6, 'Unisexo'),
       (7, 'Unisexo'),
       (8, 'Feminino'),
       (9, 'Unisexo'),
       (10, 'Feminino');

INSERT INTO 'ProdutoVestuario' ('codigo', 'tamanho')
VALUES (11, 'M'),
       (12, 'L'),
       (13, 'XL'),
       (14, 'S'),
       (15, 'XS');

INSERT INTO 'Apoio' ('id', 'dataInicio', 'dataFim', 'pedido', 'Orientador')
VALUES (1, '2020-08-03', '2023-01-23', 1, 19),
       (2, '2020-05-07', '2022-08-28', 2, 10),
       (3, '2021-01-06', '2022-08-12', 3, 20),
       (4, '2021-04-05', '2022-11-05', 4, 11),
       (5, '2021-07-12', '2022-05-08', 6, 11),
       (6, '2021-10-13', '2022-08-16', 7, 10),
       (7, '2020-11-25', '2022-04-11', 8, 10),
       (8, '2021-07-11', '2022-11-05', 10, 19),
       (9, '2020-10-10', '2020-10-11', 16, 11);

INSERT INTO 'ApoioMonetario' ('id', 'valor')
VALUES (4, 600),
       (6, 700)
       (9, 500);


INSERT INTO 'ApoioAlojamento' ('id', 'abrigo')
VALUES (1, 2),
       (2, 3),
       (3, 1);


INSERT INTO 'ApoioMaterial' ('id')
VALUES (6),
       (7),
       (8);


INSERT INTO 'DoacaoMaterialContemProduto'('doacao', 'produto')
VALUES (1, 2),
       (1, 16),
       (2, 13),
       (3, 8),
       (4, 6),
       (5, 10),
       (6, 14),
       (7, 1),
       (8, 4),
       (9, 11),
       (10, 9),
       (11, 3),
       (12, 15),
       (13, 5),
       (14, 12),
       (15, 7);


INSERT INTO 'ApoioMaterialIncluiProduto'('apoio', 'produto')
VALUES (6, 15),
       (6, 3),
       (6, 1),
       (7, 4),
       (8, 11),
       (8, 15);


INSERT INTO 'VoluntarioParticipaApoio'('voluntario', 'apoio')
VALUES (30, 1),
       (30, 5),
       (1, 3),
       (1, 6),
       (23, 2),
       (24, 4),
       (24, 7),
       (24, 8);
