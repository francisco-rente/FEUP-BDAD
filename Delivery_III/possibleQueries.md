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
1. ```SELECT...```
2. ```SELECT...```
3. ```SELECT...```
4. ```SELECT...```
5. ```SELECT...```
6. ```SELECT...```
7. ```SELECT...```
8. ```SELECT...```
9. ```SELECT...```
10. ```SELECT...```

## Gatilhos
1. ```CREATE TRIGGER...```
2. ```CREATE TRIGGER...```
3. ```CREATE TRIGGER...```
