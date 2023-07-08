--Criação da dimensao credor do Datawarehouse
--utilizei a função TRIM para excluir espaçamento desnecessario das strings e tambem a função DISTINC para evitar duplicidade
create table dw.dim_credor as
select distinct 
        cod_credor as cod_credor,
    trim(dsc_nome_credor) as Nome_Credor,
	    num_sic as Num_ServicoInformCidadao
from execucao_financeira_despesa
where 1=1 and num_sic is not null
order by 1;

--Ao utilizar o comando para mudar o tipo de chave da coluna Cod_credor para Bigint me deparei com registros com letras.
alter table dw.dim_credor 
      alter column cod_credor type bigint using cod_credor::bigint

--Listei o numero(43) de registro com letras "CI", creio que seja erro de digitação, pois não segue o padrão de registros em números inteiros
--Manterei essa coluna no tipo chave em varchar
select cod_credor, nome_credor, num_servicoinformcidadao from dw.dim_credor where cod_credor like '%CI%'

-- Comando para alterar colunas de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dw.dim_credor
      alter column num_servinforcidadao type int using num_servinforcidadao::int
	  
--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna insere valores de autoincremento diferentes evitando duplicidade	  
alter table dw.dim_credor 
      add column credor_key serial

--adicionar chave  Primary Key para a dimensão credor	
alter table dw.dim_credor 
      add primary key(credor_key)

--comando para verificar se a dimensão credor corresponde com a coerencia 
select credor_key, cod_credor, nome_credor, num_servinforcidadao from dw.dim_credor





		
		
		