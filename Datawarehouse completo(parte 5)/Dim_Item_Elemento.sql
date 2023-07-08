--Criação da dimensao Item_elemento do DW
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade.
create table dw.dim_item_elemento as
select distinct 
        cod_item_elemento,
    trim(dsc_item_elemento) 
from execucao_financeira_despesa 
where 1=1 and cod_item_elemento is not null 
          and dsc_item_elemento is not null
order by 1;

-- Comando para alterar coluna de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros
alter table dw.dim_item_elemento
      alter column cod_item_elemento type integer using cod_item_elemento::integer

--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna insere valores de autoincremento diferentes  	  
alter table dw.dim_item_elemento 
        add column item_elemento_key serial

--Comando para adicionar constrição PK na coluna ITEM_KEY_ELEMENTO, é possivel pois não ocorre duplicidade de valor nessa coluna
alter table dw.dim_item_elemento 
        add primary key(item_elemento_key)


