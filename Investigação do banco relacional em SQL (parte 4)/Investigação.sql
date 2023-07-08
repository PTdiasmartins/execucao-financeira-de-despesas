--investigação de colunas com dados ausentes.
--Essa investigação consiste compreender a quantidade dados ausentes para em seguida implementar no banco dimensional com filtros adequados para evitar analises dados nulos que podem ser prejudicial na analise.
select id from execucao_financeira_despesa where id is null -- não contem nulo
select num_ano from execucao_financeira_despesa where num_ano is null --não contem nulo
select cod_ne from execucao_financeira_despesa where cod_ne is null--não contem nulo
select codigo_orgao from execucao_financeira_despesa where codigo_orgao is null --não contem nulo
select dsc_orgao from execucao_financeira_despesa where dsc_orgao is null --contem nulo
select cod_credor from execucao_financeira_despesa where cod_credor is null --não contem nulo
select dsc_nome_credor from execucao_financeira_despesa where dsc_nome_credor is null --não contem nulo
select cod_fonte from execucao_financeira_despesa where cod_fonte is null --contem nulo
select dsc_fonte from execucao_financeira_despesa where dsc_fonte is null --contem nulo
select cod_funcao from execucao_financeira_despesa where cod_funcao is null --não contem nulo
select dsc_funcao from execucao_financeira_despesa where dsc_funcao is null -- não contem nulo
select cod_item from execucao_financeira_despesa where dsc_item is null --contem nulo
select dsc_item from execucao_financeira_despesa where dsc_item is null --contem nulo
select cod_item_elemento from execucao_financeira_despesa where cod_item_elemento is null --contem nulo
select dsc_item_elemento from execucao_financeira_despesa where dsc_item_elemento is null --contem nulo
select cod_item_categoria from execucao_financeira_despesa where cod_item_categoria is null --não contem nulo
select dsc_item_categoria from execucao_financeira_despesa where dsc_item_categoria is null --não contem nulo
select cod_item_grupo from execucao_financeira_despesa where cod_item_grupo is null --contem nulo
select dsc_item_grupo from execucao_financeira_despesa where dsc_item_grupo is null --contem nulo
select dsc_modalidade_licitacao from execucao_financeira_despesa where dsc_modalidade_licitacao is null --contem nulo
select cod_item_modalidade from execucao_financeira_despesa where cod_item_modalidade is null --nao contem nulo
select dsc_item_modalidade from execucao_financeira_despesa where dsc_item_modalidade is null --não contem nulo
select cod_programa from execucao_financeira_despesa where cod_programa is null --não contem nulo
select dsc_programa from execucao_financeira_despesa where dsc_programa is null --não contem nulo
select cod_subfuncao from execucao_financeira_despesa where cod_subfuncao is null --não contem nulo
select dsc_subfuncao from execucao_financeira_despesa where dsc_subfuncao is null --não contem nulo
select num_sic from execucao_financeira_despesa where num_sic is null --contem nulo
select cod_np from execucao_financeira_despesa where cod_np is null --contem nulo
select vlr_empenho from execucao_financeira_despesa where vlr_empenho> 1--contem nulo
select vlr_liquidado from execucao_financeira_despesa where vlr_liquidado is null --contem nulo
select valor_pago from execucao_financeira_despesa where valor_pago is null --contem nulo
select vlr_resto_pagar from execucao_financeira_despesa where vlr_resto_pagar is null --contem nulo
select dth_empenho from execucao_financeira_despesa where dth_empenho is not null --nao contem nulo
select dth_pagamento from execucao_financeira_despesa where dth_pagamento is null --contem nulo
select dth_liquidacao from execucao_financeira_despesa where dth_liquidacao is null --contem nulo
select dth_processamento from execucao_financeira_despesa where dth_processamento is null --nao contem nulo
select num_ano_np from execucao_financeira_despesa where num_ano_np is null --nao contem nulo

--quantidade de nulos presente na coluna NUM_SIC
select num_sic, count(*) as qnt_registros_nulos from execucao_financeira_despesa
where num_sic is null
group by 1
order by 1 desc;




