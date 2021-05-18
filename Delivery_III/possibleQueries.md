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

- Obter fluxo esperado num dado intervalo de tempo (baseado nas datas e periodicidade das doações regulares);
- Avaliar relação entre a altura do ano (mês/estação/semestre) e o valor recolhido;
- Identificar dadores mais importantes:
    - Maior frequência de doações;
    - Maior valor doado;
      > PROFESSORA: Sem usar LIMIT ou MAX
    - Doação em todos os meses de um ano;
    - Doação de todos os tipos de produto;

### Exequibilidade atual

- Quantos/Que pedidos de apoio podem ser satisfeitos atualmente para:
    - Alojamento: comparação com a totalidade de camas disponíveis);
    - Monetário: comparação entre o saldo `doações - apoios` existentes e o que o necessitado pede (
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
- Amizades: pares de necessitados que já tenham estado juntos em pelo menos um abrigo

## Possíveis gatilhos

- Garantir estatuto de carenciado:
    - Impedir pedidos de apoio de necessitados com rendimento superior a 800€
    - Impedir que o mesmo necessitado tenha mais do que 5 pedidos de apoio pendentes (sem um apoio atribuído)

- Garantir sustentabilidade de recursos:
    - Dinheiro suficiente para apoios monetários
    - Produtos suficientes para apoios materiais
    - Vagas suficientes para apoios de alojamento
    - Remover produtos cuja data de validade tenha expirado

- Garantir bem-estar dos colaboradores:
    - Impedir que sejam atribuídos demasiados pedidos ao mesmo orientador para não o sobrecarregar
    - Impedir que sejam atribuídos horários demasiado longos a trabalhadores mais velhos

--- 




## Interrogações

1. Listar pedidos de apoio pendentes, ordenados por prioridade crescente e agrupados por tipo. CHECKED

   ```SELECT...```


2. Para cada pedido de apoio, listar os trabalhadores disponíveis mais adequados (contabilizar hora atual), considerando um trabalhador adequado
   sempre que habite numa zona próxima ou já tenha participado num apoio atribuído a esse necessitado. (Analisar código postal) CHECKED.

   ```SELECT...```


3. Tendo em conta a frequência e o valor da doação recorrente mais recente de cada cliente, estimar o fluxo de entrada
   esperado nos próximos X dias. (Algoritmo de dados do Tomás) CHECKED

   ```SELECT...```


4. - Para cada pedido de apoio de alojamento, identificar o abrigo mais apropriado, considerando um abrigo apropriado
   sempre que não esteja demasiado longe da área de residência do necessitado. CHECKED
   
   - Os resultados devem ser ordenados com
   base na proximidade entre o pedinte e os restantes habitantes, assumindo que um habitante é próximo de outro sempre
   que já tenham coabitado. SLOT EXTRA 

   ```SELECT...```


5. Para cada abrigo, calcular um conjunto de estatísticas relevantes sobre os seus habitantes: média de idades, média de
   rendimentos, nacionalidade mais comum e justificação mais comum para requerer asilo. (Verificar visualização dos dadoss) CHECKED

   ```SELECT...```


6. - É relevante estudar a distribuição de doações pelos meses e estações do ano. Concretamente, é importante
   saber os meses do ano com maior e menor volume de doações, a pessoa que doou mais vezes, a pessoa que doou mais dinheiro à instituição (sem recorrer limit or max) e as pessoa que já tenham doado todos os tipos de produtos.  CHECKED
   - Quem fez doações monetárias e não fez de produtos. (uso de left join)

   ```SELECT...```


7. Em relação aos pedidos de apoio pendentes, é importante saber quais deles podem ser satisfeitos com os recursos
   existentes. Assim, as camas restantes devem ser comparadas com os pedidos de alojamento e o saldo monetário deve ser
   comparado com os pedidos de apoio monetários. CHECKED.

   ```SELECT...```


8. Será útil listar os números de telefone de todos os dadores que tenham "falhado" a sua doação planeada para poderem
   ser contactados/relembrados. CHECKED, semelhança com futuros apoios

   ```SELECT...```


9. Para evitar separar famílias, deve ser possível listar as famílias que pediram alojamento para que sejam colocadas no
   mesmo abrigo. Assim, os pedidos de alojamento devem ser agrupados por morada + localidade. CHECKED
   
   ```SELECT...```


10. É relevante estudar a distribuição de pedidos pelos meses e estações do ano. Convém saber os meses de maior atividade, bem como o necessitado que inseriu mais pedidos, qual o tipo mais requisitado, quantos foram atribuídos e uma contagem relativa à prioridade. CHECKED

   ```SELECT...```

## Gatilhos

1. De forma a garantir que o valor de cada apoio monetário é comportado pelo valor angariado pela totalidade das doações monetárias, é necessário verificar em cada validação deste tipo de pedido de apoio se a quantia que está a ser fornecida está de acordo com os limites atuais disponibilizados pela instituição. (ABORTAR A OPERAÇÃO) CHECK
  ```CREATE TRIGGER...```

2. A qualidade dos produtos armazenados tem de estar de acordo com os padrões sanitários básicos, nomeadamente no que diz respeito à data de validade de cada unidade. Por esse motivo, cada inserção de um produto deve também eliminar das tabelas correspondentes todos aqueles cujo prazo de validade já tenha sido extendido. (ELIMINAR NA TABELA BASE) CHECK
  ```CREATE TRIGGER...```

3. É importante acolher/auxiliar os necessitados o mais prontamente possível. 
  - Impedir que o mesmo necessitado tenha mais do que 5 pedidos de apoio pendentes (sem um apoio atribuído).
  ```CREATE TRIGGER...```
