<h2>1. DDL</h2>

<p align="justify">
  Os comandos DDL (Data Definition Language) são utilizados para criar, alterar e excluir estruturas de banco de dados, como tabelas, índices e restrições. Alguns dos comandos DDL mais comuns são:
</p>

<ul>
	<li><p align="justify"><b>CREATE: </b>Utilizado para criar uma nova tabela, visão, índice, função, procedimento armazenado, usuário, esquema, etc. Exemplo: CREATE TABLE nome_tabela (coluna1 tipo_dado, coluna2 tipo_dado, ...);</p></li>
	<li><p align="justify"><b>ALTER: </b>Utilizado para modificar a estrutura de uma tabela existente, como adicionar, excluir ou modificar colunas ou restrições. Exemplo: ALTER TABLE nome_tabela ADD coluna tipo_dado;</p></li>
	<li><p align="justify"><b>DROP: </b>Utilizado para excluir uma tabela, visão, índice, função, procedimento armazenado, usuário, esquema, etc. e suas dependências.Exemplo: DROP TABLE nome_tabela;</p></li>
	<li><p align="justify"><b>TRUNCATE: </b>Utilizado para excluir todos os registros de uma tabela sem excluir a estrutura da tabela. Exemplo: TRUNCATE TABLE nome_tabela;</p></li>
	<li><p align="justify"><b>RENAME: </b>Utilizado para renomear uma tabela ou coluna existente. Exemplo: ALTER TABLE nome_tabela RENAME COLUMN coluna_atual TO novo_nome;</p></li>
	<li><p align="justify"><b>COMMENT: </b>Utilizado para adicionar comentários ou descrições a tabelas, colunas, visões, etc. Exemplo: COMMENT ON TABLE nome_tabela IS 'Descrição da tabela';</p></li>
</ul>

<h3>1.1 CREATE TABLE</h3>

<p align="justify">
	Suponha que queramos criar um DB chamado "firma". Sua DDL de criação se dá como abaixo:
</p>

```sql
-- criando e ativando db "firma"
create database if not exists firma;
use firma;

-- Desabilitando check de FKs em inserts
SET FOREIGN_KEY_CHECKS = 0;

-- DDL CRIANDO TABELA
CREATE TABLE if not exists funcionario 
(matricula INT not null primary key auto_increment, 
 nome VARCHAR(50) NOT NULL,      
 sobrenome VARCHAR(50) NOT NULL,      
 endereco VARCHAR(50),      
 cidade VARCHAR(50),      
 pais VARCHAR(25),      
 data_nasc DATETIME);

-- DDL CRIANDO TABELA COM CHAVE ESTRANGEIRA
CREATE TABLE if not exists salario 
(matricula INT not null, 
 salario DECIMAL(10,2) NOT NULL,
 FOREIGN KEY(matricula) REFERENCES funcionario(matricula)
);

-- DDL CRIACAO DE TABELA COM CHAVE PRIMARIA
CREATE TABLE if not exists audit_salario 
(transacao INT not null auto_increment,
 matricula INT NOT NULL,      
 data_trans DATETIME NOT NULL,      
 sal_antigo DECIMAL(10,2),      
 sal_novo DECIMAL(10,2), 
 Usuario varchar(20)not null,
 primary key(transacao),
 FOREIGN KEY(matricula) REFERENCES funcionario(matricula) 
);

-- Habilitando check de FKs em inserts
SET FOREIGN_KEY_CHECKS = 0;
```

<p align="justify">
	Note no uso de <b>SET FOREIGN_KEY_CHECKS</b>. Os comandos ocorrem de maneira sequencial, e como algumas tabelas podem ser criadas com FKs fazendo referência a PKs de tabelas não criadas (1) além de <b>INSERTS</b> de registros com FKs que ainda não existem PKs na tabela correspondente, isto pode crashar o script. Este comando desabilita a validação neste sentido, permitindo que os comandos executados sequencialmente possam ser executados sem validação. O importante é lembrar de habilitar ao final. Portanto, <b>deve ser usado antes do primeiro CREATE TABLE para desabilitar validação de FK e usado após o último INSERT para habilitar a validação</b>.
</p>

<h3>1.2 CREATE INDEX</h3>

<p align="justify">
	Criemos agora exemplos com <b>CREATE INDEX</b>. Um índice, também conhecido como index ou índice, é uma estrutura de dados associada a uma tabela de banco de dados que melhora a velocidade de consulta e a eficiência geral do sistema. É uma forma de organizar os dados em uma tabela para facilitar a busca rápida e eficiente com base nos valores de uma ou mais colunas. O comando `CREATE INDEX` é usado para criar um novo índice em uma tabela específica. A criação de um índice envolve a varredura da tabela e a criação de uma estrutura de dados adicional que armazena as informações-chave e suas respectivas localizações físicas na tabela. Essa estrutura de dados (o índice) é otimizada para permitir uma busca rápida com base nos valores das colunas indexadas, em vez de percorrer a tabela inteira. Os índices são especialmente úteis ao executar consultas que envolvem colunas nas quais você aplicará filtros ou realizará operações de junção. Eles ajudam a reduzir o tempo necessário para localizar os registros desejados, melhorando o desempenho das consultas. No entanto, os índices também têm algumas desvantagens. Eles ocupam espaço adicional em disco, tornam as operações de inserção, atualização e exclusão um pouco mais lentas (pois precisam atualizar o índice) e podem precisar ser recalculados ou reconstruídos periodicamente para garantir que estejam atualizados e otimizados.
</p>

```sql
-- DDL CRIACAO DE INDEX
CREATE INDEX ix_func2 ON funcionario(cidade, pais);
```

<p align="justify">
	O índice criado acima é chamado de "ix_func2" e é criado na tabela "funcionario". O índice está sendo criado nas colunas "cidade" e "pais" da tabela "funcionario", o que significa que ele será usado para otimizar pesquisas e consultas que envolvam essas colunas. Contudo, consumirá mais memória.
</p>

<h3>1.3 ALTER TABLE</h3>

<p align="justify">
	Fazer alterações em tabelas, como trocar seus nomes, alterar nomes de colunas, adicionar ou remover colunas, alterar tipagem, faz-se inicialmente com o comando <b>ALTER TABLE</b>:
</p>

<table align="center"><thead><tr><th>COMANDO</th><th>DDL</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>RENOMEAR TABELA</td><td>ALTER TABLE nome_da_tabela RENAME TO novo_nome</td><td>ALTER TABLE funcionario RENAME TO funcionarios</td></tr><tr><td>ADICIONAR COLUNA</td><td>ALTER TABLE nome_da_tabela ADD COLUMN nome_coluna tipo_dado</td><td>ALTER TABLE funcionario ADD COLUMN sobrenome VARCHAR(50)</td></tr><tr><td>RENOMEAR COLUNA</td><td>ALTER TABLE nome_da_tabela RENAME COLUMN nome_antigo TO nome_novo</td><td>ALTER TABLE funcionario RENAME COLUMN nome TO nome_completo</td></tr><tr><td>EXCLUIR COLUNA</td><td>ALTER TABLE nome_da_tabela DROP COLUMN nome_coluna</td><td>ALTER TABLE funcionario DROP COLUMN salario</td></tr><tr><td>TROCAR NOME OU TIPAGEM</td><td>ALTER TABLE nome_da_tabela CHANGE nome_antigo novo_nome tipo_dado</td><td>ALTER TABLE funcionario CHANGE sobrenome nome_completo VARCHAR(50)</td></tr><tr><td>TROCAR ENGINE</td><td>ALTER TABLE nome_da_tabela ENGINE = nova_engine</td><td>ALTER TABLE funcionario ENGINE = InnoDB</td></tr><tr><td>MODIFICAR COLUNA</td><td>ALTER TABLE nome_da_tabela MODIFY COLUMN nome_coluna novo_tipo_dado</td><td>ALTER TABLE funcionario MODIFY COLUMN sobrenome VARCHAR(100)</td></tr></tbody></table>

