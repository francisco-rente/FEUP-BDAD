# BDAD - Delivery III

## Possíveis Interrogações

### Listar pedidos de apoio

- Prioridade máxima;
- Agrupar por prioridade;
- Agrupar por justificação;
- Agrupar por tipo;
- Agrupar por necessitado:
    - Idade (crianças, idosos);
    - Morada (conjunto de pessoas com mesma morada na mesma zona -> Família);

### Listar trabalhadores

- Disponíveis para um dado horário;
- Residentes numa certa zona (para participar em apoios dessa zona);
- Conhecidos de um necessitado (por já terem coordenado algum dos seus apoios);

### Estatísticas relativas a doações

- Obter fluxo esperado num dado intervalo de tempo (baseado nas datas e
  periodicidade das doações regulares);
- Avaliar relação entre a altura do ano (mês/estação/semestre) e o valor
  recolhido;
- Identificar dadores mais importantes:
    - Maior frequência de doações;
    - Maior valor doado;
      > PROFESSORA: Sem usar LIMIT ou MAX
    - Doação em todos os meses de um ano;
    - Doação de todos os tipos de produto;

### Exequibilidade atual

- Quantos/Que pedidos de apoio podem ser satisfeitos atualmente para:
    - Alojamento: comparação com a totalidade de camas disponíveis);
    - Monetário: comparação entre o saldo `doações - apoios` existentes e o que
      o necessitado pede (
      assumir `800 - rendimento`);

### Condições mais adequadas para alojamento

- Abrigo mais adequado para um determinado pedido de apoio baseado em:
    - Proximidade à sua residência (comparar códigos de zona);
    - Média de idades dos residentes ser próxima;
    - Possíveis residentes serem conhecidos por:
        - Já terem estado com essa pessoa num abrigo;
        - Terem a mesma nacionalidade;

### Estatísticas sobre necessitados

- Mais dificuldades (maior número de pedidos de apoio);
- Reversão de papéis (já doaram)
- Médias:
    - Idade
    - Rendimento
- Amizades: pares de necessitados que já tenham estado juntos em pelo menos um
  abrigo

## Possíveis gatilhos

- Garantir estatuto de carenciado:
    - Impedir pedidos de apoio de necessitados com rendimento superior a 800€
    - Impedir que o mesmo necessitado tenha mais do que 5 pedidos de apoio
      pendentes (sem um apoio atribuído)

- Garantir sustentabilidade de recursos:
    - Dinheiro suficiente para apoios monetários
    - Produtos suficientes para apoios materiais
    - Vagas suficientes para apoios de alojamento
    - Remover produtos cuja data de validade tenha expirado

- Garantir bem-estar dos colaboradores:
    - Impedir que sejam atribuídos demasiados pedidos ao mesmo orientador para
      não o sobrecarregar
    - Impedir que sejam atribuídos horários demasiado longos a trabalhadores
      mais velhos

--- 

## Interrogações

1. Objetivo: Listar todos os pedidos de apoio pendentes, ordenados por tipo de forma crescente e por prioridade decrescente.


  Método: Selecionar todos os ids da tabela PedidoApoio que não estejam listados na coluna pedido da tabela Apoio.


2. Objetivo: Para evitar separar famílias, deve ser possível listar as famílias que pediram alojamento para que sejam colocadas no mesmo abrigo. Assim, os pedidos de alojamento devem ser agrupados por morada + localidade. 

  Método: Selecionar colunas de interesse como o nome e localização (através de um _inner join_ ) de uma pessoa cujo id seja reconhecido na coluna pedinte de um pedido de apoio cuja justificação seja _Alojamento_.
   ```SELECT...```


3. Objetivo: Listar os números de telefone de todos os dadores que tenham "falhado" a sua doação planeada para poderem ser contactados/relembrados, isto é, nos casos em que o prazo definido pela frequência da sua doação mais recente já tenha vencido.

  Método: Reúnem-se colunas importantes como o nome do dador em causa, o seu telefone e localização. Estes dados obtém-se através da geração de uma tabela que argupa para cada pessoa a última doação válida e a frequência que o dador se comprometeu a cumprir. Por fim, selecionam-se todas as pesoas cuja data da última doação  + os dias de frequência ultrapassem a data atual. A comparação de datas é realizada com a função JULIANDAY.

   ```SELECT...```


