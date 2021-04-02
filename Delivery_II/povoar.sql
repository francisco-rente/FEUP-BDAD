PRAGMA foreign_keys = ON;

INSERT INTO
    'Pais' ('codigo', 'nome')
VALUES
    (12, 'Portugal'),
    (14, 'Espanha');

INSERT INTO
    'Localidade' ('codigoZona', 'codigoPais', 'nome')
VALUES
    (80712126, 12, 'Porto'),
    (98803632, 12, 'Braga'),
    (18009249, 12, 'Viseu'),
    (59450903, 14, 'Madrid'),
    (84405270, 14, 'Valencia');

INSERT INTO
    'Pessoa' (
        'id',
        'primeiroNome',
        'ultimoNome',
        'NIF',
        'dataNascimento',
        'numeroTelefone',
        'morada',
        'codigoZona'
    )
VALUES
    (
        1,
        'Lucy',
        'Powers',
        '561897593',
        '10/12/1988',
        '962698077',
        '2039028 Non, Street',
        80712126
    ),
    (
        2,
        'Gary',
        'Mccray',
        '554484337',
        '30/09/1980',
        '964472809',
        '5451 Id St.',
        98803632
    ),
    (
        3,
        'Zeus',
        'Carey',
        '503356430',
        '05/01/1951',
        '926444783',
        'Ap #2372644 Lorem. St.',
        18009249
    ),
    (
        4,
        'Hakeem',
        'Lambert',
        '057347794',
        '06/02/1972',
        '931047619',
        NULL,
        84405270
    ),
    (
        5,
        'Nolan',
        'Mccall',
        '216393783',
        '01/11/1983',
        '913512298',
        NULL,
        59450903
    ),
    (
        6,
        'Amanda',
        'Shaw',
        '090330256',
        '17/09/2020',
        '911513512',
        'P.O. Box 749, 9030 Mattis Rd.',
        80712126
    ),
    (
        7,
        'Ima',
        'Dejesus',
        '741848946',
        '27/06/2002',
        '927553624',
        NULL,
        98803632
    ),
    (
        8,
        'Colin',
        'Fields',
        '733705068',
        '04/11/1948',
        '938292190',
        'P.O. Box 232, 8946 Arcu Road',
        18009249
    ),
    (
        9,
        'Silas',
        'Atkins',
        '213368800',
        '19/09/1981',
        '960940665',
        '7125 Fusce Rd.',
        80712126
    ),
    (
        10,
        'Igor',
        'Lopez',
        '897562001',
        '15/03/1975',
        '921145580',
        '6916288 Vulputate, Rd.',
        98803632
    ),
    (
        11,
        'Philip',
        'Burt',
        '876075987',
        '17/01/2014',
        '912213595',
        'Ap #1776313 Euismod Ave',
        18009249
    ),
    (
        12,
        'Chancellor',
        'Harrison',
        '792214648',
        '27/03/2015',
        '926001603',
        'Ap #2976425 Nunc St.',
        80712126
    ),
    (
        13,
        'Oliver',
        'Gillespie',
        '805403178',
        '10/11/2012',
        '962854869',
        '3286911 Ac Avenue',
        98803632
    ),
    (
        14,
        'Brynn',
        'Daugherty',
        '906485786',
        '04/02/2022',
        '928775499',
        'Ap #9621515 Eleifend Street',
        18009249
    ),
    (
        15,
        'Amy',
        'Page',
        '494828449',
        '09/09/1988',
        '933658304',
        '7545 Donec St.',
        80712126
    ),
    (
        16,
        'Felicia',
        'Spencer',
        '711568446',
        '29/06/2013',
        '911116871',
        'Ap #4159924 Amet St.',
        98803632
    ),
    (
        17,
        'Curran',
        'Copeland',
        '528576454',
        '08/01/1954',
        '913145802',
        '5305327 Sed Rd.',
        18009249
    ),
    (
        18,
        'Murphy',
        'Kemp',
        '811835881',
        '23/02/1957',
        '913343930',
        '9381760 Quisque St.',
        84405270
    ),
    (
        19,
        'Anastasia',
        'Beasley',
        '340651879',
        '27/09/1979',
        '938982382',
        'P.O. Box 315, 9951 Ipsum. Road',
        59450903
    ),
    (
        20,
        'Renee',
        'Willis',
        '743066401',
        '01/01/1998',
        '917123601',
        'Ap #6452031 Feugiat St.',
        80712126
    ),
    (
        21,
        'Cecilia',
        'Cohen',
        '557392488',
        '29/03/2006',
        '919885629',
        'P.O. Box 221, 2564 Hymenaeos. Rd.',
        98803632
    ),
    (
        22,
        'Tatum',
        'Morgan',
        '267289451',
        '19/11/1981',
        '917120219',
        '3362127 Dui, Rd.',
        18009249
    ),
    (
        23,
        'Shelley',
        'Wilson',
        '961640773',
        '17/06/1984',
        '918231528',
        '366181 Praesent Rd.',
        84405270
    ),
    (
        24,
        'Herrod',
        'Williamson',
        '169487017',
        '25/09/2012',
        '938243873',
        'Ap #5923344 Ornare, St.',
        84405270
    ),
    (
        25,
        'Gannon',
        'Ferrell',
        '579705818',
        '16/06/1959',
        '968296009',
        'P.O. Box 101, 4993 Ac Street',
        59450903
    ),
    (
        26,
        'Lois',
        'Rogers',
        '779842636',
        '25/06/1986',
        NULL,
        'Ap #2739201 Aliquet St.',
        59450903
    ),
    (
        27,
        'Vladimir',
        'Aguilar',
        '344558304',
        '19/01/2012',
        '920946150',
        'P.O. Box 656, 6892 Aliquet St.',
        80712126
    ),
    (
        28,
        'Ralph',
        'Velasquez',
        '910547134',
        '01/11/1957',
        '920412277',
        '1979 Mauris Street',
        98803632
    ),
    (
        29,
        'Naida',
        'Reese',
        '766979560',
        '24/02/1974',
        NULL,
        '1079 Egestas Street',
        18009249
    ),
    (
        30,
        'Hayes',
        'Kennedy',
        '457635477',
        '14/01/2016',
        '932735783',
        '2197745 Sed St.',
        84405270
    ),
    (
        31,
        'Uma',
        'Mckinney',
        '779859636',
        '11/09/1970',
        '914433253',
        '9432 Placerat Av.',
        84405270
    ),
    (
        32,
        'Pearl',
        'Meadows',
        '267959451',
        '07/08/1976',
        '931589092',
        'P.O. Box 132, 2588 Euismod Rd.',
        84405270
    ),
    (
        33,
        'Janna',
        'Santos',
        '167389451',
        '18/03/1968',
        '928493957',
        '459 Risus Road',
        84405270
    ),
    (
        34,
        'Angelica',
        'Wall',
        '163282451',
        '04/03/1998',
        '960881154',
        '3514 Faucibus St.',
        84405270
    ),
    (
        35,
        'Cassandra',
        'Sexton',
        '178289451',
        '24/02/2014',
        '964134676',
        'Ap #860-6325 Volutpat Av.',
        84405270
    ),
    (
        36,
        'Quemby',
        'Edwards',
        '967289451',
        '19/04/1992',
        '912634932',
        'P.O. Box 954, 3513 Ornare Rd.',
        59450903
    ),
    (
        37,
        'Beverly',
        'Maxwell',
        '667289451',
        '11/05/1992',
        '921625606',
        '7458 Nec, St.',
        59450903
    ),
    (
        38,
        'Elizabeth',
        'Raymond',
        '913134672',
        '28/02/1982',
        '921692689',
        '7156 Libero Street',
        59450903
    ),
    (
        39,
        'Duncan',
        'Porter',
        '167333451',
        '19/01/1962',
        '911149362',
        'P.O. Box 183, 5684 Ut Ave',
        59450903
    ),
    (
        40,
        'Sybil',
        'Kelley',
        '779255666',
        '05/02/1993',
        '911364574',
        'Ap #722-7219 Elit. Street',
        59450903
    );

