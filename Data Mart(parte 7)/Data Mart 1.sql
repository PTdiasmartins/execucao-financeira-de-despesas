--data Mart
--data mart é uma visão segmentada e simplificada dos dados para uma área específica. 
--Ele é projetado para fornecer informações analíticas detalhadas e específicas 

create table dm.fato_execucao_financeira_despesa as
select distinct 
           id,
	   cod_ne as cod_num_empenho,
	   vlr_empenho as valor_empenho,
	          valor_pago,
	   vlr_resto_pagar as Divida_ativa,
			 dth_empenho  as Data_Empenho,
			  dth_pagamento as Data_Pagamento,
			  dth_processamento as Data_processamento,
			  num_ano_np as num_ano_notapagamento,
			  cod_np as cod_nota_pagamento,
			  cod_funcao,
			  cod_subfuncao,
		      codigo_orgao as cod_orgao,
		     cod_programa
from execucao_financeira_despesa
where 1=1 and vlr_empenho > 1
		  and cod_np is not null
		  and num_ano_np is not null
		  and dsc_orgao is not null
order by 1;



--listei os registros das colunas cod_nota_pagamento e cod_numeroempenho que contem letras, por isso irão permanecer sem seu tipo chave ser alterado para integer	       
select cod_nota_pagamento from dw.fato_execucao_financeira_despesa
where cod_nota_pagamento like '%B%'
select cod_numeroempenho from dw.fato_execucao_financeira_despesa
where cod_numeroempenho like '%NE%'

-- Comando para alterar colunas de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dm.fato_execucao_financeira_despesa
	   alter column num_ano_notapagamento type bigint using num_ano_notapagamento::bigint,
	   alter column cod_funcao type int using cod_funcao::int,
	   alter column cod_subfuncao type int using cod_subfuncao::int,
       alter column cod_orgao type int using cod_orgao::int,
	   alter column cod_programa type int using cod_programa::int;

	   
	   


--Criação da Dim_função do Data Mart
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade
create table dm.dim_funcao as 
select distinct 
        cod_funcao as cod_funcao,
    trim(dsc_funcao) as descricao_funcao
from execucao_financeira_despesa 
where 1=1 and vlr_empenho > 1
		  and cod_np is not null
		  and num_ano_np is not null
		  and dsc_orgao is not null
order by 1;

-- Comando para alterar coluna de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dm.dim_funcao 
      alter column cod_funcao type int using cod_funcao::int

--adicionar chave  Primary Key para a dimensão funçao	
alter table dm.dim_funcao 
   add primary key (cod_funcao)
   
--Este comando adicionei restrição de chave estrangeira nas demais colunas 
alter table dm.fato_execucao_financeira_despesa
  add  foreign key(cod_funcao) references dm.dim_funcao(cod_funcao),
  add  foreign key(cod_subfuncao) references dm.dim_subfuncao(cod_subfuncao),
  add  foreign key(cod_programa) references dm.dim_programa(cod_programa)
  
alter table dm.fato_execucao_financeira_despesa  
  add  foreign key(cod_orgao) references dm.dim_orgao(cod_orgao),
  add  foreign key(data_empenho) references dm.dim_tempo(data),
  add  foreign key(data_pagamento) references dm.dim_tempo(data)
  
alter table dm.fato_execucao_financeira_despesa
  add  foreign key(data_processamento) references dm.dim_tempo(data)
  

   
--comando para verificar se a dimensão função corresponde com a coerencia dos comandos utilizados anteriormente 
select cod_funcao, descricao_funcao from dm.dim_funcao



--Criação da Dim_subfunção do Data Mart
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade
create table dm.dim_subfuncao as
select distinct
            cod_subfuncao,
		trim(dsc_subfuncao) as descricao_subfuncao
from execucao_financeira_despesa
where 1=1 and vlr_empenho > 1
		  and cod_np is not null
		  and num_ano_np is not null
		  and dsc_orgao is not null
order by 1;

-- Comando para alterar colunas de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dm.dim_subfuncao 
	  alter column cod_subfuncao type int using cod_subfuncao::int

--Utilizei o comando para analisar quantas duplicidade existe na coluna cod_subfuncao
select cod_subfuncao, count(*)
from dm.dim_subfuncao
group by cod_subfuncao
having count(*) > 1;

--manterá apenas a primeira ocorrência de cada valor cod_subfuncao e removerá as linhas duplicadas.
DELETE FROM dm.dim_subfuncao
WHERE ctid NOT IN (
  SELECT MIN(ctid)
  FROM dm.dim_subfuncao
  GROUP BY cod_subfuncao
);


--adicionar chave  Primary Key para a dimensão subfunçao
alter table dm.dim_subfuncao 
       add primary key(cod_subfuncao)

--comando para verificar se a dimensão subfunção corresponde com a coerencia dos comandos utilizados anteriormente 
select*from dm.dim_subfuncao


	   
--Criação da Dim_orgao do Data Mart
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade
create table dm.dim_orgao as
select distinct 
          codigo_orgao as cod_orgao,
      trim(dsc_orgao) as descricao_orgao
from execucao_financeira_despesa
where 1=1 and vlr_empenho > 1
		  and cod_np is not null
		  and num_ano_np is not null
		  and dsc_orgao is not null
order by 1;

-- Comando para alterar colunas de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dm.dim_orgao 
       alter column cod_orgao type int using cod_orgao::int

--adicionar chave  Primary Key para a dimensão orgão	  
alter table dm.dim_orgao 
      add primary key(cod_orgao)

--manterá apenas a primeira ocorrência de cada valor cod_subfuncao e removerá as linhas duplicadas.
DELETE FROM dm.dim_orgao
WHERE ctid NOT IN (
  SELECT MIN(ctid)
  FROM dm.dim_orgao
  GROUP BY cod_orgao
);

--comando para verificar se a dimensão orgão corresponde com a coerencia 
select*from dm.dim_orgao


--Criação da Dim_orgao do Data Mart
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade
create table dm.dim_programa as
select distinct 
            cod_programa,
	    trim(dsc_programa) as descricao_programa
from execucao_financeira_despesa
where 1=1 and vlr_empenho > 1
		  and cod_np is not null
		  and num_ano_np is not null
		  and dsc_orgao is not null
order by 1;


-- Comando para alterar coluna de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dm.dim_programa 
      alter column cod_programa type int using cod_programa::int;
	  
--adicionar chave  Primary Key para a dimensão programa		  
alter table dm.dim_programa 
      add primary key(cod_programa)
	  
--comando para verificar se a dimensão programa corresponde com a coerencia 
select*from dm.dim_programa

--Criação da Dim_tempo do Data Mart
create table dm.dim_tempo as
select distinct 
    id,
	dia,
	mes_nome as mes,
	semestre,
	data,
extract(year from data)::int as Ano
from dw.dim_tempo 
where 1=1 
order by 1;

--adicionar chave  Primary Key para a dimensão programa	
alter table dm.dim_tempo 
   add primary key(data)

--comando para verificar se a dimensão programa corresponde com a coerencia 
select*from dm.dim_tempo


