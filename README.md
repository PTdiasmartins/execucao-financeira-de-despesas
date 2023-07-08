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
 <img src="./Fluxograma do Projeto(parte 2)/Fluxograma Execução financeira de despesas.png">
</p>
<br>

<br>

| Tabelas Dimensionais e Fatos. | Descrição                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `dim_produto`                 | A tabela dim_produto é criada a partir da tabela tbpro. Ela armazena informações sobre produtos, incluindo o código do produto, nome, tipo, unidade, saldo e status.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| `dim_vendedor`                | A tabela dim_vendedor é criada a partir da tabela tbvdd. Ela armazena informações sobre vendedores, incluindo o código do vendedor, nome, sexo, percentual de comissão e matrícula funcional. Nessa tabela utilizamos o CASE para mudar a informação de sexo de numeral para texto (F ou M)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `dim_dependente`              | A tabela dim_dependente é criada a partir da tabela tbdep. Ela armazena informações sobre dependentes, incluindo o código do dependente, nome, data de nascimento, sexo, código do vendedor associado e código INEP da escola.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| `dim_cliente`                 | A tabela dim_cliente é criada a partir da tabela tbven. Ela armazena informações sobre clientes, incluindo o código do cliente, nome, idade, classificação, sexo, cidade, estado e país. Utilizamos o DISTINCT ao SELECT para garantir que apenas linhas distintas sejam selecionadas na criação da tabela dimensão dim_cliente. Isso garante que não haja duplicatas na dimensão.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `dim_canal`                   | A tabela dim_canal é criada a partir da tabela tbven. Ela armazena informações sobre canais de venda, incluindo o nome do canal e um código atribuído com base no tipo de canal. Utilizamos o DISTINCT ao SELECT para garantir que apenas linhas distintas sejam selecionadas na criação da tabela dimensão dim_canal. Isso garante que não haja duplicatas na dimensão. Adicionamos a cláusula CASE no SELECT para mapear os valores da coluna canal para códigos correspondentes na coluna codigocanal, para que cada canal tem um código específico correspondente, para evitar que na inclusão de uma coluna canal, seja criado códigos seriados, mesmo com o nome do canal já existente.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| `dim_status`                  | A tabela dim_status é criada a partir da tabela tbven. Ela armazena informações sobre os status das vendas, incluindo o nome do status e um código atribuído sequencialmente. Utilizamos o DISTINCT ao SELECT para garantir que apenas linhas distintas sejam selecionadas na criação da tabela dimensão dim_canal. Isso garante que não haja duplicatas na dimensão.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| `dim_data`                    | A tabela dim_data é criada para armazenar informações relacionadas a datas. Ela inclui informações como a data em si, ano, mês, dia, dia da semana, trimestre, semestre, feriado, dia útil e dia do ano.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `fato_vendas`                 | A tabela fato_vendas é criada a partir da junção das tabelas tbven_item e tbven, que são as tabelas relacionais que armazenam informações sobre as vendas. A tabela tbven_item contém os itens individuais de cada venda, incluindo o código do item de venda, o código do produto, a quantidade vendida, o valor unitário e o valor total da venda. Por sua vez, a tabela tbven armazena informações gerais sobre cada venda, como a data da venda, o código do cliente, o código do vendedor, o canal de venda e o status da venda.Ao criar a tabela fato_vendas, é feita uma junção (join) dessas duas tabelas com base na chave estrangeira cdven (código de venda), que está presente em ambas as tabelas. A junção combina os dados das tabelas tbven_item e tbven, criando uma tabela consolidada que contém todas as informações relevantes sobre as vendas, incluindo os detalhes dos itens vendidos, a data da venda, o cliente, o vendedor, o canal de venda e o status da venda. Essa tabela fato_vendas serve como uma representação denormalizada dos dados de vendas, onde os detalhes são consolidados em uma única tabela para facilitar a análise e consulta dos dados. Ela se torna a tabela central para análise de vendas e permite realizar consultas eficientes e agregações de dados para obter insights sobre o desempenho das vendas. |

<br>

<br>

## 3. Exemplo de Consulta

