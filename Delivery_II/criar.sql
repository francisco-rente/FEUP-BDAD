---drop every table that could previously exist
DROP TABLE IF EXISTS Pessoa 
DROP TABLE IF EXISTS Necessitado 
DROP TABLE IF EXISTS Voluntario 
DROP TABLE IF EXISTS Orientador 
DROP TABLE IF EXISTS Administrador 
DROP TABLE IF EXISTS DoacaoMaterial 
DROP TABLE IF EXISTS DoacaoMonetaria 
DROP TABLE IF EXISTS Apoio 
DROP TABLE IF EXISTS ApoioMonetario 
DROP TABLE IF EXISTS ApoioAlojamento 
DROP TABLE IF EXISTS ApoioMaterial 
DROP TABLE IF EXISTS Produto 
DROP TABLE IF EXISTS ProdutoHigiene 
DROP TABLE IF EXISTS ProdutoVestuario 
DROP TABLE IF EXISTS ProdutoAlimentar 
DROP TABLE IF EXISTS TipoAlimentar 
DROP TABLE IF EXISTS Localidade 
DROP TABLE IF EXISTS Pais 
DROP TABLE IF EXISTS PedidoApoio 
DROP TABLE IF EXISTS Abrigo 
DROP TABLE IF EXISTS LocalizacaoAbrigo 
DROP TABLE IF EXISTS DoacaoMaterialContemProduto 
DROP TABLE IF EXISTS ApoioMaterialIncluiProduto 
DROP TABLE IF EXISTS VoluntarioParticipaApoio 
DROP TABLE IF EXISTS PessoaContribuiDoacaoMaterial 


--define tables
CREATE TABLE Pessoa(
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
    rendimento REAL,
    CONSTRAINT rendimento_positivo CHECK(rendimento >= 0),
    CONSTRAINT rendimento_nao_aceitavel CHECK(rendimento < 665),
    PRIMARY KEY (id),
    --- perguntar se a limitacao e feita agora ou com triggers
);

CREATE TABLE Voluntario(
    id INTEGER REFERENCES Pessoa(id),
    abrigo INTEGER REFERENCES Abrigo(id),
    PRIMARY KEY (id),
);

CREATE TABLE Orientador(
    id INTEGER REFERENCES Pessoa(id),
    horarioInicio INTEGER, 
    horarioFim INTEGER,
    PRIMARY KEY (id),
    CONSTRAINT horasDiariasObrigatorias CHECK(horarioInicio < horarioFim),
);

CREATE TABLE Administrador(
    id INTEGER REFERENCES Pessoa(id),
    horarioInicio INTEGER, 
    horarioFim INTEGER,
    numeroEscritorio INTEGER,
    PRIMARY KEY (id),
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
    PRIMARY KEY (id),
    CONSTRAINT valorPositivo CHECK(valor > 0),
    ---valor deve ser suportado por fundos doacoes - apoios-->triggers
);

CREATE TABLE ApoioAlojamento(
    id INTEGER REFERENCES Apoio(id),
    abrigo INTEGER REFERENCES Abrigo(id),
    PRIMARY KEY (id),
);

CREATE TABLE ApoioMaterial(
    id INTEGER REFERENCES Apoio(id),
    PRIMARY KEY (id),
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
    PRIMARY KEY (id),
);

CREATE TABLE ProdutoVestuario(
    id REFERENCES Produto(id),
    tamanho VARCHAR(2),
    PRIMARY KEY (id),
    ---ver se tamanho corresponde a uma das opcoes
    CONSTRAINT tamanhoExistente CHECK(tamanho == 'XS' or tamanho == 'S' or tamanho == 'M' or tamanho == 'XL' or tamanho == 'XXL'),
);

CREATE TABLE ProdutoAlimentar(
    id REFERENCES Produto(id),
    dataValidade DATE,
    tipo VARCHAR(64) REFERENCES TipoAlimentar.tipo,
    PRIMARY KEY (id),
);

CREATE TABLE TipoAlimentar(
    tipo VARCHAR(64) PRIMARY KEY,
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
    justificacao TEXT,
    tipo VARCHAR(64),
    prioridade INTEGER,
    administrador INTEGER REFERENCES Administrador(id),
    CONSTRAINT limitesPrioridade CHECK( prioridade >= 0 and prioridade <= 10),
);

CREATE TABLE Abrigo(
    id INTEGER PRIMARY KEY,
    morada VARCHAR(255),
    numeroCamas INTEGER,
    codigoZona INTEGER REFERENCES Localidade(codigoZona),
    CONSTRAINT numeroCamasPositivo CHECK(numeroCamas > 0),
);


CREATE TABLE DoacaoMaterialContemProduto(
    doacao INTEGER REFERENCES DoacaoMaterial(id), 
    produto INTEGER REFERENCES Produto(id),
    PRIMARY KEY (doacao, produto),
);

CREATE TABLE ApoioMaterialIncluiProduto(
    produto INTEGER REFERENCES Produto(id), 
    apoio INTEGER REFERENCES Apoio(id),
    PRIMARY KEY (produto, apoio),
);

CREATE TABLE VoluntarioParticipaApoio(
    voluntario INTEGER REFERENCES Voluntario(id), 
    apoio INTEGER REFERENCES Apoio(id),
    PRIMARY KEY (voluntario, apoio),
);

CREATE TABLE PessoaContribuiDoacaoMaterial(
    doacaoMaterial INTEGER REFERENCES DoacaoMaterial(id),
    pessoa INTEGER REFERENCES Pessoa(id),
    PRIMARY KEY (doacaoMaterial),
);


--considerations
--atributos derivados: numeroDeCamasRestantes, horas de trabalho 
--triggers:
-- triggers CONSTRAINT validadeMinima CHECK(produto.dataValidade >= doacao.dataDoacao + 1 mes ) at DoacaoMaterialContemProduto
---triggers CONSTRAINT numeroCamasRestantesCoerente CHECK(numeroCamas >= numeroCamasRestantes) at Abrigo 