4. Objetivo: Para cada pedido de apoio de alojamento que ainda não tenha sido atribuído, escolher um abrigo mais apropriado para cada necessitado. Como critério de adequação é utilizado a distância da localidade da pessoa até às instalações (como métrica é utilizada a diferença entre códigos de zona).

  Método: selecionar os atributos correspondentes a cada pessoa (_GROUP BY_), nomeadamente o nome e o código de zona, bem como o código de zona de cada abrigo e garantir que é selecionado o tuplo que contém a distância mínima entre códigos. Toda esta informação é agregada através da junção das tabelas pedido de apoio com pessoa (em função do id do Necessitado) e Abrigo, sendo apenas contabilizados os pedidos que não existem no _JOIN_ das tabelas PedidoApoio e Apoio (os pedidos ainda não atribuídos). 

```SELECT...```


5. Objetivo: Para cada abrigo, calcular um conjunto de estatísticas relevantes sobre os seus habitantes: média de idades, média de rendimentos, nacionalidade mais comum e justificação mais comum para requerer asilo. 


  Método: um _SELECT_ geral permite recolher a informação angariada. Uma outra seleção agrupa informação encontrada de 3 formas diferentes e realiza um _GROUP BY_ por id de Abrigo:


  - A justificação mais comum (infoJustificacoes), escolhida a partir da junção entre as tabelas Apoio (apenas para apoios ativos), ApoioAlojamento e PedidoApoio, agrupadas por Abrigo e justifcação. Sendo assim cada par [abrigo, justificação], terá também uma contagem do número de ocorrências, permitindo que o _SELECT_ precedente realize uma filtragem pelo máximo.
  - O mesmo se aplica à seleção do país mais comum (infoNacionalidades) . A quantidade _JOIN_ necessários é maior, dado que é preciso recuperar informação desde abrigo até à localidade da pessoa/necessitado em questão.
  - Os cálculos estatísticos (infoNecessitados) a avaliar são incluídos num só _SELECT_: a média de rendimentos e a média de idades aplicam a função _AVG_ às colunas retiradas do conjunto de _INNER JOIN_ que mais uma vez necessitam de interligar as tabelas Abrigo até Pessoa, passando por todas as intermédias, agrupando os resultdaso por abrigo.
  Todas estas tabelas são reunidas com Abrigo (com o id em comum dos resultados) e por fim são dispostas as colunas com os cálculos. 
   ```SELECT...```


6. Objetivo: A organização poderá querer premiar/agradecer às pessoas que mais contribuiram para a organização. Para tal, seria conveniente ter não só a pessoa que mais dinheiro doou, bem como todas aquelas que contribuiram com todo o tipo de produtos.


  Método: 


  - Para o primeiro objetivo, reunimos todas as doações monetárias agrupadas por pessoa, tendo assim pares (id de Pessoa, total doado pela mesma). Basta realizar um JOIN entre o id do doador e pessoa, retirando apenas o tuplo que contém o maior dos valores doados.
  - Para a estatística de maior diversidade de produtos, seguimos um procedimento semelhante ao anterior e utilizando uma cláusula _HAVING_ para o _GROUP_ by, selecionamos as pessoas que cujas doações incluem todos os códigos de produtos disponíveis atualmente na plataforma).


```SELECT...```


7. Objetivo: Listar os pedidos de apoio pendentes que podem ser satisfeitos com os recursos existentes disponíveis à organização . Assim, as camas restantes
   devem ser comparadas com os pedidos de alojamento e o saldo monetário deve
   ser comparado com os pedidos de apoio monetários. 


   Método: Selecionar todos os tuplos da união duas tabelas:

   
   - A primeira compila todos os pedidos de alojamento que podem ser satisfeitos no momento, isto é, quando o número de camas disponíveis é suficiente para alojar mais pessoas. Este cálculo realiza-se através da diferença entre o total de camas(soma do coluna numeroCamas de cada abrigo) e número de camas ocupadas (todos os ApoioAlojamento atribuídos).
   - A segunda agrega, de uma maenira semelhante à descrita, todos os pedidos de apoio monetário que podem ser satisfeitos no momento, de forma a fazer corresponder o valor angariado pelo necessitado (apoio + rendimento) ao mínimo de 800 euros. O valor disponível calcula-se com a soma de todas as doações monetárias e os apoios monetários já realizados.

   ```SELECT...```


