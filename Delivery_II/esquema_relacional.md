# Modelo relacional ONG

## Dúvidas

- Verificar se constraints (NOT NULL) precisam de estar presentes;
- Tipo de produto->enum??
- Usar código do produto como primária para todos os produtos?
- Nomes mais descritivos nas relações?
- Como representar os cálculos derivados?
- Que informação incluir na avaliação de um pedido por um dado admin?
- De que forma se representa Trabalhador? OO ou prossegue-se o E/R anterior na hierarquia
- Vale a pena ter tantas relações para Voluntário?
- Problema da cascata com E/R


## Classes de herança

### Staff


- [Pessoa(<ins>pessoa_id</ins>,primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada, codigoZona->Localidade)]

- Necessitado(<ins>pessoa_id</ins>->Pessoa.pessoa_id, rendimento)

- Voluntario(<ins>pessoa_id</ins>->Pessoa.pessoa_id)
<br>

- Trabalhador(<ins>pessoa_id</ins>->Pessoa.pessoa_id,  horarioInicio, horarioFim, /horasDiarias)
- mudar para OO possivelmente
- Orientador(<ins>pessoa_id</ins>->Trabalhador.pessoa_id)

- Administrador(<ins>pessoa_id</ins>->Trabalhador.pessoa_id, numeroEscritorio)


### Ações

- [Doacao(<ins>id_doacao</ins>, data)]
- DoacaoMaterial(<ins>id_doacao</ins>->Doacao.id_doacao)
- DoacaoMonetaria(<ins>id_doacao</ins>->Doacao.id_doacao, valor, frequencia)
<br>
- [Apoio(<ins>apoio_id</ins>, dataInicio, dataFim, pedidoApoio_id->PedidoApoio, pessoa_id->Orientador.pessoa_id)]
- colocar UNIQUE
- ApoioMonetario(<ins>apoio_id</ins>->Apoio.apoio_id, valor)
- ApoioAlojamento(<ins>apoio_id</ins>->Apoio.apoio_id,abrigo_id->Abrigo)
- colocar NOTNULL
- ApoioMaterial(<ins>apoio_id</ins>->Apoio.apoio_id)


### Produtos

- Produto(<ins>produto_id</ins>, nome, codigo, dimensao)
- ProdutoHigiene(<ins>produto_id</ins>->Produto.produto_id, genero)
- ProdutoVestuário(<ins>produto_id</ins>->Produto.produto_id, tamanho)
- ProdutoAlimentar(<ins>produto_id</ins>->Produto.produto_id, dataValidade)
<br>
- TipoAlimentar(<ins>tipo</ins>)
- TipoDoProdutoAlimentar(<ins>produto_id</ins>->ProdutoAlimentar.produto_id, tipo->TipoAlimentar)


## Classes individuais

- Localidade(<ins>codigoZona</ins>, nome)
- Pais(<ins>codigoPais</ins>, nome)
- PedidoApoio(<ins>pedidoApoio_id</ins>, justificacao, tipo, prioridade, pessoa_id->Administrador.pessoa_id)
- Abrigo(<ins>abrigo_id</ins>, morada, numeroCamas, /numeroCamasRestantes)
- LocalidadeEmPais(<ins>codigoZona</ins>->Localidade, codigoPais->Pais)
- AbrigoLocalizaSe(<ins>codigoZona</ins>->Localidade, abrigo_id->Abrigo)



## Outras Relacoes

- PessoaContribuiDoacao(<ins>doacao_id</ins>->Doacao, pessoa_id->Pessoa)
- DoacaoMaterialContemProduto(<ins>doacao_id</ins>->Doacao, <ins>produto_id</ins>->Produto)
- ProdutoIncluiApoioMaterial(<ins>apoio_id</ins>->Apoio, <ins>produto_id</ins>->Produto)
<br>
- VoluntarioAjudaAbrigo(<ins>voluntario_id</ins>->Voluntario, abrigo_id->Abrigo)
- VoluntarioParticipaApoio(<ins>voluntario_id</ins>->Voluntario, <ins>apoio_id</ins>->Apoio)
