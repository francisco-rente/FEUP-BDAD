# Modelo relacional ONG

## Dúvidas
<ul>
<li>Verificar se constraints (NOT NULL) precisam de estar presentes;</li>
<li>Tipo de produto->enum??</li>
<li>Usar código do produto como primária para todos os produtos?</li>
<li>Nomes mais descritivos nas relações?</li>
<li>Como representar os cálculos derivados?</li>
<li>Que informação incluir na avaliação de um pedido por um dado admin?</li>
<li>De que forma se representa Trabalhador? OO ou prossegue-se o E/R anterior na hierarquia</li>
<li>Vale a pena ter tantas relações para Voluntário?</li>
<li>Problema da cascata com E/R</li>
</ul>

## Classes de herança

### Staff

<ul>
<li>[Pessoa(<ins>pessoa_id</ins>,primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada, codigoZona->Localidade)]</li>

<li>Necessitado(<ins>pessoa_id</ins>->Pessoa.pessoa_id, rendimento)</li>

<li>Voluntario(<ins>pessoa_id</ins>->Pessoa.pessoa_id)</li>
<br>

<li>Trabalhador(<ins>pessoa_id</ins>->Pessoa.pessoa_id,  horarioInicio, horarioFim, /horasDiarias)</li>
<ul><li>mudar para OO possivelmente</li></ul>
<li>Orientador(<ins>pessoa_id</ins>->Trabalhador.pessoa_id)</li>

<li>Administrador(<ins>pessoa_id</ins>->Trabalhador.pessoa_id, numeroEscritorio)</li>
</ul>

### Ações
<ul>
<li>[Doacao(<ins>id_doacao</ins>, data)]</li>
<li>DoacaoMaterial(<ins>id_doacao</ins>->Doacao.id_doacao)</li>
<li>DoacaoMonetaria(<ins>id_doacao</ins>->Doacao.id_doacao, valor, frequencia)</li>
<br>
<li>[Apoio(<ins>apoio_id</ins>, dataInicio, dataFim, pedidoApoio_id->PedidoApoio, pessoa_id->Orientador.pessoa_id)]</li>
<ul><li>colocar UNIQUE</li></ul>
<li>ApoioMonetario(<ins>apoio_id</ins>->Apoio.apoio_id, valor)</li>
<li>ApoioAlojamento(<ins>apoio_id</ins>->Apoio.apoio_id,abrigo_id->Abrigo)</li>
<ul><li>colocar NOTNULL</li></ul>
<li>ApoioMaterial(<ins>apoio_id</ins>->Apoio.apoio_id)</li>
</ul>

### Produtos
<ul>
<li>Produto(<ins>produto_id</ins>, nome, codigo, dimensao)</li>
<li>ProdutoHigiene(<ins>produto_id</ins>->Produto.produto_id, genero)</li>
<li>ProdutoVestuário(<ins>produto_id</ins>->Produto.produto_id, tamanho)</li>
<li>ProdutoAlimentar(<ins>produto_id</ins>->Produto.produto_id, dataValidade)</li>
<br>
<li>TipoAlimentar(<ins>tipo</ins>)</li>
<li>TipoDoProdutoAlimentar(<ins>produto_id</ins>->ProdutoAlimentar.produto_id, tipo->TipoAlimentar)</li>
</ul>

## Classes individuais
<ul>
<li>Localidade(<ins>codigoZona</ins>, nome)</li>
<li>Pais(<ins>codigoPais</ins>, nome)</li>
<li>PedidoApoio(<ins>pedidoApoio_id</ins>, justificacao, tipo, prioridade, pessoa_id->Administrador.pessoa_id)</li>
<li>Abrigo(<ins>abrigo_id</ins>, morada, numeroCamas, /numeroCamasRestantes)</li>
<li>LocalidadeEmPais(<ins>codigoZona</ins>->Localidade, codigoPais->Pais)</li>
<li>AbrigoLocalizaSe(<ins>codigoZona</ins>->Localidade, abrigo_id->Abrigo)</li>
</ul>


## Outras Relacoes
<ul>
<li>PessoaContribuiDoacao(<ins>doacao_id</ins>->Doacao, pessoa_id->Pessoa)</li>
<li>DoacaoMaterialContemProduto(<ins>doacao_id</ins>->Doacao, <ins>produto_id</ins>->Produto)</li>
<li>ProdutoIncluiApoioMaterial(<ins>apoio_id</ins>->Apoio, <ins>produto_id</ins>->Produto)</li>
<br>
<li>VoluntarioAjudaAbrigo(<ins>voluntario_id</ins>->Voluntario, abrigo_id->Abrigo)</li>
<li>VoluntarioParticipaApoio(<ins>voluntario_id</ins>->Voluntario, <ins>apoio_id</ins>->Apoio)</li>
