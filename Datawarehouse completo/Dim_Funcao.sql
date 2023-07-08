--Criação da dimensao fonte do Datawarehouse
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade
create table dw.dim_funcao as 
select distinct 
        cod_funcao as cod_funcao,
    trim(dsc_funcao) as descricao_funcao,
from execucao_financeira_despesa 
where 1=1
order by 1;

-- Comando para alterar colunas de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dw.dim_funcao 
      alter column cod_funcao type int using cod_funcao::int,
	  

--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna insere valores de autoincremento diferentes evitando duplicidade
alter table dw.dim_funcao 
      add column funcao_key serial
	  
--adicionar chave  Primary Key para a dimensão funçao	  
alter table dw.dim_funcao 
       add primary key(funcao_key)

--comando para verificar se a dimensão função corresponde com a coerencia dos comandos utilizados anteriormente 
select funcao_key, cod_funcao, descricao_funcao from dw.dim_funcao
