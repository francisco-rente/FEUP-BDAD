# Modelo relacional ONG

## Dúvidas
<ul>
<li>Verificar se id's precisam de ser diferente nas classes herdadas;</li>
<li>Comparar OO com estilo E/R;</li>
<li>Verificar se constraints (NOT NULL) precisam de estar presentes;</li>
<li>Tipo de produto->enum??</li>
<li>Usar código do produto como primária para todos os produtos? É possível um incremento/rowid global a 3 tabelas? </li>
<li>Nomes mais descritivos nas relações?</li>
<li>Como representar os cálculos derivados?</li>
<li>Que informação incluir na avaliação de um pedido por um dado admin?</li>
<li>O que fazer nos casos em que existe uma relação com a classe mãe, se escolhermos OO simplificado? EX: contribuição de doação??</li>
<li>É necessário uma relação à parte para todas as relações 1-*? Ou chaves estrangeiras bastariam? </li>
<li>O que fazer nos casos das relações 1..* -- * ou *--0..1, existe alguma relação que inclua a possibilidade de não ser nulo, ou é apenas uma constraint? Ver slide 9 da aula</li>
</ul>

## Classes de herança

### Staff
- [Pessoa(<ins>pessoa_id</ins>,primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada)]

- Necessitado(<ins>necessitado_id</ins>, primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada, rendimento)

- Voluntario(<ins>voluntario_id</ins>,primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada)
  
- Trabalhador(<ins>trabalhador_id</ins>, primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada, horarioInicio, horarioFim, /horasDiarias)
  
- Orientador(<ins>orientador_id</ins>,primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada, horarioInicio, horarioFim, /horasDiarias))

- Administrador(<ins>administrador_id</ins>,primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada,, horarioInicio, horarioFim, /horasDiarias, numeroEscritorio)


### Ações

- [Doacao(<ins>id_doacao</ins>, data)]
- DoacaoMaterial(<ins>id_doacaoMaterial</ins>, data)
- DoacaoMonetaria(<ins>id_doacaoMonetaria</ins>, data, valor, frequencia)
- [Apoio(<ins>apoio_id</ins>, dataInicio, dataFim, pedidoApoio_id->PedidoApoio)]
  - !!!ver se relação com PedidoApoio fica melhor aqui, não esquecer colocar UNIQUE
- ApoioMonetario(<ins>apoioMonetario_id</ins>, dataInicio, dataFim, valor, pedidoApoio_id->PedidoApoio)
- ApoioAlojamento(<ins>apoioAlojamento_id</ins>, dataInicio, dataFim, pedidoApoio_id->PedidoApoio)
- ApoioMaterial(<ins>apoioMaterial_id</ins>, dataInicio, dataFim, pedidoApoio_id->PedidoApoio)

### Produtos
- Produto(<ins>produto_id</ins>, nome, codigo, dimensao)
- ProdutoHigiene(<ins>produtoHigiene_id</ins>, nome, codigo, dimensao, genero)
- ProdutoVestuário(<ins>produtoAlimentar_id</ins>, nome, codigo, dimensao, dataValidade)
- ProdutoAlimentar(<ins>produtoVestuario_id</ins>, nome, codigo, dimensao, tamanho)
- TipoAlimentar(<ins>tipo</ins>)
- TipoDoProdutoAlimentar(<ins>produtoAlimentar_id </ins>->ProdutoAlimentar, tipo->TipoAlimentar)


## Classes individuais

- Localidade(<ins>codigoZona</ins>, nome)
- Pais(<ins>codigoPais</ins>, nome)
- PedidoApoio(<ins>pedidoApoio_id</ins>, justificacao, tipo, prioridade)
- Abrigo(<ins>abrigo_id</ins>, morada, numeroCamas, /numeroCamasRestantes)
- LocalidadeEmPais(<ins>codigoZona</ins>->Localidade, codigoPais->Pais)
- AbrigoLocalizaSe(<ins>codigoZona</ins>->Localidade, abrigo_id->Abrigo)

## Outras Relacoes
- PessoaContribuiDoacao(<ins>doacao_id</ins>->Doacao, pessoa_id->Pessoa)
- DoacaoMaterialContemProduto(<ins>doacao_id</ins>->Doacao, <ins>produto_id</ins>->Produto)
- ProdutoIncluiApoioMaterial(<ins>apoio_id</ins>->Apoio, <ins>produto_id</ins>->Produto)
- ApoioAlojamentoForneceAbrigo(<ins>apoioAlojamento_id</ins>->ApoioAlojamento, abrigo_id->Abrigo)
- VoluntarioAjudaAbrigo(<ins>voluntario_id</ins>->Voluntario, abrigo_id->Abrigo)
- VoluntarioParticipaApoio(<ins>voluntario_id</ins>->Voluntario, <ins>apoio_id</ins>->Apoio)
- OrientadorCoordenaApoio(<ins>apoio_id</ins>->Apoio, orientador_id->Orientador )
- AdministradorAvaliaPedidoApoio(<ins>pedidoApoio_id</ins>->PedidoApoio, administrador_id->Administrador)
- PessoaResideEm(<ins>pessoa_id</ins>->Pessoa, codigoZona->Localidade)

