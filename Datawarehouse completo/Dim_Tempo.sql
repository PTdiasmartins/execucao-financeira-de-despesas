--Adicionar coluna SEMESTRE na dimensao tempo
alter table dw.dim_tempo add column  semestre

--fracionar o ano da data para separar o primeiro e segundo semestre
UPDATE nome_da_tabela
SET semestre = CASE
    WHEN extract(month from data) <= 6 THEN '1º Semestre'
    ELSE '2º Semestre'
    END;

--excluí essas colunas para evitar redundancia na dimensão tempo, pois ambas informam o mesmo valor 
alter table dw.dim_tempo drop column mes_abrev
alter table dw.dim_tempo drop column mes_numero

select distinct id, dia, mes_nome, semestre, ano, data from dw.dim_tempo
where extract(year from data) between 2019 and 2022 

--comando para exibir a primary key já criada após o backup
SELECT
    pg_attribute.attname AS id, tempo_key
FROM
    pg_index,
    pg_class,
    pg_attribute
WHERE
    pg_class.oid = 'dw.dim_tempo' ::regclass
    AND indrelid = pg_class.oid
    AND pg_attribute.attrelid = pg_class.oid
    AND pg_attribute.attnum = any(pg_index.indkey)
    AND indisprimary;

--excluir a restrição da primary key
alter table dw.dim_tempo drop constraint dim_tempo_pkey

--Comando para adicionar uma coluna tipo chave serial no DW, sendo assim a coluna insere valores de autoincremento diferentes evitando duplicidade  	  
alter table dw.dim_tempo add column tempo_key serial


--adicionar chave  Primary Key e substituta para a dimensão tempo
ALTER TABLE dw.dim_tempo ADD CONSTRAINT pk_tempo_dim PRIMARY KEY (tempo_key);



