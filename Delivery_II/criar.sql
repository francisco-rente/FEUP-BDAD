-- Drop every existing table to avoid conflicts
DROP TABLE IF EXISTS Pessoa;
DROP TABLE IF EXISTS Necessitado;
DROP TABLE IF EXISTS Voluntario;
DROP TABLE IF EXISTS Orientador;
DROP TABLE IF EXISTS Administrador;
DROP TABLE IF EXISTS DoacaoMaterial;
DROP TABLE IF EXISTS DoacaoMonetaria;
DROP TABLE IF EXISTS Apoio;
DROP TABLE IF EXISTS ApoioMonetario;
DROP TABLE IF EXISTS ApoioAlojamento;
DROP TABLE IF EXISTS ApoioMaterial;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS ProdutoHigiene;
DROP TABLE IF EXISTS ProdutoVestuario;
DROP TABLE IF EXISTS ProdutoAlimentar;
DROP TABLE IF EXISTS TipoAlimentar;
DROP TABLE IF EXISTS Localidade;
DROP TABLE IF EXISTS Pais;
DROP TABLE IF EXISTS PedidoApoio;
DROP TABLE IF EXISTS Abrigo;
DROP TABLE IF EXISTS DoacaoMaterialContemProduto;
DROP TABLE IF EXISTS ApoioMaterialIncluiProduto;
DROP TABLE IF EXISTS VoluntarioParticipaApoio;

-- Create the tables
CREATE TABLE Pessoa
(
    id             INTEGER,
    primeiroNome   VARCHAR(64) NOT NULL,
    ultimoNome     VARCHAR(64),
    NIF            VARCHAR(64),
    dataNascimento DATE        NOT NULL,
    numeroTelefone VARCHAR(9),
    morada         VARCHAR(255),
    codigoZona     INTEGER     NOT NULL REFERENCES Localidade (codigoZona),
    CONSTRAINT unique_nif UNIQUE (NIF),
    PRIMARY KEY (id)
);

CREATE TABLE Necessitado
(
    id         INTEGER REFERENCES Pessoa (id),
    rendimento REAL NOT NULL,
    CONSTRAINT rendimento_positivo CHECK (rendimento >= 0),
    CONSTRAINT rendimento_nao_aceitavel CHECK (rendimento <= 800),
    PRIMARY KEY (id)
);

CREATE TABLE Voluntario
(
    id     INTEGER REFERENCES Pessoa (id),
    abrigo INTEGER REFERENCES Abrigo (id),
    PRIMARY KEY (id)
);

CREATE TABLE Orientador
(
    id              INTEGER REFERENCES Pessoa (id),
    horaInicio      REAL NOT NULL,
    horaFim         REAL NOT NULL,
    tempoDeTrabalho REAL GENERATED ALWAYS AS (horaFim - horaInicio),
    CONSTRAINT horasDiariasCoerentes CHECK (horaInicio < horaFim),
    CONSTRAINT horasValidasInicio CHECK (
            0 <= horaInicio
            AND horaInicio < 24
        ),
    CONSTRAINT horasValidasFim CHECK (
            0 <= horaFim
            AND horaFim < 24
        ),
    PRIMARY KEY (id)
);

CREATE TABLE Administrador
(
    id               INTEGER REFERENCES Pessoa (id),
    horaInicio       REAL    NOT NULL,
    horaFim          REAL    NOT NULL,
    numeroEscritorio INTEGER NOT NULL,
    tempoDeTrabalho  REAL GENERATED ALWAYS AS (horaFim - horaInicio),
    CONSTRAINT horasDiariasObrigatorias CHECK (horaInicio < horaFim),
    CONSTRAINT horasValidasInicio CHECK (
            0 <= horaInicio
            AND horaInicio < 24
        ),
    CONSTRAINT horasValidasFim CHECK (
            0 <= horaFim
            AND horaFim < 24
        ),
    PRIMARY KEY (id)
);

