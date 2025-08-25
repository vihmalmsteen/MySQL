<h2>9. FUNÇÕES DE INFORMAÇÕES</h2>

<p align="justify">
	Retornam informações do sistema. Como variáveis, usuários, setups do sistema, etc. Segue:
</p>

<table align="center"><thead><tr><th>FUNÇÃO</th><th>DESCRIÇÃO</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>CHARSET</td><td>Retorna o conjunto de caracteres usado</td><td>SELECT CHARSET(&#39;utf8mb4&#39;)</td></tr><tr><td>COLLATION</td><td>Retorna a colação do banco de dados</td><td>SELECT COLLATION(&#39;my_database&#39;)</td></tr><tr><td>CONNECTION_ID</td><td>Retorna o ID da conexão atual</td><td>SELECT CONNECTION_ID()</td></tr><tr><td>CURRENT_USER</td><td>Retorna o usuário atual</td><td>SELECT CURRENT_USER()</td></tr><tr><td>DATABASE</td><td>Retorna o nome do banco de dados atual</td><td>SELECT DATABASE()</td></tr><tr><td>FOUND_ROWS</td><td>Retorna o número de linhas afetadas</td><td>SELECT FOUND_ROWS()</td></tr><tr><td>LAST_INSERT_ID</td><td>Retorna o último ID inserido</td><td>SELECT LAST_INSERT_ID()</td></tr><tr><td>SCHEMA</td><td>Retorna o nome do banco de dados atual</td><td>SELECT SCHEMA()</td></tr><tr><td>SESSION_USER</td><td>Retorna o usuário da sessão atual</td><td>SELECT SESSION_USER()</td></tr><tr><td>SYSTEM_USER</td><td>Retorna o usuário do sistema</td><td>SELECT SYSTEM_USER()</td></tr><tr><td>USER</td><td>Retorna o usuário atual</td><td>SELECT USER()</td></tr><tr><td>VERSION</td><td>Retorna a versão do banco de dados</td><td>SELECT VERSION()</td></tr></tbody></table>

```sql
select 
  charset('á')
, collation('hospital')
, connection_id()
, current_user()
, database()
, schema()
, last_insert_id()
, session_user()
, system_user()
, user()
, version();
```

<table align="justify"><thead><tr><th>charset(&#39;á&#39;)</th><th>collation(&#39;hospital&#39;)</th><th>connection_id()</th><th>current_user()</th><th>database()</th><th>schema()</th><th>last_insert_id()</th><th>session_user()</th><th>system_user()</th><th>user()</th><th>version()</th></tr></thead><tbody><tr><td>utf8mb4</td><td>utf8mb4_0900_ai_ci</td><td>59</td><td>root@localhost</td><td>hospital</td><td>hospital</td><td>0</td><td>root@localhost</td><td>root@localhost</td><td>root@localhost</td><td>8.0.32</td></tr></tbody></table>

<p align="justify">
	Enquanto <b>COLLATION</b> retorna a colação, <b>COLLATE</b> pode ser usada para converter a colação. Podendo ser usada em SELECT por exemplo. Mas, o conjunto de caracteres em uso deve ser válido para a colação.
</p>

```sql
select 
  nome as `remedio`
, collation(nome) as `Collation`
, nome collate utf8mb4_general_ci as `collate`
, collation(nome collate utf8mb4_general_ci) as `collation_collate`
from remedio
limit 4
;
```

<table align="center"><thead><tr><th>remedio</th><th>Collation</th><th>collate</th><th>collation_collate</th></tr></thead><tbody><tr><td>Remedio 1</td><td>utf8mb4_0900_ai_ci</td><td>Remedio 1</td><td>utf8mb4_general_ci</td></tr><tr><td>Remedio 2</td><td>utf8mb4_0900_ai_ci</td><td>Remedio 2</td><td>utf8mb4_general_ci</td></tr><tr><td>Remedio 3</td><td>utf8mb4_0900_ai_ci</td><td>Remedio 3</td><td>utf8mb4_general_ci</td></tr><tr><td>Remedio 4</td><td>utf8mb4_0900_ai_ci</td><td>Remedio 4</td><td>utf8mb4_general_ci</td></tr></tbody></table>

