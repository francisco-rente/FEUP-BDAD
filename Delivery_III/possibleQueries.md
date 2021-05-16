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
      - Monetário: comparação entre o saldo `doações - apoios` existentes e o que o necessitado pede (assumir `800 - rendimento`);
    
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
   -  Amizades: pares de necessitados que já tenham estado juntos em pelo menos um abrigo



## Possíveis gatilhos
-trabalhadores: limites
- qualquer tipo de clean up, doações mais antigas, ter cuidado com situações de Produtos no stock, se se mantém ou não,
  os Apoios que os utilizam etc
- apoios por atribuir
- doações que não estejam de acordo com a sua frequência (basea-se no modelo implementado, not good)
- Apoio Monetário e Produtos questões de stock