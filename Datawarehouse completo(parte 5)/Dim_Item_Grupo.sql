--Criação da dimensao Item_grupo do DW
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade.
create table dw.dim_item_grupo as
select distinct 
        cod_item_grupo,
    trim(dsc_item_grupo) 
from execucao_financeira_despesa 
where 1=1 and cod_item_grupo is not null
          and dsc_item_grupo is not null
order by 1;


-- Comando para alterar coluna de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros
alter table dw.dim_item_grupo
      alter column cod_item_grupo type integer using cod_item_grupo::integer

--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna inseres valores de autoincremento diferentes  	  
alter table dw.dim_item_grupo add column item_grupo_key serial


--Comando para adicionar constrição PK na coluna ITEM_GRUPO_KEY, é possivel pois não ocorre duplicidade de valor nessa coluna
alter table dw.dim_item_grupo add primary key(item_grupo_key)