# Modelo relacional ONG

## Dúvidas

- Verificar se constraints (NOT NULL) precisam de estar presentes;
- Tipo de produto->enum??
- Usar código do produto como primária para todos os produtos?
- Como representar os cálculos derivados?
- De que forma se representa Trabalhador? OO ou prossegue-se o E/R anterior na hierarquia
- Vale a pena ter tantas relações para Voluntário?
- Problema da cascata com E/R? CHECK
- Admin/PedidoApoio (unidirecional) de que forma conseguimos perceber que pedidos aprovados tiveram uma dada justificação
(agora temos pedido aprovado através de apoio)? CHECK
- MESMO PROBLEMA: que voluntário apoia um dado abrigo. CHECK
- FD e formas normais.
- FD de entre tabelas derivadas (herdadas) EX: NIF->horarioTrabalhador? NAO 
- Chave Foreign pode ser NULL.

## Possíveis dependências funcionais
- justificao -> prioridade
- NIF -> TUDO
- codigoProduto -> nome, dimensao
- codigoProduto -> ?DataValidade, genero, tamanho?
- Possivelmente trocar codigoProduto --> ProdutoId, de forma a codigo de produto levar a violações


## Classes de herança
### Staff

- [Pessoa(<u>id</u>,primeiroNome, ultimoNome, NIF, dataNascimento, numeroTelefone, morada, codigoZona->Localidade)]
- Necessitado(<u>id</u>->Pessoa.id, rendimento)
- Voluntario(<u>id</u>->Pessoa.id, id->Abrigo.id)
- Orientador(<u>id</u>->Pessoa.id,  horarioInicio, horarioFim)
- Administrador(<u>id</u>->Pessoa.id,  horarioInicio, horarioFim, numeroEscritorio)


### Ações
- DoacaoMaterial(<u>id</u>, id->Pessoa->id, data)
- DoacaoMonetaria(<u>id</u>, id->Pessoa->id, data, valor, frequencia)
- [Apoio(<u>apoio_id</u>, dataInicio, dataFim, id->PedidoApoio.id, id->Orientador.id)]
    - colocar UNIQUE
- ApoioMonetario(<u>id</u>->Apoio.id, valor)
- ApoioAlojamento(<u>id</u>->Apoio.id,id->Abrigo.id)
    - colocar NOTNULL
- ApoioMaterial(<u>id</u>->Apoio.id)


### Produtos
- E/R
  - Produto(<u>id</u>, nome, codigo, dimensao)
  - ProdutoHigiene(<u>id</u>->Produto.id, genero)
  - ProdutoVestuário(<u>id</u>->Produto.id, tamanho)
  - ProdutoAlimentar(<u>id</u>->Produto.id, dataValidade)
- NULLS
  - Produto(<u>id</u>, nome, codigo, dimensao, genero, tamanho, dataValidade)
- TipoAlimentar(<u>tipo</u>)
- TipoDoProdutoAlimentar(<u>id</u>->ProdutoAlimentar.id, tipo->TipoAlimentar)

## Classes individuais
- Localidade(<u>codigoZona</u>, nome)
- Pais(<u>codigoPais</u>, nome)
- PedidoApoio(<u>id</u>, justificacao, tipo, prioridade, id->Administrador.id)
- Abrigo(<u>id</u>, morada, numeroCamas)
<!---- LocalidadeEmPais(<u>codigoZona</u>->Localidade, codigoPais->Pais)-->
- AbrigoLocalizaSe(<u>codigoZona</u>->Localidade, abrigo_id->Abrigo)

## Outras Relacoes
- DoacaoMaterialContemProduto(<u>id</u>->DoacaoMaterial.id, <u>produto_id</u>->Produto)
- ProdutoIncluiApoioMaterial(<u>id</u>->Apoio.id, <u>id</u>->Produto.id)
- VoluntarioParticipaApoio(<u>id</u>->Voluntario.id, <u>id</u>->Apoio.id)
<!--- PessoaContribuiDoacaoMonetaria(<u>id</u>->DoacaoMonetaria.id, pessoa_id->Pessoa)
- PessoaContribuiDoacaoMaterial(<u>id</u>->DoacaoMaterial.id, pessoa_id->Pessoa)-->
<!--- VoluntarioAjudaAbrigo(<u>voluntario_id</u>->Voluntario, abrigo_id->Abrigo)-->

