--Criação da dimensao Item_categoria do DW
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade.
create table dw.dim_item_categoria as
select distinct 
        cod_item_categoria,
    trim(dsc_item_categoria) 
from execucao_financeira_despesa 
where 1=1 
order by 1;

-- Comando para alterar coluna de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros
alter table dw.dim_item_categoria
      alter column cod_item_categoria type integer using cod_item_categoria::integer

--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna insere valores de autoincremento diferentes  	  
alter table dw.dim_item_categoria
        add column item_categoria_key serial

--Comando para adicionar constrição PK na coluna ITEM_KEY_CATEGORIA, é possivel pois não ocorre duplicidade de valor nessa coluna
alter table dw.dim_item_categoria
        add primary key(item_categoria_key)

