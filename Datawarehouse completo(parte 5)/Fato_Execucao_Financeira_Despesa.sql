
--Criei a tabela fato sem dth_liquidacao e vlr_liquidado devido a ausencia desses dados presentes no banco relacional.
--Utilizei filtros para despesas, caso o valor do empenho seja igual a zero não será considerado uma despesa.
--Função "is not null" para filtrar dados ausentes cod_np e num_ano_np com objetivo de proporcionar uma analise mais assertiva e apurada dos dados
create table dw.fato_execucao_financeira_despesa as
select distinct 
              id,
			  cod_ne as cod_numeroEmpenho,
			  vlr_empenho as valor_empenho,
			  			  valor_pago,
			  vlr_resto_pagar as Divida_ativa,
			  dth_empenho as Data_Empenho,
			  dth_pagamento as Data_Pagamento,
			  dth_processamento as Data_processamento,
			  num_ano_np as num_ano_notapagamento,
			  cod_np as cod_nota_pagamento
from execucao_financeira_despesa
where 1=1 and vlr_empenho > 1
		  and cod_np is not null
		  and num_ano_np is not null
order by 1;

-- Comando para alterar colunas de texto para numeros inteiros, devido a coluna ser somente preenchida por numeros inteiros.
alter table dw.fato_execucao_financeira_despesa
	   alter column num_ano_notapagamento type bigint using num_ano_notapagamento::bigint
	   

--listei os registros das colunas cod_nota_pagamento e cod_numeroempenho que contem letras, por isso irão permanecer sem seu tipo chave ser alterado para integer	       
select cod_nota_pagamento from dw.fato_execucao_financeira_despesa
where cod_nota_pagamento like '%B%'
select cod_numeroempenho from dw.fato_execucao_financeira_despesa
where cod_numeroempenho like '%NE%'

--Adicionando colunas para relacionar com a chave primarias das demais tabelas dimensional.
alter table dw.fato_execucao_financeira_despesa
   add column credor_key int,
   add column fonte_key int, 
   add column funcao_key int,
   add column subfuncao_key int,
   add column item_key int,
	 add column item_categoria_key int,
	 add column item_elemento_key int,
	 add column item_grupo_key int;
   add column orgao_key_key int,
   add column programa_key int,
   add column data_empenho_key int,
   add column data_pagamento_key int,
   add column data_processamento_key int;
   
   
--Este comando adicionei restrição de chave estrangeira nas demais colunas 
alter table dw.fato_execucao_financeira_despesa
  add  foreign key(credor_key) references dw.dim_credor(credor_key),
  add  foreign key(fonte_key) references dw.dim_fonte(fonte_key),
  add  foreign key(funcao_key) references dw.dim_funcao(funcao_key)
  
alter table dw.fato_execucao_financeira_despesa  
  add  foreign key(item_key) references dw.dim_item(item_key),
  add  foreign key(orgao_key) references dw.dim_orgao(orgao_key),
  add  foreign key(programa_key) references dw.dim_programa(programa_key)
  
alter table dw.fato_execucao_financeira_despesa
  add  foreign key(data_empenho_key) references dw.dim_tempo(tempo_key),
  add  foreign key(data_pagamento_key) references dw.dim_tempo(tempo_key),
  add  foreign key(data_processamento_key) references dw.dim_tempo(tempo_key);

alter table dw.fato_execucao_financeira_despesa
  add  foreign key(item_categoria_key) references dw.dim_item_categoria(item_categoria_key),
  add  foreign key(item_elemento_key) references dw.dim_item_elemento(item_elemento_key),
  add  foreign key(item_grupo_key) references dw.dim_item_grupo(item_grupo_key)
  
alter table dw.fato_execucao_financeira_despesa
  add  foreign key(subfuncao_key) references dw.dim_subfuncao(subfuncao_key)

--Comando para adicionar a restrição Chave primária.
alter table dw.fato_execucao_financeira_despesa
  add primary key(financeiro_key)


--Existe 4 tipos de tabelas fato, esta se enquadra no tipo fato acumulativo devido o processo da execução financeira ocorrer em vários estágios diferentes.
--dessa forma a chave primaria da tabela tempo (tempo_key) se relaciona 3 vezes com a tabela fato através das chaves estrangeiras(data_emepnho_key, data_pagamento_key, data_processamento_key)