### 3.1 [dim_produto] - A tabela dim_produto pode ser consultada para obter informações consolidadas sobre produtos, como nome, tipo e saldo.

```
SELECT * FROM dim_produto;

```

### 3.2 [dim_vendedor] - A tabela dim_vendedor pode ser consultada para obter informações sobre vendedores, como nome, sexo e percentual de comissão.

```
SELECT * FROM dim_vendedor;

```

### 3.3 [dim_dependente] - A tabela dim_dependente pode ser consultada para obter informações sobre dependentes, como nome, data de nascimento e sexo.

```
SELECT * FROM dim_dependente;

```

### 3.4 [dim_cliente] - A tabela dim_cliente pode ser consultada para obter informações sobre clientes, como nome, idade e cidade.

```
SELECT * FROM dim_cliente;

```

### 3.5 [dim_canal] - A tabela dim_canal pode ser consultada para obter informações sobre canais de venda, como o nome do canal.

```
SELECT * FROM dim_canal;

```

### 3.6 [dim_status] - A tabela dim_status pode ser consultada para obter informações sobre os status das vendas, como o nome do status.

```
SELECT * FROM dim_status;

```

### 3.7 [dim_data] (GERAL) - A tabela dim_data pode ser consultada para obter informações relacionadas a datas, como o ano, mês e dia.

```
SELECT * FROM dim_data;

```

### 3.8 [fato_vendas] (GERAL) - A tabela dim_data pode ser consultada para obter informações relacionadas a datas, como o ano, mês e dia.

```
SELECT * FROM dim_data;

```

<br>

<br>
    
## 4. Dicas.

### [Para retornar os nomes dos meses e semanas em Português, se faz necessário criar uma função, conforme exemplo abaixo:]

```
CREATE OR REPLACE FUNCTION data_nome_pt(data DATE)
  RETURNS TABLE (nome_mes TEXT, nome_dia_semana TEXT)
AS $$
DECLARE
  meses TEXT[] := ARRAY['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'];
  dias_semana TEXT[] := ARRAY['Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'];
BEGIN
  nome_mes := meses[EXTRACT(MONTH FROM data)::integer];
  nome_dia_semana := dias_semana[EXTRACT(DOW FROM data)::integer + 1]; ---ajustando o indice.
  RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

Adicionamos o ::integer ao extrair o mês e o dia da semana usando EXTRACT. Isso garante que os valores sejam tratados corretamente como inteiros para acessar os índices dos arrays meses e dias_semana.

```

### [Depois de executar a função, podemos criar a tabela dim_data, conforme abaixo:]

```
CREATE TABLE dw.dim_data AS
SELECT DISTINCT
    dtven AS Data,
    EXTRACT(YEAR FROM dtven) AS Ano,
    TO_CHAR(dtven, 'DDMMYYYY') AS DataCurta,
    (data_nome_pt(dtven)).nome_dia_semana AS DiaDaSemana,
    EXTRACT(DAY FROM dtven) AS DiaMes,
    (data_nome_pt(dtven)).nome_mes AS MesNome,
    EXTRACT(MONTH FROM dtven) AS MesNumero,
    CASE
        WHEN EXTRACT(MONTH FROM dtven) <= 3 THEN 1
        WHEN EXTRACT(MONTH FROM dtven) <= 6 THEN 2
        WHEN EXTRACT(MONTH FROM dtven) <= 9 THEN 3
        ELSE 4
    END AS Trimestre,
    CASE
        WHEN EXTRACT(MONTH FROM dtven) <= 6 THEN 1
        ELSE 2
    END AS Semestre
FROM public.tbven;

SELECT * FROM dw.dim_data;

Dentro da criação da tabela, usamos (data_nome_pt(dtven)).nome_mes e (data_nome_pt(dtven)).nome_dia_semana para obter o nome do mês e o nome do dia da semana retornados pela função.

```

<br>
    
        
## 5. Aluno:   
     
  ### Paulo de Tarso
- [Linkedin](https://www.linkedin.com/in/paulo-de-tarso-moura-81b57b274/)
- [Github](https://github.com/PTdiasmartins)