CREATE TABLE DoacaoMaterial
(
    id     INTEGER,
    pessoa INTEGER REFERENCES Pessoa (id),
    data   DATE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE DoacaoMonetaria
(
    id         INTEGER,
    pessoa     INTEGER REFERENCES Pessoa (id),
    data       DATE    NOT NULL,
    valor      REAL    NOT NULL,
    frequencia INTEGER NOT NULL DEFAULT (0),
    CONSTRAINT limiteMonetario CHECK (
            0 < valor
            AND valor <= 500
        ),
    CONSTRAINT frequenciaValida CHECK (frequencia >= 0),
    PRIMARY KEY (id)
);

CREATE TABLE Apoio
(
    id         INTEGER,
    dataInicio DATE    NOT NULL,
    dataFim    DATE,
    pedido     INTEGER NOT NULL REFERENCES PedidoApoio (id),
    orientador INTEGER NOT NULL REFERENCES Orientador (id),
    CONSTRAINT dataCoerente CHECK (dataInicio < dataFim),
    PRIMARY KEY (id)
);

CREATE TABLE ApoioMonetario
(
    id    INTEGER REFERENCES Apoio (id),
    valor INTEGER NOT NULL,
    CONSTRAINT valorPositivo CHECK (valor > 0),
    -- Note: a trigger should be added on the next delivery to make sure there are enough funds (donations - supports) for this support
    PRIMARY KEY (id)
);

CREATE TABLE ApoioAlojamento
(
    id     INTEGER REFERENCES Apoio (id),
    abrigo INTEGER NOT NULL REFERENCES Abrigo (id),
    PRIMARY KEY (id)
);

CREATE TABLE ApoioMaterial
(
    id INTEGER REFERENCES Apoio (id),
    PRIMARY KEY (id)
);

CREATE TABLE Produto
(
    codigo INTEGER,
    nome   VARCHAR(64) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE ProdutoHigiene
(
    codigo REFERENCES Produto (codigo),
    genero VARCHAR(10) NOT NULL DEFAULT ('Unisexo'),
    PRIMARY KEY (codigo)
);

CREATE TABLE ProdutoVestuario
(
    codigo REFERENCES Produto (codigo),
    tamanho VARCHAR(2) NOT NULL,
    CONSTRAINT tamanhoExistente CHECK (
            tamanho LIKE 'XS'
            OR tamanho LIKE 'S'
            OR tamanho LIKE 'M'
            OR tamanho LIKE 'L'
            OR tamanho LIKE 'XL'
            OR tamanho LIKE 'XXL'
        ),
    PRIMARY KEY (codigo)
);

CREATE TABLE ProdutoAlimentar
(
    codigo REFERENCES Produto (codigo),
    dataValidade DATE                                  NOT NULL,
    tipo         INTEGER REFERENCES TipoAlimentar (id) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE TipoAlimentar
(
    id   INTEGER,
    tipo VARCHAR(64) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Localidade
(
    codigoZona INTEGER,
    codigoPais INTEGER     NOT NULL REFERENCES Pais (codigo),
    nome       VARCHAR(64) NOT NULL,
    PRIMARY KEY (codigoZona)
);

CREATE TABLE Pais
(
    codigo INTEGER,
    nome   VARCHAR(64) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE PedidoApoio
(
    id           INTEGER,
    justificacao TEXT        NOT NULL,
    tipo         VARCHAR(16) NOT NULL,
    prioridade   INTEGER     NOT NULL,
    avaliador    INTEGER     NOT NULL REFERENCES Administrador (id),
    pedinte      INTEGER     NOT NULL REFERENCES Necessitado (id),
    CONSTRAINT limitesPrioridade CHECK (
            prioridade >= 0
            AND prioridade <= 10
        ),
    CONSTRAINT tipoValido CHECK (
            tipo LIKE 'Alojamento'
            OR tipo LIKE 'Material'
            OR tipo LIKE 'Monetário'
        ),
    PRIMARY KEY (id)
);

CREATE TABLE Abrigo
(
    id          INTEGER,
    morada      VARCHAR(255) NOT NULL,
    numeroCamas INTEGER      NOT NULL,
    codigoZona  INTEGER      NOT NULL REFERENCES Localidade (codigoZona),
    CONSTRAINT numeroCamasPositivo CHECK (numeroCamas > 0),
    -- Note: a trigger should be added on the next delivery to update the derived attribute number of remaining beds.
    PRIMARY KEY (id)
);

CREATE TABLE DoacaoMaterialContemProduto
(
    doacao  INTEGER REFERENCES DoacaoMaterial (id),
    produto INTEGER REFERENCES Produto (codigo),
    -- Note: a trigger should be added on the next delivery to block any donations if the expiration date is less than one month from now.
    PRIMARY KEY (doacao, produto)
);

CREATE TABLE ApoioMaterialIncluiProduto
(
    apoio   INTEGER REFERENCES Apoio (id),
    produto INTEGER REFERENCES Produto (codigo),
    PRIMARY KEY (apoio, produto)
);

CREATE TABLE VoluntarioParticipaApoio
(
    voluntario INTEGER REFERENCES Voluntario (id),
    apoio      INTEGER REFERENCES Apoio (id),
    PRIMARY KEY (voluntario, apoio)
);