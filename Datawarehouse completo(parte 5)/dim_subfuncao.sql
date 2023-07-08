--Criação da dimensao fonte do Datawarehouse
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade
create table dw.dim_subfuncao as
select distinct 
            cod_subfuncao,
		trim(dsc_subfuncao) as descricao_subfuncao
from execucao_financeira_despesa
where 1=1 
order by 1;

-- Comando para alterar colunas de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dw.dim_subfuncao 
	  alter column cod_subfuncao type int using cod_subfuncao::int

--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna insere valores de autoincremento diferentes evitando duplicidade
alter table dw.dim_subfuncao 
      add column subfuncao_key serial
	  
--adicionar chave  Primary Key para a dimensão subfunçao
alter table dw.dim_subfuncao 
       add primary key(subfuncao_key)