INSERT INTO
    'Necessitado' ('id', 'rendimento')
VALUES
    (2, 403),
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
    (29, 257);

INSERT INTO
    'Abrigo' ('id', 'morada', 'numeroCamas', 'codigoZona')
VALUES
    (
        1,
        'P.O. Box 656, 6892 Aliquet St.',
        20,
        80712126
    ),
    (
        2,
        '1979 Mauris Street',
        15,
        98803632
    ),
    (
        3,
        '1079 Egestas Street',
        15,
        18009249
    );

INSERT INTO
    'Voluntario' ('id', 'abrigo')
VALUES
    (30, 2),
    (1, 3),
    (23, 1),
    (24, NULL);

INSERT INTO
    'Orientador' ('id', 'horaInicio', 'horaFim')
VALUES
    (19, 14, 18),
    (20, 8, 12),
    (10, 10, 14),
    (11, 18, 20);

INSERT INTO
    'Administrador' (
        'id',
        'horaInicio',
        'horaFim',
        'numeroEscritorio'
    )
VALUES
    (12, 14, 18, 1),
    (6, 10, 14, 2);

INSERT INTO
    'DoacaoMonetaria' ('id', 'pessoa', 'data', 'valor', 'frequencia')
VALUES
    (1, 37, '05/06/2021', 489, 4),
    (2, 37, '05/12/2020', 162, 20),
    (3, 39, '09/07/2021', 4, 11),
    (4, 31, '15/11/2021', 318, 6),
    (5, 33, '27/05/2021', 494, 7),
    (6, 35, '03/08/2020', 284, 16),
    (7, 32, '19/12/2021', 493, 4),
    (8, 31, '03/10/2021', 390, 14),
    (9, 34, '05/12/2021', 113, 24),
    (10, 39, '19/10/2020', 354, 23),
    (11, 37, '11/06/2021', 339, 6),
    (12, 35, '23/04/2021', 139, 13),
    (13, 36, '06/10/2021', 56, 15),
    (14, 39, '24/09/2021', 401, 5),
    (15, 36, '28/09/2020', 464, 13),
    (16, 40, '07/12/2020', 410, 16),
    (17, 37, '15/02/2022', 123, 22),
    (18, 35, '01/03/2021', 74, 13),
    (19, 32, '17/01/2022', 20, 13),
    (20, 33, '22/01/2021', 390, 21);

