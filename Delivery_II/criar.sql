---derivados 

CREATE TABLE Person(
    id INTEGER PRIMARY KEY,
    primeiroNome VARCHAR(64) NOT NULL, 
    ultimoNome VARCHAR(64), 
    NIF INTEGER UNIQUE, 
    dataNascimento DATE NOT NULL, 
    numeroTelefone INTEGER, 
    morada VARCHAR(255), 
    codigoZona INTEGER REFERENCES Localidade(codigoZona), 
);

CREATE TABLE Necessitado(
    id INTEGER REFERENCES Pessoa(id),
    rendimento INTEGER,
    CONSTRAINT rendimento_positivo CHECK(rendimento > 0),
);

CREATE TABLE Voluntario(
    id INTEGER REFERENCES Pessoa(id),
    abrigo INTEGER REFERENCES Abrigo(id),
    CONSTRAINT pk_key PRIMARY KEY (id),
);

CREATE TABLE Orientador(
    id INTEGER REFERENCES Pessoa(id),
    horarioInicio INTEGER, 
    horarioFim INTEGER,
    CONSTRAINT pk_key PRIMARY KEY (id),
    CONSTRAINT horasDiariasObrigatorias CHECK(horarioInicio < horarioFim),
);

CREATE TABLE Administrador(
    id INTEGER REFERENCES Pessoa(id),
    horarioInicio DATE, 
    horarioFim DATE,
    numeroEscritorio INTEGER,
    CONSTRAINT pk_key PRIMARY KEY (id),
    CONSTRAINT horasDiariasObrigatorias CHECK(horarioInicio < horarioFim),
    --- horas derivadas 
);

CREATE TABLE DoacaoMaterial(
    id INTEGER PRIMARY KEY, 
    idPessoa INTEGER REFERENCES Pessoa(id), 
    dataDoacao DATE,
);

CREATE TABLE DoacaoMonetaria(
    id INTEGER PRIMARY KEY, 
    pessoa INTEGER REFERENCES Pessoa(id), 
    dataDoacao DATE, 
    valor INTEGER,
    frequencia INTEGER,
    CONSTRAINT limiteMonetario CHECK(0 < valor and valor <=500), 
    CONSTRAINT frequenciaPositiva CHECK(frequencia >= 0),
);

CREATE TABLE Apoio(
    id INTEGER PRIMARY KEY, 
    dataInicio DATE, 
    dataFim DATE,
    pedidoApoio INTEGER REFERENCES PedidoApoio(id), 
    orientador INTEGER REFERENCES Orientador(id),
    CONSTRAINT dataCoerente CHECK(dataInicio < dataFim),
);


CREATE TABLE ApoioMonetario(
    id INTEGER REFERENCES Apoio(id),
    valor INTEGER,
    CONSTRAINT pk_key PRIMARY KEY (id),
    CONSTRAINT valorPositivo CHECK(valor > 0),
    ---valor deve ser suportado por fundos doacoes -a apoios
);

CREATE TABLE ApoioAlojamento(
    id INTEGER REFERENCES Apoio(id),
    abrigo INTEGER REFERENCES Abrigo(id),
    CONSTRAINT pk_key PRIMARY KEY (id),
);

CREATE TABLE ApoioMaterial(
    id INTEGER REFERENCES Apoio(id),
    CONSTRAINT pk_key PRIMARY KEY (id),
);

CREATE TABLE Produto(
    id INTEGER PRIMARY KEY, 
    nome VARCHAR(64), 
    codigo INTEGER UNIQUE, 
    dimensao INTEGER,
);

CREATE TABLE ProdutoHigiene(
    id REFERENCES Produto(id),
    genero VARCHAR(64),
);

CREATE TABLE ProdutoVestuário(
    id REFERENCES Produto(id),
    tamanho VARCHAR(2),
    ---ver se tamanho corresponde a uma das opcoes
);

CREATE TABLE ProdutoAlimentar(
    id REFERENCES Produto(id),
    dataValidade DATE,
    CONSTRAINT pk_key PRIMARY KEY (id),
    --- implementada na relacao CONSTRAINT validadeMinima CHECK(dataValidade >= )
);

CREATE TABLE TipoAlimentar(
    tipo VARCHAR(64) PRIMARY KEY,
);

CREATE TABLE TipoDoProdutoAlimentar(
    produto REFERENCES ProdutoAlimentar, 
    tipo REFERENCES TipoAlimentar,
    CONSTRAINT pk_key PRIMARY KEY (produto),
);

CREATE TABLE Localidade(
    codigoZona INTEGER PRIMARY KEY, 
    codigoPais INTEGER REFERENCES Pais(codigoPais),
    nome VARCHAR(64),
);

CREATE TABLE Pais(
    codigoPais INTEGER PRIMARY KEY, 
    nome VARCHAR(64),
);

CREATE TABLE PedidoApoio(
    id INTEGER PRIMARY KEY, 
    justificaco TEXT,
    tipo VARCHAR(64),
    prioridade INTEGER,
    administrador INTEGER REFERENCES Administrador(id),
    CONSTRAINT limitesPrioridade CHECK( prioridade >= 0 and prioridade <= 10),
);

CREATE TABLE Abrigo(
    id INTEGER PRIMARY KEY,
    morada VARCHAR(255),
    numeroCamas INTEGER,
    CONSTRAINT numeroCamasPositivo CHECK(numeroCamas > 0),
    ---numero de camas restantes 
    ---CONSTRAINT numeroCamasRestantesCoerente CHECK(numeroCamas >= numeroCamasRestantes)
);

CREATE TABLE LocalizacaoAbrigo(
    codigoZona INTEGER PRIMARY KEY, 
    abrigo INTEGER Abrigo(id),
);

CREATE TABLE DoacaoMaterialContemProduto(
    doacao INTEGER REFERENCES DoacaoMaterial(id), 
    produto INTEGER REFERENCES Produto(id),
    CONSTRAINT pk_key PRIMARY KEY (doacao, produto),
    --- CONSTRAINT validadeMinima CHECK(produto.dataValidade >= doacao.dataDoacao + 1 mes )
);

CREATE TABLE ApoioMaterialIncluiProduto(
    produto INTEGER REFERENCES Produto(id), 
    apoio INTEGER REFERENCES Apoio(id),
    CONSTRAINT pk_key PRIMARY KEY (produto, apoio),
);

CREATE TABLE VoluntarioParticipaApoio(
    voluntario INTEGER REFERENCES Voluntario(id), 
    apoio INTEGER REFERENCES Apoio(id),
    CONSTRAINT pk_key PRIMARY KEY (voluntario, apoio),
);

CREATE TABLE PessoaContribuiDoacaoMaterial(
    doacaoMaterial INTEGER REFERENCES DoacaoMaterial(id),
    pessoa INTEGER REFERENCES Pessoa(id),
    CONSTRAINT pk_key PRIMARY KEY (doacaoMaterial),
);