```sql
-- Adicionando novo campo na tabela 
ALTER TABLE funcionario ADD COLUMN genero varchar(1);

-- Renomeando campo/colunas da tabela
alter table funcionario rename column nome to nome_funcionario;

-- Alterando nome e tipagem
alter table funcionario change genero sexo char(1);

-- Deletando coluna
alter table funcionario drop column sexo;

-- Renomeando  tabela
rename table funcionario to pessoa;

--  retornando situacao anterior
rename table pessoa to funcionario;

-- Alterando tipo da coluna
ALTER TABLE funcionario MODIFY COLUMN endereco VARCHAR(30);

-- alterar Engine da tabela
ALTER TABLE funcionario ENGINE = MyIsam;       -- nao funciona, pois MyIsam nao suporta FK e a tabela contem uma FK

-- checar engine de 'funcionario'
SHOW TABLE STATUS like 'funcionario';          -- a engine é InnoDB, que suporta FKs
```

<h3>1.4 COMANDOS DE DATABASE: CREATE, DROP, USE</h3>

<p align="justify">
	Bancos de dados possuem comandos de criação, deleção e uso. Criar e deletar são semelhantes aos de colunas. Antes de operar dentro de um banco de dados, o comando USE DB deve ser executado:
</p>

<table align="center"><thead><tr><th>COMANDO</th><th>DDL</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>CRIAR BANCO DE DADOS</td><td>CREATE DATABASE nome_do_banco</td><td>CREATE DATABASE vendas</td></tr><tr><td>DELETAR BANCO DE DADOS</td><td>DROP DATABASE nome_do_banco</td><td>DROP DATABASE vendas</td></tr><tr><td>SELECIONAR BANCO DE DADOS</td><td>USE nome_do_banco</td><td>USE vendas</td></tr></tbody></table>

```sql
-- criando db
CREATE DATABASE teste;

-- usando db
use teste;

-- Excluindo db
DROP DATABASE teste;
```

<h3>1.5 SHOW</h3>

<p align="justify">
	O comando "SHOW" é utilizado para exibir informações sobre o banco de dados, tabelas, colunas, usuários e outras informações relacionadas ao sistema de banco de dados. A seguir, estão algumas das possibilidades de uso do comando "SHOW":
</p>

<table align="center"><thead><tr><th>COMANDO</th><th>DESCRIÇÃO</th></tr></thead><tbody><tr><td>SHOW DATABASES</td><td>Exibe a lista de todos os bancos de dados existentes no servidor.</td></tr><tr><td>SHOW TABLES</td><td>Exibe a lista de todas as tabelas presentes no banco de dados atual.</td></tr><tr><td>SHOW COLUMNS FROM nome_da_tabela</td><td>Exibe as colunas da tabela especificada.</td></tr><tr><td>SHOW CREATE TABLE nome_da_tabela</td><td>Exibe o script de criação da tabela especificada.</td></tr><tr><td>SHOW INDEX FROM nome_da_tabela</td><td>Exibe os índices definidos na tabela especificada.</td></tr><tr><td>SHOW GRANTS FOR nome_do_usuario</td><td>Exibe os privilégios concedidos para um usuário específico.</td></tr><tr><td>SHOW PROCESSLIST</td><td>Exibe informações sobre os processos em execução no banco de dados.</td></tr></tbody></table>

```sql
-- mostrar dbs
show databases;
```

<table align="center"><thead><tr><th>Database</th></tr></thead><tbody><tr><td>curso</td></tr><tr><td>dbvitor</td></tr><tr><td>firma</td></tr><tr><td>hospital</td></tr><tr><td>information_schema</td></tr><tr><td>mysql</td></tr><tr><td>performance_schema</td></tr><tr><td>sakila</td></tr><tr><td>sys</td></tr><tr><td>teste</td></tr><tr><td>varejista</td></tr><tr><td>world</td></tr></tbody></table>

```sql
-- mostrar dbs
show databases;
```

<table align="center"><thead><tr><th>Tables_in_firma</th></tr></thead><tbody><tr><td>audit_salario</td></tr><tr><td>funcionario</td></tr><tr><td>salario</td></tr></tbody></table>

```sql
-- mostrar colunas da tabela "funcionario";
show columns from funcionario;
```

<table align="center"><thead><tr><th>Field</th><th>Type</th><th>Null</th><th>Key</th><th>Default</th><th>Extra</th></tr></thead><tbody><tr><td>matricula</td><td>int</td><td>NO</td><td>PRI</td><td></td><td>auto_increment</td></tr><tr><td>nome_funcionario</td><td>varchar(50)</td><td>NO</td><td></td><td></td><td></td></tr><tr><td>sobrenome</td><td>varchar(50)</td><td>NO</td><td></td><td></td><td></td></tr><tr><td>endereco</td><td>varchar(50)</td><td>YES</td><td></td><td></td><td></td></tr><tr><td>cidade</td><td>varchar(50)</td><td>YES</td><td>MUL</td><td></td><td></td></tr><tr><td>pais</td><td>varchar(25)</td><td>YES</td><td></td><td></td><td></td></tr><tr><td>data_nasc</td><td>datetime</td><td>YES</td><td>MUL</td></tr></tbody></table>

```sql
-- mostrar índices de "funcionario":
show index from funcionario;
```

<table align="center"><thead><tr><th>Table</th><th>Non_unique</th><th>Key_name</th><th>Seq_in_index</th><th>Column_name</th><th>Collation</th><th>Cardinality</th><th>Sub_part</th><th>Packed</th><th>Null</th><th>Index_type</th><th>Comment</th><th>Index_comment</th><th>Visible</th><th>Expression</th></tr></thead><tbody><tr><td>funcionario</td><td>0</td><td>PRIMARY</td><td>1</td><td>matricula</td><td>A</td><td>0</td><td></td><td></td><td></td><td>BTREE</td><td></td><td></td><td>YES</td><td></td></tr><tr><td>funcionario</td><td>1</td><td>ix_func1</td><td>1</td><td>data_nasc</td><td>A</td><td>0</td><td></td><td></td><td>YES</td><td>BTREE</td><td></td><td></td><td>YES</td><td></td></tr><tr><td>funcionario</td><td>1</td><td>ix_func2</td><td>1</td><td>cidade</td><td>A</td><td>0</td><td></td><td></td><td>YES</td><td>BTREE</td><td></td><td></td><td>YES</td><td></td></tr><tr><td>funcionario</td><td>1</td><td>ix_func2</td><td>2</td><td>pais</td><td>A</td><td>0</td><td></td><td></td><td>YES</td><td>BTREE</td><td></td><td></td><td>YES</td></tr></tbody></table>

```sql
-- vendo privilegios
SELECT * FROM mysql.user;    -- vendo usuarios (col 'User')
SHOW GRANTS FOR Vitor;
```

<table align="center"><thead><tr><th>Grants for Vitor@%</th></tr></thead><tbody><tr><td>GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `Vitor`@`%` WITH GRANT OPTION</td></tr></tbody></table>

