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

--define tables
--FD:
--{id}->{primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada, codigoZona}
--{NIF}->{id, primeiroNome, ultimoNome, dataNascimento, numeroTelefone, morada, codigoZona} !!!!!!
--Possiveis:
--{morada, numeroTelefone}->{codigoZona}, ou algo semelhante !!!!!! JUST: numeros iguais em paises diferentes
CREATE TABLE Pessoa (
    id INTEGER,
    primeiroNome VARCHAR(64) NOT NULL,
    ultimoNome VARCHAR(64),
    NIF VARCHAR(64),
    dataNascimento DATE NOT NULL,
    numeroTelefone VARCHAR(9),
    morada VARCHAR(255),
    codigoZona INTEGER REFERENCES Localidade (codigoZona),
    PRIMARY KEY (id),
    CONSTRAINT unique_nif UNIQUE (NIF)
);

--FD:
--{id}->{rendimento}
CREATE TABLE Necessitado (
    id INTEGER REFERENCES Pessoa (id),
    rendimento REAL NOT NULL,
    CONSTRAINT rendimento_positivo CHECK (rendimento >= 0),
    CONSTRAINT rendimento_nao_aceitavel CHECK (rendimento <= 800),
    PRIMARY KEY (id) --- perguntar se a limitacao e feita agora ou com triggers
);

--FD:
--{id}->{abrigo}
CREATE TABLE Voluntario (
    id INTEGER REFERENCES Pessoa (id),
    abrigo INTEGER REFERENCES Abrigo (id),
    PRIMARY KEY (id)
);

--FD:
--{id}->{horaInicio, horaFim}
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

--FD:
--{id}->{horaInicio, horaFim, numeroEscritorio}
CREATE TABLE Administrador (
    id INTEGER REFERENCES Pessoa (id),
    horaInicio INTEGER NOT NULL,
    horaFim INTEGER NOT NULL,
    numeroEscritorio INTEGER,
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
    ) --- horas derivadas 
);

--FD:
--{id}->{idPessoa, data}
CREATE TABLE DoacaoMaterial (
    id INTEGER,
    pessoa INTEGER REFERENCES Pessoa (id),
    data DATE NOT NULL,
    PRIMARY KEY (id)
);

--FD:
--{id}->{pessoa, data, valor, frequencia}
CREATE TABLE DoacaoMonetaria (
    id INTEGER,
    pessoa INTEGER REFERENCES Pessoa (id),
    data DATE NOT NULL,
    valor REAL NOT NULL,
    frequencia INTEGER NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT limiteMonetario CHECK (
        0 < valor
        and valor <= 500
    ),
    CONSTRAINT frequenciaPositiva CHECK (frequencia >= 0)
);

--FD:
--{id}->{dataInicio, dataFim, pedido, orientador}
--{pedido}->{dataInicio, dataFim, orientador} !!!!!!
CREATE TABLE Apoio (
    id INTEGER,
    dataInicio DATE NOT NULL,
    dataFim DATE,
    pedido INTEGER REFERENCES PedidoApoio (id),
    orientador INTEGER REFERENCES Orientador (id),
    PRIMARY KEY (id) --CONSTRAINT dataCoerente CHECK (dataInicio < dataFim) ---questionar sobre a insercao e a comparacao no caso de data fim
);

--FD:
--{id}->{valor}
CREATE TABLE ApoioMonetario (
    id INTEGER REFERENCES Apoio (id),
    valor INTEGER NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT valorPositivo CHECK (valor > 0) ---valor deve ser suportado por fundos doacoes - apoios-->triggers
);

--FD:
--{id}->{abrigo}
CREATE TABLE ApoioAlojamento (
    id INTEGER REFERENCES Apoio (id),
    abrigo INTEGER REFERENCES Abrigo (id),
    PRIMARY KEY (id)
);

CREATE TABLE ApoioMaterial (
    id INTEGER REFERENCES Apoio (id),
    PRIMARY KEY (id)
);