--comando para detectar duplicidade
select registros_duplicados, count(*) from
(
	select id, 
num_ano, num_sic,
cod_ne, vlr_empenho, dth_empenho, vlr_liquidado, dth_liquidacao, 
valor_pago, dth_pagamento, dth_processamento, vlr_resto_pagar,
codigo_orgao, dsc_orgao, 
cod_credor, dsc_nome_credor,
cod_fonte, dsc_fonte,
cod_funcao, dsc_fonte,
cod_item, dsc_item,
cod_item_elemento, dsc_item_elemento,
cod_item_categoria, dsc_item_categoria,
cod_item_grupo, dsc_item_grupo,
cod_item_modalidade, dsc_item_modalidade, dsc_modalidade_licitacao,
cod_programa, dsc_programa,
cod_subfuncao, dsc_subfuncao,
cod_np, num_ano_np, count(*) as registros_duplicados
	from execucao_financeira_despesa
	group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,30,31,32,33,34,35,36,37
)a
where registros_duplicados > 1
group by 1

--comando para detectar duplicidade
select*from
(
 select id, 
num_ano, num_sic,
cod_ne, vlr_empenho, dth_empenho, vlr_liquidado, dth_liquidacao, 
valor_pago, dth_pagamento, dth_processamento, vlr_resto_pagar,
codigo_orgao, dsc_orgao, 
cod_credor, dsc_nome_credor,
cod_fonte, dsc_fonte,
cod_funcao, dsc_fonte,
cod_item, dsc_item,
cod_item_elemento, dsc_item_elemento,
cod_item_categoria, dsc_item_categoria,
cod_item_grupo, dsc_item_grupo,
cod_item_modalidade, dsc_item_modalidade, dsc_modalidade_licitacao,
cod_programa, dsc_programa,
cod_subfuncao, dsc_subfuncao,
cod_np, num_ano_np, count(*) as records from execucao_financeira_despesa
	group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,30,31,32,33,34,35,36,37
)a
where records = 2

--comando para analisar as colunas onde existe empenhos maiores que 1, pois não são cosiderados empenhos iguais a 0
select distinct  cod_ne, codigo_orgao, dsc_orgao, cod_programa, dsc_programa,
cod_funcao, dsc_funcao, cod_subfuncao, dsc_subfuncao, cod_programa, dsc_programa,
vlr_empenho, vlr_liquidado, valor_pago, vlr_resto_pagar
from execucao_financeira_despesa 
where vlr_empenho > 1 
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
order by cod_ne desc


select distinct  cod_ne, codigo_orgao, dsc_orgao, cod_programa, dsc_programa,
cod_funcao, dsc_funcao, cod_subfuncao, dsc_subfuncao, cod_programa, dsc_programa,
vlr_empenho, vlr_liquidado, valor_pago, vlr_resto_pagar
from execucao_financeira_despesa 
where vlr_empenho > 1 
group by 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
order by cod_ne desc



select distinct trim(dsc_orgao),trim (dsc_nome_credor), dsc_fonte, dsc_funcao, dsc_item, dsc_item_elemento,
dsc_item_categoria, dsc_item_grupo, dsc_modalidade_licitacao, dsc_item_modalidade, dsc_programa, dsc_subfuncao
from execucao_financeira_despesa
where vlr_empenho >1
group by 1,2,3,4,5,6,7,8,9,10,11, 12


--Após o backup da execucao_financeira_despesa surge um banco relacional contem 37 colunas provinientes da execucao_financeira_despesa e 1 dimensão tempo no datawarehouse
--Utilizei comando para interpretar e comparar com a coluna num_ano_np.

select distinct num_ano_np from execucao_financeira_despesa

select distinct ano from dw.dim_tempo
order by ano asc
--nota-se que que a tabela dim_tempo contem 30 anos de registro, em contrapartida coluna num_ano proveniente do banco relacional contem 4 anos(2019 até 2022) de registros
select distinct id, dia, mes_nome, semestre, ano, data from dw.dim_tempo
where extract(year from data) between 2019 and 2022


--comando para exibir a primary key da dim_tempo do datawarehouse já criada após o backup
SELECT
    pg_attribute.attname AS id
FROM
    pg_index,
    pg_class,
    pg_attribute
WHERE
    pg_class.oid = 'dw.dim_tempo' ::regclass
    AND indrelid = pg_class.oid
    AND pg_attribute.attrelid = pg_class.oid
    AND pg_attribute.attnum = any(pg_index.indkey)
    AND indisprimary;


--excluir a restrição da primary key já criada no datawarehouse
alter table dw.dim_tempo drop constraint dim_tempo_pkey

--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna inseres valores de autoincremento diferentes onde evita duplicidade 	  
alter table dw.dim_tempo add column tempo_key serial

--adicionar chave Surrogate Primary Key
ALTER TABLE dw.dim_tempo ADD CONSTRAINT pk_tempo_dim PRIMARY KEY (id, tempo_key);