```sql
-- vendo processos
SHOW processlist;
```

<table align="center"><thead><tr><th>Id</th><th>User</th><th>Host</th><th>db</th><th>Command</th><th>Time</th><th>State</th><th>Info</th></tr></thead><tbody><tr><td>5</td><td>event_scheduler</td><td>localhost</td><td></td><td>Daemon</td><td>37016</td><td>Waiting on empty queue</td><td></td></tr><tr><td>45</td><td>root</td><td>localhost:56664</td><td></td><td>Sleep</td><td>586</td><td></td><td></td></tr><tr><td>47</td><td>root</td><td>localhost:64056</td><td>hospital</td><td>Sleep</td><td>25583</td><td></td><td></td></tr><tr><td>48</td><td>root</td><td>localhost:51454</td><td>firma</td><td>Query</td><td>0</td><td>init</td><td>&quot;/* ApplicationName=DBeaver 23.2.5 - SQLEditor &lt;Script-2.sql&gt; */</td></tr><tr><td></td></tr></tbody></table>

<h3>1.6 Tabela "mysql"</h3>

<p align="justify">
	No MySQL, a tabela "mysql" contém diversas outras tabelas que armazenam informações sobre os usuários, privilégios, configurações e outros dados relacionados ao servidor. Alguns outros comandos que podem ser utilizados em conjunto com "SELECT * FROM mysql." para acessar essas informações são:
</p>

<table align="justify"><thead><tr><th>Comando</th><th>Descrição</th></tr></thead><tbody><tr><td>SELECT * FROM mysql.db</td><td>Retorna informações sobre os privilégios concedidos a bancos de dados específicos.</td></tr><tr><td>SELECT * FROM mysql.tables_priv</td><td>Retorna informações sobre os privilégios concedidos a tabelas específicas.</td></tr><tr><td>SELECT * FROM mysql.columns_priv</td><td>Retorna informações sobre os privilégios concedidos a colunas específicas.</td></tr><tr><td>SELECT * FROM mysql.procs_priv</td><td>Retorna informações sobre os privilégios concedidos a procedimentos armazenados específicos.</td></tr><tr><td>SELECT * FROM mysql.proxies_priv</td><td>Retorna informações sobre os privilégios concedidos a usuários proxy específicos.</td></tr><tr><td>SELECT * FROM mysql.user</td><td>Retorna informações sobre os usuários.</td></tr></tbody></table>

```sql
-- checando usuarios
SELECT * FROM mysql.user;
```

<table align="center"><thead><tr><th>Host</th><th>User</th><th>Select_priv</th><th>Insert_priv</th><th>Update_priv</th><th>Delete_priv</th><th>Create_priv</th><th>Drop_priv</th><th>Reload_priv</th><th>Shutdown_priv</th><th>Process_priv</th><th>File_priv</th><th>Grant_priv</th><th>References_priv</th><th>Index_priv</th><th>Alter_priv</th><th>Show_db_priv</th><th>Super_priv</th><th>Create_tmp_table_priv</th><th>Lock_tables_priv</th><th>Execute_priv</th><th>Repl_slave_priv</th><th>Repl_client_priv</th><th>Create_view_priv</th><th>Show_view_priv</th><th>Create_routine_priv</th><th>Alter_routine_priv</th><th>Create_user_priv</th><th>Event_priv</th><th>Trigger_priv</th><th>Create_tablespace_priv</th><th>ssl_type</th><th>ssl_cipher</th><th>x509_issuer</th><th>x509_subject</th><th>max_questions</th><th>max_updates</th><th>max_connections</th><th>max_user_connections</th><th>plugin</th><th>authentication_string</th><th>password_expired</th><th>password_last_changed</th><th>password_lifetime</th><th>account_locked</th><th>Create_role_priv</th><th>Drop_role_priv</th><th>Password_reuse_history</th><th>Password_reuse_time</th><th>Password_require_current</th><th>User_attributes</th></tr></thead><tbody><tr><td>%</td><td>Vitor</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td></td><td>[BINARY]</td><td>[BINARY]</td><td>[BINARY]</td><td>0</td><td>0</td><td>0</td><td>0</td><td>caching_sha2_password</td><td></td><td>N</td><td>2022-04-11 14:18:02</td><td></td><td>N</td><td>Y</td><td>Y</td><td></td><td></td><td></td><td></td></tr><tr><td>localhost</td><td>mysql.infoschema</td><td>Y</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td></td><td>[BINARY]</td><td>[BINARY]</td><td>[BINARY]</td><td>0</td><td>0</td><td>0</td><td>0</td><td>caching_sha2_password</td><td>$A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED</td><td>N</td><td>2022-04-11 14:17:57</td><td></td><td>Y</td><td>N</td><td>N</td><td></td><td></td><td></td><td></td></tr><tr><td>localhost</td><td>mysql.session</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>Y</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>Y</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td></td><td>[BINARY]</td><td>[BINARY]</td><td>[BINARY]</td><td>0</td><td>0</td><td>0</td><td>0</td><td>caching_sha2_password</td><td>$A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED</td><td>N</td><td>2022-04-11 14:17:57</td><td></td><td>Y</td><td>N</td><td>N</td><td></td><td></td><td></td><td></td></tr><tr><td>localhost</td><td>mysql.sys</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td></td><td>[BINARY]</td><td>[BINARY]</td><td>[BINARY]</td><td>0</td><td>0</td><td>0</td><td>0</td><td>caching_sha2_password</td><td>$A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED</td><td>N</td><td>2022-04-11 14:17:57</td><td></td><td>Y</td><td>N</td><td>N</td><td></td><td></td><td></td><td></td></tr><tr><td>localhost</td><td>root</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td></td><td>[BINARY]</td><td>[BINARY]</td><td>[BINARY]</td><td>0</td><td>0</td><td>0</td><td>0</td><td>caching_sha2_password</td><td>$A$005$kh1?0U?SlW9^G&quot;8!????Fh4k4WNDGAKv0ZUpASiIih9Dtv3rJVATrWPPMGO2o2D</td><td>N</td><td>2022-04-11 14:18:02</td><td></td><td>N</td><td>Y</td><td>Y</td></tr></tbody></table>

<h3>1.7 Comandos de VIEW</h3>

<p align="justify">
	As VIEWS (visões) são objetos do banco de dados que oferecem uma representação virtual de uma tabela ou consulta. Elas são criadas a partir de uma consulta SQL e podem ser utilizadas para simplificar a recuperação de dados complexos ou fornecer diferentes perspectivas dos dados existentes em uma ou mais tabelas. As VIEWS podem ser consideradas como tabelas virtuais, pois não armazenam dados fisicamente, mas apresentam os resultados de uma consulta como se fossem uma tabela real. Elas são atualizadas automaticamente sempre que os dados subjacentes da tabela original são modificados. Suas vantagens:
</p>

<ol>
	<li><p align="justify"><b>Simplificação do acesso aos dados: </b>As VIEWS permitem definir consultas complexas e usá-las como uma tabela simplificada para extrair informações específicas sem a necessidade de escrever a consulta completa repetidamente.</p></li>
	<li><p align="justify"><b>Restrição de acesso aos dados: </b>É possível definir permissões de acesso para as VIEWS, restringindo os usuários a acessarem apenas as colunas necessárias ou aplicando filtros para limitar os registros visíveis.</p></li>
	<li><p align="justify"><b>Reutilização de consultas: </b>Com as VIEWS, é possível criar consultas complexas e utilizá-las em vários pontos do sistema, evitando a repetição do código SQL e facilitando a manutenção.</p></li>
	<li><p align="justify"><b>Abstração dos detalhes de implementação: </b>As VIEWS podem ocultar a complexidade das consultas subjacentes aos usuários finais, fornecendo uma visão simplificada e organizada dos dados.</p></li>
