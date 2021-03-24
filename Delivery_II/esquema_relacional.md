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


- [Pessoa(<u>pessoa_id</u>,primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada, codigoZona->Localidade)]

- Necessitado(<u>pessoa_id</u>->Pessoa.pessoa_id, rendimento)

- Voluntario(<u>pessoa_id</u>->Pessoa.pessoa_id)
<br>

- Trabalhador(<u>pessoa_id</u>->Pessoa.pessoa_id,  horarioInicio, horarioFim, /horasDiarias)
- mudar para OO possivelmente
- Orientador(<u>pessoa_id</u>->Trabalhador.pessoa_id)

- Administrador(<u>pessoa_id</u>->Trabalhador.pessoa_id, numeroEscritorio)


### Ações

- [Doacao(<u>id_doacao</u>, data)]
- DoacaoMaterial(<u>id_doacao</u>->Doacao.id_doacao)
- DoacaoMonetaria(<u>id_doacao</u>->Doacao.id_doacao, valor, frequencia)
<br>
- [Apoio(<u>apoio_id</u>, dataInicio, dataFim, pedidoApoio_id->PedidoApoio, pessoa_id->Orientador.pessoa_id)]
- colocar UNIQUE
- ApoioMonetario(<u>apoio_id</u>->Apoio.apoio_id, valor)
- ApoioAlojamento(<u>apoio_id</u>->Apoio.apoio_id,abrigo_id->Abrigo)
- colocar NOTNULL
- ApoioMaterial(<u>apoio_id</u>->Apoio.apoio_id)


### Produtos

- Produto(<u>produto_id</u>, nome, codigo, dimensao)
- ProdutoHigiene(<u>produto_id</u>->Produto.produto_id, genero)
- ProdutoVestuário(<u>produto_id</u>->Produto.produto_id, tamanho)
- ProdutoAlimentar(<u>produto_id</u>->Produto.produto_id, dataValidade)
<br>
- TipoAlimentar(<u>tipo</u>)
- TipoDoProdutoAlimentar(<u>produto_id</u>->ProdutoAlimentar.produto_id, tipo->TipoAlimentar)


## Classes individuais

- Localidade(<u>codigoZona</u>, nome)
- Pais(<u>codigoPais</u>, nome)
- PedidoApoio(<u>pedidoApoio_id</u>, justificacao, tipo, prioridade, pessoa_id->Administrador.pessoa_id)
- Abrigo(<u>abrigo_id</u>, morada, numeroCamas, /numeroCamasRestantes)
- LocalidadeEmPais(<u>codigoZona</u>->Localidade, codigoPais->Pais)
- AbrigoLocalizaSe(<u>codigoZona</u>->Localidade, abrigo_id->Abrigo)



## Outras Relacoes

- PessoaContribuiDoacao(<u>doacao_id</u>->Doacao, pessoa_id->Pessoa)
- DoacaoMaterialContemProduto(<u>doacao_id</u>->Doacao, <u>produto_id</u>->Produto)
- ProdutoIncluiApoioMaterial(<u>apoio_id</u>->Apoio, <u>produto_id</u>->Produto)
<br>
- VoluntarioAjudaAbrigo(<u>voluntario_id</u>->Voluntario, abrigo_id->Abrigo)
- VoluntarioParticipaApoio(<u>voluntario_id</u>->Voluntario, <u>apoio_id</u>->Apoio)
