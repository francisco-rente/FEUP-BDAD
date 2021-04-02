---drop every table that could previously exist
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

DROP TABLE IF EXISTS PessoaContribuiDoacaoMaterial;

CREATE TABLE Pessoa (
    id INTEGER,
    primeiroNome VARCHAR(64) NOT NULL,
    ultimoNome VARCHAR(64),
    NIF VARCHAR(64),
    dataNascimento DATE NOT NULL,
    numeroTelefone VARCHAR(9),
    morada VARCHAR(255),
    codigoZona INTEGER REFERENCES Localidade (codigoZona) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT unique_nif UNIQUE (NIF)
);

CREATE TABLE Necessitado (
    id INTEGER REFERENCES Pessoa (id),
    rendimento REAL NOT NULL,
    CONSTRAINT rendimento_positivo CHECK (rendimento >= 0),
    CONSTRAINT rendimento_nao_aceitavel CHECK (rendimento <= 800),
    PRIMARY KEY (id)
);

CREATE TABLE Voluntario (
    id INTEGER REFERENCES Pessoa (id),
    abrigo INTEGER REFERENCES Abrigo (id),
    PRIMARY KEY (id)
);

CREATE TABLE Orientador (
    id INTEGER REFERENCES Pessoa (id),
    horaInicio INTEGER NOT NULL,
    horaFim INTEGER NOT NULL,
    tempoDeTrabalho INTEGER AS (horaFim - horaInicio),
    PRIMARY KEY (id),
    CONSTRAINT horasDiariasCoerentes CHECK (horaInicio < horaFim),
    CONSTRAINT horasValidasInicio CHECK (
        0 <= horaInicio
        and horaInicio < 24
    ),
    CONSTRAINT horasValidasFim CHECK (
        0 <= horaFim
        and horaFim < 24
    )
);

CREATE TABLE Administrador (
    id INTEGER REFERENCES Pessoa (id),
    horaInicio INTEGER NOT NULL,
    horaFim INTEGER NOT NULL,
    numeroEscritorio INTEGER NOT NULL,
    tempoDeTrabalho INTEGER AS (horaFim - horaInicio),
    PRIMARY KEY (id),
    CONSTRAINT horasDiariasObrigatorias CHECK (horaInicio < horaFim),
    CONSTRAINT horasValidasInicio CHECK (
        0 <= horaInicio
        and horaInicio < 24
    ),
    CONSTRAINT horasValidasFim CHECK (
        0 <= horaFim
        and horaFim < 24
    )
);

CREATE TABLE DoacaoMaterial (
    id INTEGER,
    pessoa INTEGER REFERENCES Pessoa (id),
    data DATE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE DoacaoMonetaria (
    id INTEGER,
    pessoa INTEGER REFERENCES Pessoa (id),
    data DATE NOT NULL,
    valor REAL NOT NULL,
    frequencia INTEGER DEFAULT (0) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT limiteMonetario CHECK (
        0 < valor
        and valor <= 500
    ),
    CONSTRAINT frequenciaValida CHECK (frequencia >= 0)
);

CREATE TABLE Apoio (
    id INTEGER,
    dataInicio DATE NOT NULL,
    dataFim DATE,
    pedido INTEGER REFERENCES PedidoApoio (id) NOT NULL,
    orientador INTEGER REFERENCES Orientador (id) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT dataCoerente CHECK (dataInicio < dataFim)
);

CREATE TABLE ApoioMonetario (
    id INTEGER REFERENCES Apoio (id),
    valor INTEGER NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT valorPositivo CHECK (valor > 0) ---valor deve ser suportado por fundos doacoes - apoios, futura implementação com triggers
);

CREATE TABLE ApoioAlojamento (
    id INTEGER REFERENCES Apoio (id),
    abrigo INTEGER REFERENCES Abrigo (id) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE ApoioMaterial (
    id INTEGER REFERENCES Apoio (id),
    PRIMARY KEY (id)
);

CREATE TABLE Produto (
    id INTEGER,
    nome VARCHAR(64) NOT NULL,
    codigo INTEGER NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE ProdutoHigiene (
    id REFERENCES Produto (id),
    genero VARCHAR(10) DEFAULT ('unisexo') NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE ProdutoVestuario (
    id REFERENCES Produto (id),
    tamanho VARCHAR(2) NOT NULL,
    PRIMARY KEY (id),
    ---ver se tamanho corresponde a uma das opcoes
    CONSTRAINT tamanhoExistente CHECK (
        tamanho LIKE 'XS'
        or tamanho LIKE 'S'
        or tamanho LIKE 'M'
        or tamanho LIKE 'XL'
        or tamanho LIKE 'XXL'
        or tamanho LIKE 'L'
    )
);

CREATE TABLE ProdutoAlimentar (
    id REFERENCES Produto (id),
    dataValidade DATE NOT NULL,
    tipo INTEGER REFERENCES TipoAlimentar (id) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE TipoAlimentar (
    id INTEGER,
    tipo VARCHAR(64) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE Localidade (
    codigoZona INTEGER,
    codigoPais INTEGER REFERENCES Pais (codigo) NOT NULL,
    nome VARCHAR(64) NOT NULL,
    PRIMARY KEY (codigoZona)
);

CREATE TABLE Pais (
    codigo INTEGER,
    nome VARCHAR(64) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE PedidoApoio (
    id INTEGER,
    justificacao TEXT NOT NULL,
    tipo VARCHAR(16) NOT NULL,
    prioridade INTEGER NOT NULL,
    avaliador INTEGER REFERENCES Administrador (id) NOT NULL,
    pedinte INTEGER REFERENCES Necessitado (id) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT limitesPrioridade CHECK (
        prioridade >= 0
        and prioridade <= 10
    ) CONSTRAINT tipoValido CHECK (
        tipo LIKE 'Alojamento'
        or tipo LIKE 'Material'
        or tipo LIKE 'Monetário'
    )
);

CREATE TABLE Abrigo (
    id INTEGER,
    morada VARCHAR(255) NOT NULL,
    numeroCamas INTEGER NOT NULL,
    codigoZona INTEGER REFERENCES Localidade (codigoZona) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT numeroCamasPositivo CHECK (numeroCamas > 0) ---para a terceira entrega será implementado com triggers o atributo derivado numeroCamasRestantes
);

CREATE TABLE DoacaoMaterialContemProduto (
    doacao INTEGER REFERENCES DoacaoMaterial (id),
    produto INTEGER REFERENCES Produto (id),
    PRIMARY KEY (doacao, produto) ---para a terceira entrega adicionar constraint que restringe a data de validade
    ---produto.dataValidade >= doacao.dataDoacao + 1 mes
);

CREATE TABLE ApoioMaterialIncluiProduto (
    apoio INTEGER REFERENCES Apoio (id),
    produto INTEGER REFERENCES Produto (id),
    PRIMARY KEY (apoio, produto)
);

CREATE TABLE VoluntarioParticipaApoio (
    voluntario INTEGER REFERENCES Voluntario (id),
    apoio INTEGER REFERENCES Apoio (id),
    PRIMARY KEY (voluntario, apoio)
);