</ol>

<p align="justify">Dos vários comandos para VIEWS, temos:</p>

<table align="center"><thead><tr><th>COMANDO</th><th>DESCRIÇÃO</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>CREATE VIEW</td><td>Cria uma nova view a partir de uma consulta SQL.</td><td>CREATE VIEW view_name AS SELECT column1, column2 FROM table WHERE condition;</td></tr><tr><td>ALTER VIEW</td><td>Modifica a definição de uma view existente.</td><td>ALTER VIEW view_name AS SELECT column1, column3 FROM table WHERE condition;</td></tr><tr><td>DROP VIEW</td><td>Remove uma view existente do banco de dados.</td><td>DROP VIEW view_name;</td></tr><tr><td>SELECT</td><td>Consulta os dados de uma view existente.</td><td>SELECT * FROM view_name;</td></tr><tr><td>SHOW CREATE VIEW</td><td>Exibe o CREATE VIEW statement original de uma view existente.</td><td>SHOW CREATE VIEW view_name;</td></tr><tr><td>RENAME VIEW</td><td>Renomeia uma view existente.</td><td>RENAME VIEW old_view_name TO new_view_name;</td></tr><tr><td>REPLACE VIEW</td><td>Substitui a definição de uma view existente.</td><td>REPLACE VIEW view_name AS SELECT column1, column4 FROM table WHERE condition;</td></tr><tr><td>ALTER VIEW ... SET SCHEMABINDING</td><td>Adiciona a cláusula SCHEMABINDING a uma view existente.</td><td>ALTER VIEW view_name SET SCHEMABINDING;</td></tr></tbody></table>

<p align="justify">
	Para fins de didática, coloquemos dados na tabela "funcionario":
</p>

```sql
-- DDL -> CREATE TABLE IF NOT EXISTS
CREATE TABLE if not exists funcionario 
(matricula INT not null primary key auto_increment, 
 nome_funcionario VARCHAR(50) NOT NULL,      
 sobrenome VARCHAR(50) NOT NULL,      
 endereco VARCHAR(50),      
 cidade VARCHAR(50),      
 pais VARCHAR(25),      
 data_nasc DATETIME);

-- DML -> INSERT INTO
INSERT INTO funcionario (nome_funcionario, sobrenome, endereco, cidade, pais, data_nasc) 
VALUES 
('João', 'Silva', 'Rua A, 123', 'São Paulo', 'Brasil', '1990-01-01 00:00:00'),
('Maria', 'Santos', 'Rua B, 456', 'Rio de Janeiro', 'Brasil', '1985-05-10 12:34:56'),
('Pedro', 'Lima', 'Av. C, 789', 'Belo Horizonte', 'Brasil', '1995-07-15 08:00:00'),
('Ana', 'Souza', 'Rua D, 321', 'Porto Alegre', 'Brasil', '1992-03-20 15:30:00'),
('Lucas', 'Almeida', 'Av. E, 654', 'Recife', 'Brasil', '1988-11-05 10:10:10');
```

```sql
-- criando VIEW
CREATE VIEW v_funcionario AS
SELECT * FROM funcionario;

SELECT * FROM v_funcionario;
```

<table align="center"><thead><tr><th>matricula</th><th>nome_funcionario</th><th>sobrenome</th><th>endereco</th><th>cidade</th><th>pais</th><th>data_nasc</th></tr></thead><tbody><tr><td>1</td><td>João</td><td>Silva</td><td>Rua A, 123</td><td>São Paulo</td><td>Brasil</td><td>1990-01-01 00:00:00</td></tr><tr><td>2</td><td>Maria</td><td>Santos</td><td>Rua B, 456</td><td>Rio de Janeiro</td><td>Brasil</td><td>1985-05-10 12:34:56</td></tr><tr><td>3</td><td>Pedro</td><td>Lima</td><td>Av. C, 789</td><td>Belo Horizonte</td><td>Brasil</td><td>1995-07-15 08:00:00</td></tr><tr><td>4</td><td>Ana</td><td>Souza</td><td>Rua D, 321</td><td>Porto Alegre</td><td>Brasil</td><td>1992-03-20 15:30:00</td></tr><tr><td>5</td><td>Lucas</td><td>Almeida</td><td>Av. E, 654</td><td>Recife</td><td>Brasil</td><td>1988-11-05 10:10:10</td></tr></tbody></table>

```sql
-- alterando VIEW
ALTER VIEW v_funcionario AS 
SELECT matricula, nome_funcionario FROM funcionario;

select * from v_funcionario;
```

<table align="center"><thead><tr><th>matricula</th><th>nome_funcionario</th></tr></thead><tbody><tr><td>1</td><td>João</td></tr><tr><td>2</td><td>Maria</td></tr><tr><td>3</td><td>Pedro</td></tr><tr><td>4</td><td>Ana</td></tr><tr><td>5</td><td>Lucas</td></tr></tbody></table>

```sql
-- Excluindo VIEW
DROP VIEW v_funcionario; 

select * from v_funcionario;  -- gera erro
```

<h2>2. DML</h2>

<p align="justify">
  Os comandos DML (Data Manipulation Language) tem como função principal manipular os dados presentes no banco de dados. Mais especificamente, os comandos DML permitem inserir, alterar e excluir os registros de um banco de dados. Para executar tais ações, os SGBDs trabalham com quatro tipos de comandos: INSERT , DELETE , UPDATE e SELECT. São eles:
</p>

<ul>
  <li><p align="justify"><b>SELECT: </b>Utilizado para recuperar dados de uma ou mais tabelas. <b>Exemplo:</b> SELECT coluna1, coluna2 FROM nome_tabela WHERE condição;</p></li>
  <li><p align="justify"><b>INSERT: </b>Utilizado para inserir novos dados em uma tabela. <b>Exemplo:</b> INSERT INTO nome_tabela (coluna1, coluna2) VALUES (valor1, valor2);</p></li>
  <li><p align="justify"><b>UPDATE: </b>Utilizado para modificar os dados existentes em uma tabela. <b>Exemplo:</b> UPDATE nome_tabela SET coluna = novo_valor WHERE condição;</p></li>
  <li><p align="justify"><b>DELETE: </b>Utilizado para excluir os dados de uma tabela. <b>Exemplo:</b> DELETE FROM nome_tabela WHERE condição;</p></li>
  <li><p align="justify"><b>MERGE: </b>Utilizado para combinar as operações de INSERT, UPDATE e DELETE em uma única declaração, com base em uma condição em uma tabela alvo e uma tabela de origem. <b>Exemplo: </b>MERGE INTO tabela_alvo USING tabela_origem ON condição MATCHED THEN UPDATE SET coluna = novo_valor WHEN NOT MATCHED THEN INSERT (coluna1, coluna2) VALUES (valor1, valor2);</p></li>
</ul>

```sql
-- DDL -> CREATE TABLE IF NOT EXISTS
CREATE TABLE if not exists funcionario 
(matricula INT not null primary key auto_increment, 
 nome_funcionario VARCHAR(50) NOT NULL,      
 sobrenome VARCHAR(50) NOT NULL,      
 endereco VARCHAR(50),      
 cidade VARCHAR(50),      
 pais VARCHAR(25),      
 data_nasc DATETIME);
```