--FD:
--{id}->{nome, codigo, dimensao}
--{codigo}->{nome, dimensao} !!!!!! JUST: nao viola codigo e candidate key
CREATE TABLE Produto (
    id INTEGER,
    nome VARCHAR(64) NOT NULL,
    codigo INTEGER NOT NULL,
    dimensao INTEGER NOT NULL,
    PRIMARY KEY (id)
);

--FD:
--{id}->{genero}
CREATE TABLE ProdutoHigiene (
    id REFERENCES Produto (id),
    genero VARCHAR(10),
    PRIMARY KEY (id)
);

--FD:
--{id}->{tamanho}
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

--FD:
--{id}->{dataValidade, tipo}
CREATE TABLE ProdutoAlimentar (
    id REFERENCES Produto (id),
    dataValidade DATE NOT NULL,
    tipo INTEGER REFERENCES TipoAlimentar (id),
    PRIMARY KEY (id)
);

--FD:
--{id}->{tipo}
CREATE TABLE TipoAlimentar (
    id INTEGER,
    tipo VARCHAR(64) NOT NULL,
    PRIMARY KEY (id)
);

--FD:
--{codigoZona}->{nome, codigoPais}
CREATE TABLE Localidade (
    codigoZona INTEGER NOT NULL,
    codigoPais INTEGER REFERENCES Pais (codigo),
    nome VARCHAR(64) NOT NULL,
    PRIMARY KEY (codigoZona)
);

--FD:
--{codigo}->{nome}
--{nome}->{codigo} !!!!!!
CREATE TABLE Pais (
    codigo INTEGER,
    nome VARCHAR(64) NOT NULL,
    PRIMARY KEY (codigo)
);

--FD:
--{id}->{justificacao, tipo, prioridade, avaliador}
--Possiveis:
--{justificacao}->{prioridade} !!!!!!
CREATE TABLE PedidoApoio (
    id INTEGER,
    justificacao TEXT NOT NULL,
    ---colocar como ENUM/conj pre definido
    tipo VARCHAR(16) NOT NULL,
    prioridade INTEGER NOT NULL,
    avaliador INTEGER REFERENCES Administrador (id),
    pedinte INTEGER REFERENCES Necessitado (id),
    PRIMARY KEY (id),
    CONSTRAINT limitesPrioridade CHECK (
        prioridade >= 0
        and prioridade <= 10
    )
);

---morada e zona
---FD:
---{id}->{morada, numeroCamas, codigoZona}
---{morada, codigoZona}->{id, numeroCamas} !!!!!! Possivel Just: varios abrigos na mesma zona ou morada e codigo ser chave
CREATE TABLE Abrigo (
    id INTEGER,
    morada VARCHAR(255) NOT NULL,
    numeroCamas INTEGER NOT NULL,
    codigoZona INTEGER REFERENCES Localidade (codigoZona),
    PRIMARY KEY (id),
    CONSTRAINT numeroCamasPositivo CHECK (numeroCamas > 0)
);

CREATE TABLE DoacaoMaterialContemProduto (
    doacao INTEGER REFERENCES DoacaoMaterial (id),
    produto INTEGER REFERENCES Produto (id),
    PRIMARY KEY (doacao, produto)
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

/* CREATE TABLE PessoaContribuiDoacaoMaterial
 (
 doacaoMaterial INTEGER REFERENCES DoacaoMaterial (id),
 pessoa         INTEGER REFERENCES Pessoa (id),
 PRIMARY KEY (doacaoMaterial)
 ); */
--considerations
--atributos derivados: numeroDeCamasRestantes, horas de trabalho 
--triggers:
-- triggers CONSTRAINT validadeMinima CHECK(produto.dataValidade >= doacao.dataDoacao + 1 mes ) at DoacaoMaterialContemProduto
---triggers CONSTRAINT numeroCamasRestantesCoerente CHECK(numeroCamas >= numeroCamasRestantes) at Abrigo 
--Duvidas:
--derivadas
--NOT NULL Foreign Key
--FD
--codigo de produto vs id produto vs todos juntos