8. Objetivo: Tendo em conta a frequência e o valor da doação recorrente mais recente de
   cada cliente, estimar o fluxo de entrada esperado nos próximos X dias.


   Método: Arbitrar um valor para o intervalo pretendido (13 p.e.) e calcular o valor esperado das doações realizadas nesse intervalo de tempo. Selecionam-se todas as doações monetárias (com frequência definida), o seu valor, frequência e os dias até à próxima [(data da doação + frequencia) - data atual], mais tarde filtrando apenas aquelas que se enquadram no nosso intervalo. O total esperado é então a soma do produto entre o valor estimado (valor da última doação) e o arrendodamento da soma entre 1 doação efetiva e outras possíveis ocorrências para o intervalo de tempo considerado. 

   ```SELECT...```


9. Objetivo: Para cada pedido de apoio, listar os trabalhadores disponíveis mais
   adequados (contabilizar hora atual), considerando um trabalhador adequado
   sempre que habite numa zona próxima ou já tenha participado num apoio
   atribuído a esse necessitado (Aviso: este query é dependente da hora atual do sistema para a selação de candidatos).


   Método: Agrupar numa só tabela todas as pessoas que ainda têm um pedido de apoio por concretizar (não está incluído na coluna pedido de qualquer Apoio) e extrair as suas informações (como o código de zona). Nesta tabela também incluímos todos os orientadores disponíveis no horário atual (utilizando _STRFTIME_ e _BETWEEN_) cujo id já tenha sido incluído num Apoio fornecido ao necessitado em questão. Ficamos assim com uma tabela que parelha o Necessitado com os Orientadores apropriados. Finalmente, para cada pedido não correspondido escolhemos o o par (Necessitado, Orientador) que tem menor diferença entre códigos de zona.

   ```SELECT...```


10. Objetivo: Para que os funcionários possam obter uma visualização geral da organização, é importante obter dados anuais sobre o seu funcionamento. Uma tabela que sintetize diversas estatísticas como quantidade de apoios e dos seus tipos, prioridade média e o montante gasto por mês, adequa-se a esta finalidade. Se tal informação não estiver disponível é colocada como N/A.


Método: Criando uma tabela temporárias com os meses do ano é possível utilizar a instrução _LEFT JOIN_ para ter uma tabela organizada por meses, desde que todas as tabelas incluídas na operação os estejam. O cálculo de estatísticas é feita por blocos: o primeiro relativo aos Apoios, nomeadamente montantes gastos e média de prioridades (utilizando _LEFT OUTER JOIN_ para manter a consistência de dados), o segundo relativo às doações monetárias (montantes recebidos, valor agregado) e por fim outro bloco relacionado com as doações materiais.


```SELECT...```

## Gatilhos

1. Objetvo :De forma a garantir que o valor de cada apoio monetário é comportado pelo
   valor angariado pela totalidade das doações monetárias, é necessário
   verificar em cada validação deste tipo de pedido de apoio se a quantia que
   está a ser fornecida está de acordo com os limites atuais disponibilizados
   pela instituição.


   Método: Antes de qualquer inserção em ApoioMonetario procurar saber se a diferença entre o total angariado (soma dos valores das doaçãos monetárias) e os gastos (soma dos valores atribuídos em cada ApoioMonetário) é menor que o valor indicado no ApoioMonetario proposto. Caso isto aconteça, a operação é abortada e o utilizador notificado.
   ```CREATE TRIGGER...```

2. Objetivo: A qualidade dos produtos armazenados tem de estar de acordo com os padrões
   sanitários básicos, nomeadamente no que diz respeito à data de validade de
   cada unidade. Por esse motivo, cada inserção de um produto deve também
   eliminar das tabelas correspondentes todos aqueles cujo prazo de validade já
   tenha sido extendido. 


   Método: após uma inserção em Produto, se algum produtoAlimentar previamente armazenado na base de dados tenha uma data de validade vencida, é eliminada. As regras _ON DELETE_ garantem que a base de dados é atualizada da forma mais acertada.
   ```CREATE TRIGGER...```

3. Objetivo: Para não sobrecarregar os funcionários de uma organização e distribuir os recursos e tempo da forma mais adequada possível, um Necessitado não pode requesitar um pedido se ainda tiver 5 pendentes de atribuição.


  Método: antes de uma inserção em PedidoApoio, verificar se o pedinte em causa tem um número de pedidos por atribuir (que não são referenciados em Apoio) igual a 5. Se tivere, a operação é abortada e o utilizador notificado. 


  ```CREATE TRIGGER...```