<h3>2.1 INSERT com cláusula VALUES</h3>

```sql
-- DML -> INSERT INTO
INSERT INTO funcionario (nome_funcionario, sobrenome, endereco, cidade, pais, data_nasc) 
VALUES 
('João', 'Silva', 'Rua A, 123', 'São Paulo', 'Brasil', '1990-01-01 00:00:00'),
('Maria', 'Santos', 'Rua B, 456', 'Rio de Janeiro', 'Brasil', '1985-05-10 12:34:56'),
('Pedro', 'Lima', 'Av. C, 789', 'Belo Horizonte', 'Brasil', '1995-07-15 08:00:00'),
('Ana', 'Souza', 'Rua D, 321', 'Porto Alegre', 'Brasil', '1992-03-20 15:30:00'),
('Lucas', 'Almeida', 'Av. E, 654', 'Recife', 'Brasil', '1988-11-05 10:10:10');
```

```sql
-- insert
INSERT INTO funcionario (nome_funcionario, sobrenome, endereco, cidade, pais, data_nasc) 
VALUES 
('Victor', 'Paiva', 'Rua Z, 80', 'Rio de Janeiro', 'Brasil', '1991-01-01 03:45:00');

-- check
SELECT * FROM funcionario
where nome_funcionario = "Victor" and sobrenome = "Paiva";
```

<table align="center"><thead><tr><th>matricula</th><th>nome_funcionario</th><th>sobrenome</th><th>endereco</th><th>cidade</th><th>pais</th><th>data_nasc</th></tr></thead><tbody><tr><td>6</td><td>Victor</td><td>Paiva</td><td>Rua Z, 80</td><td>Rio de Janeiro</td><td>Brasil</td><td>1991-01-01 03:45:00</td></tr></tbody></table>

<h3>2.2 INSERT em colunas do tipo AUTO_INCREMENT</h3>

<p align="justify">
	Quanto ao comando <b>INSERT</b>, quando a coluna for do tipo <b>AUTO_INCREMENT</b>, nos valores a serem inseridos basta colocar o nome da própria coluna, pois, este comando é um incremental de 1 unidade e não deve ser declarado. Toda coluna do tipo <b>AUTO_INCREMENT</b> será uma <b>PRIMARY KEY</b>, que, na criação da coluna, deve ser explicitada que se trata de uma PK.
</p>

```sql
create table exemplo (
id int auto_increment primary key,
valor float not null,
nome text
);

insert into exemplo (id, valor, nome)
values
(id, 2.10, 'pão'),
(id, 3.00, 'leite'),
(id, 4.80, NULL);

select * from exemplo;
```

<table align="center"><thead><tr><th>id</th><th>valor</th><th>nome</th></tr></thead><tbody><tr><td>1</td><td>2,1</td><td>pão</td></tr><tr><td>2</td><td>3</td><td>leite</td></tr><tr><td>3</td><td>4,8</td></tr></tbody></table>

<p align="justify">
	Repare que id é AUTO_INCREMENT e foi declarada como PK. Durante o INSERT, id foi repetida em cada registro. Note também que NOT NULL são campos que não podem ficar vazios.
</p>

<h3>2.3 INSERT com SELECT</h3>

<p align="justify">É possível fazer inserções de dados oriundos de consultas. Bom recurso para tabelas temporárias ou tabelas puramente alimentadas de informações de demais tabelas e não de informações da aplicação. Como:</p>

```sql
INSERT INTO tabela2
SELECT col1, col2, colN FROM tabela1
```

<p align="justify">Exemplo 1: Tabela temporária</p>

```sql
-- criando tabela temporária
CREATE temporary TABLE temp_Remedio (
  ID INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
  nome VARCHAR(25),
  preco FLOAT,
  planos_cobertos TEXT
);

-- alimentado-a com SELECT da tabela original
insert into temp_Remedio
select * from remedio;

-- check
select * from temp_Remedio limit 5;
```

<table align="center"><thead><tr><th>ID</th><th>nome</th><th>preco</th><th>planos_cobertos</th></tr></thead><tbody><tr><td>1</td><td>Remedio 1</td><td>10,5</td><td>AMIL,SILVESTRE</td></tr><tr><td>2</td><td>Remedio 2</td><td>20,75</td><td>AMIL</td></tr><tr><td>3</td><td>Remedio 3</td><td>15</td><td>SILVESTRE</td></tr><tr><td>4</td><td>Remedio 4</td><td>30,25</td><td>AMIL,SILVESTRE,SULAMERICA</td></tr><tr><td>5</td><td>Remedio 5</td><td>12</td><td>SULAMERICA</td></tr></tbody></table>

<p align="justify">Exemplo 2: Alimentada de consulta de demais tabelas.</p>

```sql
-- criando tabela (temporária)
create temporary table consolidado
( id               int
, dataConsulta     timestamp
, medico           text
, especialidade    text
, paciente         text
, plano            text
, descricao        text
, remedio          text
, planos_cobertos  text
, preco            float);

-- inserindo registros com SELECT
insert into consolidado
select
  c.`id` as `consultaID`
, c.`data` as `dataConsulta`
, m.`nome` as `medico`
, m.`especialidade`
, p.`nome` as `paciente`
, p.`plano`
, rc.`descricao`
, rm.`nome` as `remedio`
, rm.`planos_cobertos`
, rm.`preco`
from consulta c
	left join medico m     on c.`medico_id` = m.`id`
	left join paciente p   on c.`paciente_id` = p.`id`
	left join receita rc   on rc.`consulta_id` = c.`id`
	left join remedio rm   on rm.`ID` = rc.`remedio_id`
where 1=1
  and m.`especialidade` = 'cardio'
;

-- check
select * from consolidado;
```

<table align="center"><thead><tr><th>id</th><th>dataConsulta</th><th>medico</th><th>especialidade</th><th>paciente</th><th>plano</th><th>descricao</th><th>remedio</th><th>planos_cobertos</th><th>preco</th></tr></thead><tbody><tr><td>1</td><td>2022-01-01 09:00:00</td><td>Dr. João Santos</td><td>cardio</td><td>Fulano Silva</td><td>AMIL</td><td>Prescrição A</td><td>Remedio 1</td><td>AMIL,SILVESTRE</td><td>10,5</td></tr><tr><td>6</td><td>2022-01-02 13:00:00</td><td>Dr. João Santos</td><td>cardio</td><td>Ana Silva</td><td>SULAMERICA</td><td>Prescrição F</td><td>Remedio 6</td><td></td><td>18,5</td></tr><tr><td>11</td><td>2022-01-02 16:00:00</td><td>Dr. João Santos</td><td>cardio</td><td>Cicrano Souza</td><td>SILVESTRE</td><td>Prescrição K</td><td>Remedio 1</td><td>AMIL,SILVESTRE</td><td>10,5</td></tr></tbody></table>

<h3>2.4 Atualizando registros com UPDATE ... SET ... WHERE</h3>

```sql
-- update
update funcionario set nome_funcionario = "Vitor"
where matricula = 6;

-- check
SELECT * FROM funcionario
where nome_funcionario = "Vitor" and sobrenome = "Paiva";
```