INSERT INTO
    'DoacaoMaterial' ('id', 'pessoa', 'data')
VALUES
    (1, 39, '04/07/2020'),
    (2, 40, '06/07/2020'),
    (3, 32, '14/10/2021'),
    (4, 36, '07/08/2021'),
    (5, 35, '31/05/2021'),
    (6, 39, '16/03/2021'),
    (7, 40, '22/04/2020'),
    (8, 33, '31/05/2021'),
    (9, 37, '03/09/2020'),
    (10, 34, '23/02/2021'),
    (11, 37, '21/12/2021'),
    (12, 34, '22/01/2022'),
    (13, 34, '30/12/2020'),
    (14, 31, '05/09/2020'),
    (15, 40, '29/11/2021');

INSERT INTO
    'PedidoApoio' (
        'id',
        'justificacao',
        'tipo',
        'prioridade',
        'avaliador',
        'pedinte'
    )
VALUES
    (
        1,
        'Violência doméstica',
        'Alojamento',
        9,
        6,
        7
    ),
    (
        2,
        'Terramoto',
        'Alojamento procura-se',
        10,
        6,
        3
    ),
    (
        3,
        'Sem abrigo',
        'Alojamento',
        10,
        12,
        4
    ),
    (
        4,
        'Orfão',
        'Monetário',
        4,
        12,
        2
    ),
    (
        5,
        'Doença',
        'Monetário',
        3,
        12,
        21
    ),
    (
        6,
        'Desintoxicação',
        'Monetário',
        9,
        6,
        5
    ),
    (
        7,
        'Pedofilia',
        'Material',
        5,
        6,
        26
    ),
    (
        8,
        'Fome',
        'Material',
        7,
        6,
        29
    ),
    (
        9,
        'Fome',
        'Material',
        3,
        12,
        17
    ),
    (
        10,
        'Falta vestuario para cobrir-me durante o Inverno. Ai que frio!',
        'Material',
        6,
        12,
        9
    );

