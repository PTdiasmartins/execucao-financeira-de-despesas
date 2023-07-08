--Criação da dimensao fonte do Datawarehouse
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade
create table dw.dim_fonte as
select distinct 
         cod_fonte as Cod_Fonte,
    trim(dsc_fonte) as Dsc_Fonte
from execucao_financeira_despesa
where 1=1 and cod_fonte is not null
          and dsc_fonte is not null
		  order by 1;
		  
-- Comando para alterar colunas de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.		  
alter table dw.dim_fonte 
     alter column cod_fonte type int using cod_fonte::int
	 
--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna insere valores de autoincremento diferentes evitando duplicidade		 
alter table dw.dim_fonte 
       add column fonte_key serial 

--adicionar chave  Primary Key para a dimensão fonte
alter table dw.dim_fonte 
       add  primary key(fonte_key);
	   
--comando para verificar se a dimensão fonte corresponde com a coerencia 
select  fonte_key, cod_fonte, dsc_fonte from dw.dim_fonte