<table align="center"><thead><tr><th>matricula</th><th>nome_funcionario</th><th>sobrenome</th><th>endereco</th><th>cidade</th><th>pais</th><th>data_nasc</th></tr></thead><tbody><tr><td>6</td><td>Vitor</td><td>Paiva</td><td>Rua Z, 80</td><td>Rio de Janeiro</td><td>Brasil</td><td>1991-01-01 03:45:00</td></tr></tbody></table>

<h3>2.5 Atualizando registros com UPDATE ... SET ... REPLACE</h3>

```sql
/* UPDATE com função REPLACE */
-- antes
select nome from paciente where nome regexp('Fulano');         -- retorna 'Fulano da Silva'

-- UPDATE com REPLACE
UPDATE paciente
SET nome = REPLACE(nome, 'Fulano da Silva', 'Fulano Silva');

-- depois
select nome from paciente where nome regexp('Fulano');         -- retorna 'Fulano Silva'
```

<h3>2.6 Atualizando registros com UPDATE ... SET ... CONDICIONAL (CASE WHEN | IF)</h3>

```sql
update remedio
set preco = case when id >= 12 then preco + 1 else preco end;

select * from remedio where id >= 12;
```

<table align="center"><thead><tr><th>id</th><th>nome</th><th>preco</th><th>planos_cobertos</th></tr></thead><tbody><tr><td>12</td><td>Remedio 12</td><td>18.75</td><td>AMIL</td></tr><tr><td>13</td><td>Remedio 13</td><td>12.5</td><td>SULAMERICA</td></tr><tr><td>14</td><td>Remedio 14</td><td>20.0</td><td>AMIL,SILVESTRE</td></tr><tr><td>15</td><td>Remedio 15</td><td>33.0</td><td>AMIL,SULAMERICA</td></tr></tbody></table>

<h3>2.7 Deletando registros: DELETE FROM ... WHERE</h3>

```sql
-- delete
delete from funcionario 
where matricula = 6;

-- check
SELECT * FROM funcionario
where nome_funcionario = "Vitor" and sobrenome = "Paiva";

-- nao retornará nada
```

<h3>2.8 Múltiplos comandos em processo e segurança: BEGIN...COMMIT / ROLLBACK</h3>

<p align="justify">
	Para ter controle sobre as alterações no banco de dados, é possível usar o comando BEGIN juntamente com comandos DDL. Este inicia um processo e todos os comandos subsequentes são executados na sessão, só tendo suas alterações salvas caso seja comitado, e podendo ser revertido caso haja inconssistência em remoção, atualização, inserção de registros. Sintaxe:
</p>

```sql
BEGIN;

--- ... comandos

COMMIT;       -- se OK
ROLLBACK;     -- se NOK
```

<p align="justify">
	Os comandos COMMIT e ROLLBACK finalizam o BEGIN, assim como END. Contudo, END é para procedures. Façamos um UPDATE e um INSERT na tabela medico:
</p>

```sql
-- 1. inicia processo
begin;
	-- 1.1 checa registros (antes)
	select * from medico;

	-- 1.2 faz update 
	update medico set nome = 'Dr. João Santos da Silva' where id = 1;

	-- 1.3 faz insert
	insert into medico values
	(id, 'Augusto Cury', 66666, 'neuro');

	-- 1.4 validacao (depois)
	select * from medico;

-- 2. comita caso  OK ou reverte caso NOK
commit;       -- OK
rollback;     -- NOK
```

<p align="center"><b>antes</b></p>

<table align="center"><thead><tr><th>id</th><th>nome</th><th>crm</th><th>especialidade</th></tr></thead><tbody><tr><td>1</td><td>Dr. João Santos</td><td>11111</td><td>cardio</td></tr><tr><td>2</td><td>Dra. Maria Silva</td><td>22222</td><td>neuro</td></tr><tr><td>3</td><td>Dr. Pedro Barbosa</td><td>33333</td><td>psico</td></tr><tr><td>4</td><td>Dra. Ana Oliveira</td><td>44444</td><td>otorrino</td></tr><tr><td>5</td><td>Dr. Carlos Gomes</td><td>55555</td><td>pneumo</td></tr></tbody></table>

<p align="center"><b>depois</b></p>

<table align="center"><thead><tr><th>id</th><th>nome</th><th>crm</th><th>especialidade</th></tr></thead><tbody><tr><td>1</td><td>Dr. João Santos da Silva</td><td>11111</td><td>cardio</td></tr><tr><td>2</td><td>Dra. Maria Silva</td><td>22222</td><td>neuro</td></tr><tr><td>3</td><td>Dr. Pedro Barbosa</td><td>33333</td><td>psico</td></tr><tr><td>4</td><td>Dra. Ana Oliveira</td><td>44444</td><td>otorrino</td></tr><tr><td>5</td><td>Dr. Carlos Gomes</td><td>55555</td><td>pneumo</td></tr><tr><td>6</td><td>Augusto Cury</td><td>66666</td><td>neuro</td></tr></tbody></table>

<h2>3. DCL</h2>

<p align="justify">
	Os comandos DCL (Data Control Language) são utilizados para controlar o acesso e as permissões no banco de dados. Alguns dos comandos DCL mais comuns são:
</p>

<ul>
	<li><p align="justify"><b>GRANT: </b>É usado para conceder permissões aos usuários ou papéis para executar operações específicas no banco de dados. Exemplo: GRANT SELECT, INSERT ON nome_tabela TO nome_usuario;</p></li>
	<li><p align="justify"><b>REVOKE: </b>É usado para revogar as permissões previamente concedidas para usuários ou papéis. Exemplo: REVOKE SELECT, INSERT ON nome_tabela FROM nome_usuario;</p></li>
	<li><p align="justify"><b>DENY: </b>É usado para negar explicitamente permissões a usuários ou papéis. Exemplo: DENY DELETE ON nome_tabela TO nome_usuario;</p></li>
	<li><p align="justify"><b>CREATE USER: </b>É usado para criar um novo usuário. Exemplo: CREATE USER nome_usuario IDENTIFIED BY 'senha';</p></li>
	<li><p align="justify"><b>ALTER USER: </b>É usado para alterar as informações de um usuário existente. Exemplo: ALTER USER nome_usuario IDENTIFIED BY 'nova_senha';</p></li>
	<li><p align="justify"><b>DROP USER: </b>É usado para remover um usuário do banco de dados. Exemplo: DROP USER nome_usuario;</p></li>
	<li><p align="justify"><b>CREATE ROLE: </b>É usado para criar um novo papel. Exemplo: CREATE ROLE nome_papel;</p></li>
	<li><p align="justify"><b>ALTER ROLE: </b>É usado para alterar as características de um papel existente. Exemplo: ALTER ROLE nome_papel ADD MEMBER nome_usuario;</p></li>
	<li><p align="justify"><b>DROP ROLE: </b>É usado para remover um papel do banco de dados. Exemplo: DROP ROLE nome_papel;</p></li>
</ul>

<p align="justify">
	Esses são apenas alguns exemplos dos comandos DCL mais comuns. A sintaxe e os recursos exatos podem variar dependendo do sistema de gerenciamento de banco de dados que você está utilizando. É importante consultar a documentação oficial do sistema para obter uma lista completa de comandos e opções disponíveis.
</p>

```sql
/* Criar user "ALUNO' para a conexão com 'localhost' com a senha 'aluno123' */
-- DROP USER 'ALUNO'@'localhost';
CREATE USER 'ALUNO'@'localhost' IDENTIFIED BY 'aluno123';

-- check
select * from mysql.user 
where User regexp('ALUNO');
```

