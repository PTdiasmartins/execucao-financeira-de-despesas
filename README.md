<h1 align="center">
    <br>
    <p align="center">Documentação do Código de Criação das Tabelas de Dimensão e Fatos<p>
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
    
## 2.  Fluxograma do projeto.     
    
<p align="justify"> 
Um fluxograma é uma representação gráfica de um processo ou sistema, mostrando a sequência de etapas, decisões, atividades e conexões entre elas. É uma ferramenta amplamente utilizada para visualizar e documentar processos de trabalho, fluxos de informações, tomadas de decisões e outras atividades.
</p>
 <img src="./Fluxograma do Projeto/Fluxograma Execução financeira de despesas.png">
<br>

<br>

## 3. Modelo Conceitual do Banco Relacional do Backup.

<p align="justify"> 
Um modelo conceitual de um banco de dados relacional é uma representação abstrata dos conceitos e relações envolvidos em um sistema de gerenciamento de banco de dados relacional.

Este modelo conceitual é proviniente do backup na qual existe uma entidade(financeiro) e 37 atributos(1 Identificador e 36 simples)

</p>
 <img src="./Modelo Conceitual do Banco Relacional do Backup/Captura de tela 2023-07-07 201731.png">
<br>

<br>

## 4. Investigação do banco relacional em SQL.

-- Investigação de colunas com dados ausentes.
-- Essa investigação consiste compreender a quantidade dados ausentes para em seguida implementar no banco dimensional com filtros adequados para evitar analises dados nulos que podem ser prejudicial na analise.

<br>

<br>

## Aluno:

### Paulo de Tarso

- [Linkedin](https://www.linkedin.com/in/paulo-de-tarso-moura-81b57b274/)
- [Github](https://github.com/PTdiasmartins)
