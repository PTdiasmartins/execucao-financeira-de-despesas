--Criação da dimensao orgão do Datawarehouse
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade
create table dw.dim_programa as
select distinct 
            cod_programa as cod_programa,
	    trim(dsc_programa) as descricao_programa
from execucao_financeira_despesa
where 1=1 
order by 1

-- Comando para alterar coluna de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dw.dim_programa 
      alter column cod_programa type int using cod_programa::int;
	  
--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna insere valores de autoincremento diferentes evitando duplicidade
alter table dw.dim_programa 
      add column programa_key serial;
	  
--adicionar chave  Primary Key para a dimensão programa		  
alter table dw.dim_programa 
      add primary key(programa_key)
	  
--comando para verificar se a dimensão programa corresponde com a coerencia 	  
select programa_key, cod_programa, descricao_programa from dw.dim_programa