<table align="center"><thead><tr><th>Host</th><th>User</th><th>Select_priv</th><th>Insert_priv</th><th>Update_priv</th><th>Delete_priv</th><th>Create_priv</th><th>Drop_priv</th><th>Reload_priv</th><th>Shutdown_priv</th><th>Process_priv</th><th>File_priv</th><th>Grant_priv</th><th>References_priv</th><th>Index_priv</th><th>Alter_priv</th><th>Show_db_priv</th><th>Super_priv</th><th>Create_tmp_table_priv</th><th>Lock_tables_priv</th><th>Execute_priv</th><th>Repl_slave_priv</th><th>Repl_client_priv</th><th>Create_view_priv</th><th>Show_view_priv</th><th>Create_routine_priv</th><th>Alter_routine_priv</th><th>Create_user_priv</th><th>Event_priv</th><th>Trigger_priv</th><th>Create_tablespace_priv</th><th>ssl_type</th><th>ssl_cipher</th><th>x509_issuer</th><th>x509_subject</th><th>max_questions</th><th>max_updates</th><th>max_connections</th><th>max_user_connections</th><th>plugin</th><th>authentication_string</th><th>password_expired</th><th>password_last_changed</th><th>password_lifetime</th><th>account_locked</th><th>Create_role_priv</th><th>Drop_role_priv</th><th>Password_reuse_history</th><th>Password_reuse_time</th><th>Password_require_current</th><th>User_attributes</th></tr></thead><tbody><tr><td>localhost</td><td>ALUNO</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td></td><td>[BINARY]</td><td>[BINARY]</td><td>[BINARY]</td><td>0</td><td>0</td><td>0</td><td>0</td><td>caching_sha2_password</td><td>$A$005$?M*OsFoNf?=t?.4H#N@{nvWBeOgI9S01G.ioKaoAdWgymwhfuvQcJ9W7CFP3QZ3</td><td>N</td><td>2023-11-21 22:30:31</td><td></td><td>N</td><td>N</td><td>N</td></tr></tbody></table>

```sql
/* Parte 1 CONCEDE-GRANT */

-- Concedendo Acesso de atualizacao (UPDATE) da tabela 'funcionario' para 'ALUNO'
GRANT UPDATE ON funcionario TO 'ALUNO'@'localhost';

-- Concedendo Acesso de atualizacao (UPDATE) para 'ALUNO' em todas as tabelas
GRANT UPDATE ON *.* TO 'ALUNO'@'localhost';

-- Concedendo Acesso deletar (DELETE) da tabela 'funcionario' para 'ALUNO' 
GRANT DELETE ON funcionario TO 'ALUNO'@'localhost';

-- Concedendo Acesso de deletar (DELETE) para 'ALUNO' em todas as tabelas
GRANT DELETE ON *.* TO 'ALUNO'@'localhost';

-- Concedendo Acesso de inserir dados (INSERT) na tabela 'funcionario' para 'ALUNO'
GRANT INSERT ON funcionario TO 'ALUNO'@'localhost';

-- Concedendo Acesso de consulta (SELECT) na tabela 'funcionario' para 'ALUNO'
GRANT SELECT ON funcionario TO 'ALUNO'@'localhost';

-- Concedendo Acesso de consulta (SELECT) e inserir dados (INSERT) na tabela 'funcionario' para 'ALUNO'
GRANT SELECT, INSERT ON funcionario TO 'ALUNO'@'localhost';

-- Concedendo Acesso a consulta (SELECT) em alguns campos da tabela 'funcionario' para 'ALUNO' 
GRANT SELECT (matricula, nome_funcionario) ON funcionario TO 'ALUNO'@'localhost';

-- Concedendo Acesso à procedure 'proc_quadrado' para 'ALUNO'
-- procedure
DELIMITER //
CREATE PROCEDURE proc_quadrado(IN numero INT, OUT resultado INT)
	BEGIN
    	SET resultado = numero * numero;
	END //
DELIMITER ;

-- grant
GRANT EXECUTE ON PROCEDURE proc_quadrado TO 'ALUNO'@'localhost';

-- Concedendo Acesso a todas as colunas da tabela 'funcionario' para 'ALUNO'
GRANT ALL PRIVILEGES ON funcionario TO 'ALUNO'@'localhost';

-- Concedendo todos os acessos para 'ALUNO'
GRANT ALL PRIVILEGES ON * . * TO 'ALUNO'@'localhost';

-- Recarregando/subindo privilégios (executar ao final, sempre)
FLUSH PRIVILEGES;

-- check
select * from mysql.user where User='ALUNO';
```

<table align="center"><thead><tr><th>Host</th><th>User</th><th>Select_priv</th><th>Insert_priv</th><th>Update_priv</th><th>Delete_priv</th><th>Create_priv</th><th>Drop_priv</th><th>Reload_priv</th><th>Shutdown_priv</th><th>Process_priv</th><th>File_priv</th><th>Grant_priv</th><th>References_priv</th><th>Index_priv</th><th>Alter_priv</th><th>Show_db_priv</th><th>Super_priv</th><th>Create_tmp_table_priv</th><th>Lock_tables_priv</th><th>Execute_priv</th><th>Repl_slave_priv</th><th>Repl_client_priv</th><th>Create_view_priv</th><th>Show_view_priv</th><th>Create_routine_priv</th><th>Alter_routine_priv</th><th>Create_user_priv</th><th>Event_priv</th><th>Trigger_priv</th><th>Create_tablespace_priv</th><th>ssl_type</th><th>ssl_cipher</th><th>x509_issuer</th><th>x509_subject</th><th>max_questions</th><th>max_updates</th><th>max_connections</th><th>max_user_connections</th><th>plugin</th><th>authentication_string</th><th>password_expired</th><th>password_last_changed</th><th>password_lifetime</th><th>account_locked</th><th>Create_role_priv</th><th>Drop_role_priv</th><th>Password_reuse_history</th><th>Password_reuse_time</th><th>Password_require_current</th><th>User_attributes</th></tr></thead><tbody><tr><td>localhost</td><td>ALUNO</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>N</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td>Y</td><td></td><td>[BINARY]</td><td>[BINARY]</td><td>[BINARY]</td><td>0</td><td>0</td><td>0</td><td>0</td><td>caching_sha2_password</td><td>&quot;$A$005$</td></tr><tr><td>h?i2K6b~q? y^s?Kv:U6YTaQebz7SbJc1XXdOCw73ap3YVKy1haCCUyVBz1a4&quot;</td><td>N</td><td>2023-11-21 22:07:46</td><td></td><td>N</td><td>Y</td><td>Y</td></tr></tbody></table>