INSERT INTO
    'Produto' ('id', 'nome', 'codigo', 'dimensao')
VALUES
    (1, 'massa', 6123, 2),
    (2, 'feijao enlatado', 1681, 1),
    (3, 'atum enlatado', 1879, 10),
    (4, 'cereais', 2269, 2),
    (5, 'arroz', 9987, 8),
    (6, 'shampoo', 5618, 1),
    (7, 'escova de dentes', 2086, 6),
    (8, 'pensos higienicos', 7777, 6),
    (9, 'pasta de dentes', 1187, 10),
    (10, 'pensos higienicos', 7777, 4),
    (11, 't-shirts', 2096, 10),
    (12, 'jeans', 4086, 5),
    (13, 'sweats', 1043, 7),
    (14, 'meias', 4781, 9),
    (15, 'casacos', 8086, 2),
    (16, 'azeite', 1845, 4);

INSERT INTO
    'TipoAlimentar' ('id', 'tipo')
VALUES
    (1, 'hidratos'),
    (2, 'enlatados carne e peixe'),
    (3, 'cereais'),
    (4, 'enlatados leguminosas'),
    (5, 'oleos'),
    (6, 'especiarias'),
    (7, 'doces');

INSERT INTO
    'ProdutoAlimentar' ('id', 'dataValidade', 'tipo')
VALUES
    (1, '29/11/2021', 1),
    (2, '17/01/2022', 4),
    (3, '17/01/2022', 2),
    (4, '29/11/2021', 3),
    (5, '29/11/2021', 1),
    (16, '29/11/2021', 5);

INSERT INTO
    'ProdutoHigiene' ('id', 'genero')
VALUES
    (6, 'unisexo'),
    (7, 'unisexo'),
    (8, 'feminino'),
    (9, 'unisexo'),
    (10, 'feminino');

INSERT INTO
    'ProdutoVestuario' ('id', 'tamanho')
VALUES
    (11, 'M'),
    (12, 'L'),
    (13, 'XL'),
    (14, 'S'),
    (15, 'XS');

INSERT INTO
    'Apoio' (
        'id',
        'dataInicio',
        'dataFim',
        'pedido',
        'Orientador'
    )
VALUES
    (1, '03/08/2020', '26/01/2023', 1, 19),
    (2, '05/07/2020', '28/09/2022', 2, 10),
    (3, '06/01/2021', '12/08/2022', 3, 20),
    (4, '05/04/2021', '05/11/2022', 4, 11),
    (5, '12/07/2021', '08/05/2022', 6, 11),
    (6, '13/10/2021', '16/08/2022', 7, 10),
    (7, '25/11/2020', '11/04/2022', 8, 10),
    (8, '10/07/2021', '05/11/2022', 10, 19);

INSERT INTO
    'ApoioMonetario' ('id', 'valor')
VALUES
    (4, 600),
    (6, 700);

INSERT INTO
    'ApoioAlojamento' ('id', 'abrigo')
VALUES
    (1, 2),
    (2, 3),
    (3, 1);

INSERT INTO
    'ApoioMaterial' ('id')
VALUES
    (6),
    (7),
    (8);

INSERT INTO
    'DoacaoMaterialContemProduto'('doacao', 'produto')
VALUES
    (1, 2),
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

INSERT INTO
    'ApoioMaterialIncluiProduto'('apoio', 'produto')
VALUES
    (6, 15),
    (6, 3),
    (6, 1),
    (7, 4),
    (8, 11),
    (8, 15);

INSERT INTO
    'VoluntarioParticipaApoio'('voluntario', 'apoio')
VALUES
    (30, 1),
    (30, 5),
    (1, 3),
    (1, 6),
    (23, 2),
    (24, 4),
    (24, 7),
    (24, 8);