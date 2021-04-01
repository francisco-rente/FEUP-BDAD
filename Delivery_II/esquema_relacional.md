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
- Orientador(<u>id</u>->Pessoa.id,  horaInicio , horaFim )
- Administrador(<u>id</u>->Pessoa.id,  horaInicio , horaFim , numeroEscritorio)


### Ações
- DoacaoMaterial(<u>id</u>, pessoa->Pessoa->id, data)
- DoacaoMonetaria(<u>id</u>, pessoa->Pessoa->id, data, valor, frequencia)
- [Apoio(<u>id</u>, dataInicio, dataFim, pedidoApoio->PedidoApoio.id, orientador->Orientador.id)]
- ApoioMonetario(<u>id</u>->Apoio.id, valor)
- ApoioAlojamento(<u>id</u>->Apoio.id,abrigo->Abrigo.id)
- ApoioMaterial(<u>id</u>->Apoio.id)


### Produtos
- E/R
  - Produto(<u>id</u>, nome, codigo, dimensao)
  - ProdutoHigiene(<u>id</u>->Produto.id, genero)
  - ProdutoVestuário(<u>id</u>->Produto.id, tamanho)
  - ProdutoAlimentar(<u>id</u>->Produto.id, dataValidade, tipo->TipoAlimentar.id)
- TipoAlimentar(<u>id</u>, tipo)

## Classes individuais
- Localidade(<u>codigoZona</u>, codigoPais->Pais.codigoPais, nome)
- Pais(<u>codigoPais</u>, nome)
- PedidoApoio(<u>id</u>, justificacao, tipo, prioridade, avaliador->Administrador.id, pedinte->Necessitado.id)
- Abrigo(<u>id</u>, morada, numeroCamas, codigoZona->Localidade.codigoZona)


## Outras Relacoes
- DoacaoMaterialContemProduto(<u>doacao</u>->DoacaoMaterial.id, <u>produto</u>->Produto.id)
- ProdutoIncluiApoioMaterial(<u>apoio</u>->Apoio.id, <u>produto</u>->Produto.id)
- VoluntarioParticipaApoio(<u>voluntario </u>->Voluntario.id, <u>apoio</u>->Apoio.id)