```sql
/* Parte 2 NEGA-REVOKE */
-- Revoga acesso de atualizacao (UPDATE) na tabela 'funcionario' para 'ALUNO'
REVOKE UPDATE ON funcionario FROM 'ALUNO'@'localhost';

-- Revoga acesso de atualizacao (UPDATE) de todas as tabelas para 'ALUNO'
REVOKE UPDATE  ON *.* FROM 'ALUNO'@'localhost';

-- Revoga acesso de deletar (DELETE) da tabela 'funcionario' para 'ALUNO'
REVOKE DELETE  ON funcionario FROM  'ALUNO'@'localhost';

-- Revoga acesso de deletar (DELETE) de todas as tabelas para 'ALUNO'
REVOKE DELETE  ON *.* FROM  'ALUNO'@'localhost';

-- Revoga acesso de inserir (INSERT) da tabela 'funcionario' para 'ALUNO'
REVOKE INSERT  ON funcionario FROM 'ALUNO'@'localhost';

-- Revoga acesso de consulta (SELECT) da tabela 'funcionario' para 'ALUNO'
REVOKE SELECT ON funcionario FROM 'ALUNO'@'localhost';

-- Revoga acesso de consulta (SELECT) e inserir (INSERT) da tabela 'funcionario' para 'ALUNO'
REVOKE SELECT, INSERT ON funcionario FROM 'ALUNO'@'localhost';

-- Revoga acesso de consulta (SELECT) para os campos algumas cols de 'funcionario' para 'ALUNO'
REVOKE SELECT (matricula, nome_funcionario) ON funcionario FROM  'ALUNO'@'localhost';

-- Revoga execucao de procedure proc_quadrado para 'ALUNO'
REVOKE EXECUTE ON PROCEDURE proc_quadrado FROM  'ALUNO'@'localhost';  

-- Revoga todos os acessos da tabela 'funcionario' de 'ALUNO'
REVOKE ALL PRIVILEGES ON funcionario FROM  'ALUNO'@'localhost';

-- Revoga todos os acessos de 'ALUNO'
REVOKE ALL PRIVILEGES ON * . * FROM  'ALUNO'@'localhost';

-- Recarregando/subindo privilégios (executar ao final, sempre)
FLUSH PRIVILEGES;

-- check
select * from mysql.user where User='ALUNO';
```

<table align="center"><thead><tr><th>Host</th><th>User</th><th>Select_priv</th><th>Insert_priv</th><th>Update_priv</th><th>Delete_priv</th><th>Create_priv</th><th>Drop_priv</th><th>Reload_priv</th><th>Shutdown_priv</th><th>Process_priv</th><th>File_priv</th><th>Grant_priv</th><th>References_priv</th><th>Index_priv</th><th>Alter_priv</th><th>Show_db_priv</th><th>Super_priv</th><th>Create_tmp_table_priv</th><th>Lock_tables_priv</th><th>Execute_priv</th><th>Repl_slave_priv</th><th>Repl_client_priv</th><th>Create_view_priv</th><th>Show_view_priv</th><th>Create_routine_priv</th><th>Alter_routine_priv</th><th>Create_user_priv</th><th>Event_priv</th><th>Trigger_priv</th><th>Create_tablespace_priv</th><th>ssl_type</th><th>ssl_cipher</th><th>x509_issuer</th><th>x509_subject</th><th>max_questions</th><th>max_updates</th><th>max_connections</th><th>max_user_connections</th><th>plugin</th><th>authentication_string</th><th>password_expired</th><th>password_last_changed</th><th>password_lifetime</th><th>account_locked</th><th>Create_role_priv</th><th>Drop_role_priv</th><th>Password_reuse_history</th><th>Password_reuse_time</th><th>Password_require_current</th><th>User_attributes</th></tr></thead><tbody><tr><td>localhost</td><td>ALUNO</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td>N</td><td></td><td>[BINARY]</td><td>[BINARY]</td><td>[BINARY]</td><td>0</td><td>0</td><td>0</td><td>0</td><td>caching_sha2_password</td><td>$A$005$?M*OsFoNf?=t?.4H#N@{nvWBeOgI9S01G.ioKaoAdWgymwhfuvQcJ9W7CFP3QZ3</td><td>N</td><td>2023-11-21 22:30:31</td><td></td><td>N</td><td>N</td><td>N</td></tr></tbody></table>

<h2>4. TCL</h2>

<p align="justify">
	Os comandos TCL (Transaction Control Language) são utilizados para gerenciar transações em um banco de dados. Alguns dos comandos TCL mais comuns são:
</p>

<ul>
	<li><p align="justify"><b>COMMIT: </b>É usado para confirmar as alterações feitas em uma transação e torná-las permanentes no banco de dados. Exemplo: COMMIT;</p></li>
	<li><p align="justify"><b>ROLLBACK: </b>É usado para desfazer todas as alterações feitas em uma transação e restaurar o banco de dados ao seu estado anterior. Exemplo: ROLLBACK;</p></li>
	<li><p align="justify"><b>SAVEPOINT: </b>É usado para criar um ponto de salvamento dentro de uma transação, permitindo que você retorne ao ponto específico posteriormente. Exemplo: SAVEPOINT nome_ponto;</p></li>
	<li><p align="justify"><b>RELEASE SAVEPOINT: </b>É usado para remover um ponto de salvamento dentro de uma transação. Exemplo: RELEASE SAVEPOINT nome_ponto;</p></li>
	<li><p align="justify"><b>SET TRANSACTION: </b>É usado para definir as características de uma transação, como isolamento e nível de consistência. Exemplo: SET TRANSACTION ISOLATION LEVEL READ COMMITTED;</p></li>
</ul>

<p align="justify">
	Esses são alguns exemplos dos comandos TCL mais comuns. A sintaxe e os recursos exatos podem variar dependendo do sistema de gerenciamento de banco de dados que você está utilizando. É importante consultar a documentação oficial do sistema para obter uma lista completa de comandos e opções disponíveis.
</p>

```sql
-- CRIANDO TABELA cadastro
create table cadastro
(
 nome varchar(50) not null,
 docto varchar(20) not null
 );

-- INICIA TRANSAÇÃO
START TRANSACTION;

-- INSERE REGISTROS
INSERT INTO cadastro VALUES ('Andre','12341244');
INSERT INTO cadastro VALUES ('Joao','12341248');
INSERT INTO cadastro VALUES ('Pedro','12341246');

-- EFETIVA AS INFORMACOES NA TABELAS DO BANCO DE DADOS
COMMIT;
 
select * from cadastro;
```

<table align="center"><thead><tr><th>nome</th><th>docto</th></tr></thead><tbody><tr><td>Andre</td><td>12341244</td></tr><tr><td>Joao</td><td>12341248</td></tr><tr><td>Pedro</td><td>12341246</td></tr></tbody></table>

<p align="justify">
	Caso não houvesse <b>COMMIT</b>, não haveria dados na tabela 'cadastro'.
</p>

```sql
-- CRIANDO TABELA cadastro
-- drop table cadastro;
create table cadastro
(
 nome varchar(50) not null,
 docto varchar(20) not null
 );

-- INICIA TRANSAÇÃO
START TRANSACTION;

-- INSERE REGISTROS
INSERT INTO cadastro VALUES ('Andre','12341244');
SAVEPOINT P1;
INSERT INTO cadastro VALUES ('Joao','12341248');
SAVEPOINT P2;
INSERT INTO cadastro VALUES ('Pedro','12341246');
SAVEPOINT P3;

-- RETORNA O TABELA PARA ESTADO ANTERIOR DO START TRANSACTION
ROLLBACK TO SAVEPOINT P2;

-- EFETIVA AS INFORMACOES NA TABELAS DO BANCO DE DADOS
COMMIT;

-- check
select * from cadastro;
```

<table align="center"><thead><tr><th>nome</th><th>docto</th></tr></thead><tbody><tr><td>Andre</td><td>12341244</td></tr><tr><td>Joao</td><td>12341248</td></tr></tbody></table>

<p align="justify">
	Como o <b>ROLLBACK</b> foi feito para o <b>SAVEPOINT P2</b>, o último INSERT não foi comitado. Assim, só há os 2 primeiros registros de INSERT.
</p>
