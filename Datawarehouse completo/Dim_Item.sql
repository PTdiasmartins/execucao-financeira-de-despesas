--Criação da dimensao Item do DW
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade.
create table dw.dim_item as
select distinct 
        cod_item as Cod_Item,
  trim(dsc_item) as Dsc_Item
from execucao_financeira_despesa 
where 1=1 and cod_item is not null 
          and dsc_item is not null
order by 1;

-- Comando para alterar coluna de texto para numero inteiro, devido a coluna ser somente preenchida por numeros inteiros.
alter table dw.dim_item 
      alter column cod_item type integer using cod_item::integer

--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna inseres valores de autoincremento diferentes 
alter table dw.dim_item 
        add column item_key serial
		
--Comando para adicionar constrição PK na coluna ITEM_KEY, é possivel pois não ocorre duplicidade de valor nessa coluna
alter table dw.dim_item 
        add primary key(item_key)
		
--Alterar nome do schema para evitar comandos extensos
alter schema data_warehouse rename to dw