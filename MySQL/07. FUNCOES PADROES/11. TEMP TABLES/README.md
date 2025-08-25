<h2>11. TEMP TABLES</h2>

<p align="justify">Temp tables, abreviação de "temporary tables" em inglês, referem-se a tabelas temporárias que são criadas e usadas apenas durante a execução de uma sessão de banco de dados e não são persistentes. Essas tabelas temporárias são úteis quando você precisa armazenar temporariamente dados intermediários durante a execução de um script, procedimento armazenado ou consulta complexa. Elas podem ser usadas para armazenar dados temporários, para calcular resultados intermediários ou para realizar operações de manipulação de dados em etapas. As temp tables podem ser criadas de duas formas principais: local e global. No MySQL, somente tabelas locais são possíveis de criar:</p>

```sql
/*TABELA TEMPORÁRIA A PARTIR DE UMA TABELA EXISTENTE*/
-- somente a estrutura da tabela
CREATE TEMPORARY TABLE temp AS
SELECT * FROM tabela LIMIT 0;

-- estrutura e dados
CREATE TEMPORARY TABLE temp AS
SELECT * FROM tabela;


/*TABELA TEMPORÁRIA DO ZERO*/
CREATE TEMPORARY TABLE temp(id INT,
                            nome VARCHAR(50));


-- Inserir dados na temp table
INSERT INTO temp (id, nome) VALUES (1, 'João');
INSERT INTO temp (id, nome) VALUES (2, 'Maria');

-- Selecionar dados da temp table
SELECT * FROM temp;

-- excluir dados da temp table
TRUNCATE TABLE temp;

-- Excluir a temp table
DROP TEMPORARY TABLE temp;     -- ou DROP TABLE temp;
```

<p align="justify">
	Tenha em mente que as temp tables são exclusivas para cada sessão e só podem ser acessadas pela sessão que as criou. Além disso, elas podem ser muito úteis para otimizar consultas complexas e armazenar resultados intermediários temporários. Outro ponto é que a ENGINE de uma tabela temporária sempre será na própria memória RAM, mais acessível que o disco rígido, porém os dados se perdem (justamente por isso, é uma tabela temporária, por ser armazenada em memória temporária). Assim, automaticamente a <b>ENGINE de TEMPORARY TABLE é ENGINE=MEMORY por default</b>.
</p>

```sql
-- criando 'temp_medico' a partir da tabela 'medico'
create temporary table temp_medico as 
select * from medico;

select * from temp_medico limit 5;
```

<table align="center"><thead><tr><th>id</th><th>nome</th><th>crm</th><th>especialidade</th></tr></thead><tbody><tr><td>1</td><td>Dr. João Santos</td><td>11111</td><td>cardio</td></tr><tr><td>2</td><td>Dra. Maria Silva</td><td>22222</td><td>neuro</td></tr><tr><td>3</td><td>Dr. Pedro Barbosa</td><td>33333</td><td>psico</td></tr><tr><td>4</td><td>Dra. Ana Oliveira</td><td>44444</td><td>otorrino</td></tr><tr><td>5</td><td>Dr. Carlos Gomes</td><td>55555</td><td>pneumo</td></tr></tbody></table>

```sql
show columns from temp_medico;     -- ou explain temp_medico;
```

<table align="center"><thead><tr><th>Field</th><th>Type</th><th>Null</th><th>Key</th><th>Default</th><th>Extra</th></tr></thead><tbody><tr><td>id</td><td>int</td><td>NO</td><td></td><td>0</td><td>NULL</td></tr><tr><td>nome</td><td>varchar(45)</td><td>NO</td><td></td><td></td><td>NULL</td></tr><tr><td>crm</td><td>varchar(45)</td><td>NO</td><td></td><td></td><td>NULL</td></tr><tr><td>especialidade</td><td>enum(&#39;cardio&#39;,&#39;neuro&#39;,&#39;psico&#39;,&#39;otorrino&#39;,&#39;pneumo&#39;)</td><td>NO</td><td></td><td></td><td>NULL</td></tr></tbody></table>

```sql
drop temporary table temp_medico;
```
