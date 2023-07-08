
--Criação da dimensao orgão do Datawarehouse
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade
create table dw.dim_orgao as
select distinct 
          codigo_orgao as cod_orgao,
      trim(dsc_orgao) as descricao_orgao
from execucao_financeira_despesa
where 1=1 and dsc_orgao is not null
order by 1;

-- Comando para alterar colunas de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dw.dim_orgao 
       alter column cod_orgao type int using cod_orgao::int

--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna insere valores de autoincremento diferentes evitando duplicidade		
alter table dw.dim_orgao
      add column orgao_key serial

--adicionar chave  Primary Key para a dimensão orgão	  
alter table dw.dim_orgao 
      add primary key(orgao_key)

--comando para verificar se a dimensão orgão corresponde com a coerencia 
select cod_orgao, descricao_orgao, orgao_key from dw.dim_orgao