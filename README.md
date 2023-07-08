<h1 align="center">
    <br>
    <p align="center">Documentação do Código de Execução Financeira de Despesas<p>
</h1>

## 1. Introdução do Projeto

<br>

<p align="justify"> Este projeto consiste em uma análise de um banco relacional proviniente de um backup sobre uma execução financeira de despesa do governo durante 4 anos. Afirmo que esses dados são ficticios...
Irei tratar a integridade destes dados sem alterar o banco relacional e modelar esses dados a partir da criação do datawarehouse;
Mostrarei 2 tipos de schemas(Star e Snowflake);
ETL manualmente utilizando a SQL;
Criei medições com a linguagem DAX do powerbi para algortimos de representação gráfica;

Meu objetivo envolve uma análise OLAP de uma execução financeira na qual irei mostrar empenhos gerais e dividas ativas de orgão, programa, função e subfunção...

</p>

<br>

## 2.  Fluxograma do projeto

<p align="justify">
Um fluxograma é uma representação gráfica de um processo ou sistema, mostrando a sequência de etapas, decisões, atividades e conexões entre elas. É uma ferramenta amplamente utilizada para visualizar e documentar processos de trabalho, fluxos de informações, tomadas de decisões e outras atividades.
</p>
 <img src="./Fluxograma do Projeto/Fluxograma Execução financeira de despesas.png">
<br>

<br>

## 3. Modelo Conceitual do Banco Relacional do Backup

<p align="justify">
 Um modelo conceitual de um banco de dados relacional é uma representação abstrata dos conceitos e relações envolvidos em um sistema de gerenciamento de banco de dados relacional.

 Este modelo conceitual é proviniente do backup na qual existe uma entidade(financeiro) e 37 atributos(1 Identificador e 36 simples)
</p>
 <img src="./Modelo Conceitual do Banco Relacional do Backup/Captura de tela 2023-07-07 201731.png">
<br>

<br>

## 4. Investigação do banco relacional em SQL

- Investigação de colunas com dados ausentes.
- Essa investigação consiste compreender a quantidade dados ausentes para em seguida implementar no banco dimensional com filtros adequados para evitar analises dados nulos que podem ser prejudicial na analise.
- [Investigação do banco relacional em SQL (code)](https://github.com/PTdiasmartins/execucao-financeira-de-despesas/tree/main/Investiga%C3%A7%C3%A3o%20do%20banco%20relacional%20em%20SQL%20(parte%204))

<br>

<br>

## 5. Datawarehouse

- [Datawarehouse (code)](https://github.com/PTdiasmartins/execucao-financeira-de-despesas/tree/main/Datawarehouse%20completo)
<br>

<br>

## 6. Modelagens do Datawarehouse

- O Snowflake Schema (esquema floco de neve) é um modelo de design de banco de dados utilizado em data warehousing, que é uma variação do esquema estrela. No esquema floco de neve, as dimensões são normalizadas em tabelas adicionais de forma hierarquica, resultando em uma estrutura mais complexa em comparação com o esquema estrela. A principal vantagem do esquema floco de neve é a economia de espaço de armazenamento em comparação com o esquema estrela, pois a normalização reduz a redundância de dados.

- O Star Schema (esquema estrela) é um modelo de design de banco de dados usado em data warehousing para organizar os dados de forma a facilitar a análise e a geração de relatórios. É chamado de "esquema estrela" porque sua estrutura se assemelha a uma estrela, com uma tabela de fatos no centro e tabelas de dimensões que se conectam a ela como os raios de uma estrela.

<br>

<img src="./Modelagens do Datawarehouse/snowflake.jpg">

<br>
<img src="./Modelagens do Datawarehouse/starschema.jpg">


## 7. Data Mart

- Data Mart é um subconjunto de um data warehouse que contém dados específicos de um determinado departamento, área de negócio ou necessidades de análise. É projetado para fornecer informações detalhadas e específicas para usuários finais que possuem requisitos de análise direcionados.

- [Data Mart (code)](https://github.com/PTdiasmartins/execucao-financeira-de-despesas/tree/main/Data%20Mart)

<br>

## 8. Power BI

Modelagem proviniente do carregamento de dados a partir da ETL.
Sobre a ETL: Devido o conhecimento sólido em SQL utilizei funções e comandos na quais tratou a integridade dos dados evitando inconsistencia desses dados com seus respectivos relacionamentos(Primary key e Foreign Key).

<img src="./PowerBI/Modelagem do PowerBI.png">

<br>

<br>

## Aluno

### Paulo de Tarso

- [Linkedin](https://www.linkedin.com/in/paulo-de-tarso-moura-81b57b274/)
- [Github](https://github.com/PTdiasmartins)
