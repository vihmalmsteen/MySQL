<h2>1. Operadores de comparação</h2>

<table align="center"><thead><tr><th>Operador SQL</th><th>Descrição</th></tr></thead><tbody><tr><td>&gt;</td><td>Maior que</td></tr><tr><td>&lt;</td><td>Menor que</td></tr><tr><td>&lt;=</td><td>Menor ou igual a</td></tr><tr><td>&gt;=</td><td>Maior ou igual a</td></tr><tr><td>&lt;&gt;</td><td>Diferente de</td></tr></tbody></table>

```sql
-- usando operador =
SELECT * FROM remedio
WHERE ID = 3;
```

```plainText
+----+-----------+-------+-----------------+
| ID | nome      | preco | planos_cobertos |
+----+-----------+-------+-----------------+
| 3  | Remedio 3 | 15.0  | SILVESTRE       |
+----+-----------+-------+-----------------+
```

```sql
-- usando o operador >
SELECT * FROM remedio
WHERE preco > 20;
```

```plainText
+----+------------+-------+---------------------------+
| ID | nome       | preco | planos_cobertos           |
+----+------------+-------+---------------------------+
| 2  | Remedio 2  | 20.75 | AMIL                      |
| 4  | Remedio 4  | 30.25 | AMIL,SILVESTRE,SULAMERICA |
| 7  | Remedio 7  | 25.0  | AMIL,SULAMERICA           |
| 10 | Remedio 10 | 22.5  | AMIL,SILVESTRE            |
| 15 | Remedio 15 | 32.0  | AMIL,SULAMERICA           |
+----+------------+-------+---------------------------+
```

```sql
-- Usando operador < 
SELECT * FROM remedio
WHERE  preco < 12; 
```

```plainText
+----+------------+-------+-----------------+
| ID | nome       | preco | planos_cobertos |
+----+------------+-------+-----------------+
| 1  | Remedio 1  | 10.5  | AMIL,SILVESTRE  |
| 8  | Remedio 8  | 8.75  | SILVESTRE       |
| 13 | Remedio 13 | 11.5  | SULAMERICA      |
+----+------------+-------+-----------------+
```

```sql
-- Usando operador <= 
SELECT * FROM remedio
WHERE preco <= 11.5;
```

```plainText
+----+------------+-------+-----------------+
| ID | nome       | preco | planos_cobertos |
+----+------------+-------+-----------------+
| 1  | Remedio 1  | 10.5  | AMIL,SILVESTRE  |
| 8  | Remedio 8  | 8.75  | SILVESTRE       |
| 13 | Remedio 13 | 11.5  | SULAMERICA      |
+----+------------+-------+-----------------+
```

```sql
-- Usando operador >= 
SELECT * FROM remedio
WHERE preco >= 22.5;
```

```plainText
+----+------------+-------+---------------------------+
| ID | nome       | preco | planos_cobertos           |
+----+------------+-------+---------------------------+
| 4  | Remedio 4  | 30.25 | AMIL,SILVESTRE,SULAMERICA |
| 7  | Remedio 7  | 25.0  | AMIL,SULAMERICA           |
| 10 | Remedio 10 | 22.5  | AMIL,SILVESTRE            |
| 15 | Remedio 15 | 32.0  | AMIL,SULAMERICA           |
+----+------------+-------+---------------------------+
```

```sql
-- Usando operador <> 
select * from paciente
where plano <> 'AMIL';
```

```plainText
+----+-------------------+-------------+------------+
| id | nome              | cpf         | plano      |
+----+-------------------+-------------+------------+
| 2  | Cicrano Souza     | 22222222222 | SILVESTRE  |
| 3  | Beltrano Oliveira | 33333333333 | SULAMERICA |
| 5  | José Pereira      | 55555555555 | SILVESTRE  |
| 6  | Ana Silva         | 66666666666 | SULAMERICA |
| 8  | Mariana Oliveira  | 88888888888 | SILVESTRE  |
| 9  | Pedro Gomes       | 99999999999 | SULAMERICA |
+----+-------------------+-------------+------------+
```

```sql
-- Usando parenteses 
select * from paciente
where (plano = 'AMIL' or plano = 'SILVESTRE');
```

```plainText
+----+------------------+-------------+-----------+
| id | nome             | cpf         | plano     |
+----+------------------+-------------+-----------+
| 1  | Fulano da Silva  | 11111111111 | AMIL      |
| 2  | Cicrano Souza    | 22222222222 | SILVESTRE |
| 4  | Maria Rodrigues  | 44444444444 | AMIL      |
| 5  | José Pereira     | 55555555555 | SILVESTRE |
| 7  | Paulo Santos     | 77777777777 | AMIL      |
| 8  | Mariana Oliveira | 88888888888 | SILVESTRE |
+----+------------------+-------------+-----------+
```

```sql
select * from paciente
where id = 3
  or (plano = 'AMIL' or plano = 'SILVESTRE');
```

```plainText
+----+-------------------+-------------+------------+
| id | nome              | cpf         | plano      |
+----+-------------------+-------------+------------+
| 1  | Fulano da Silva   | 11111111111 | AMIL       |
| 2  | Cicrano Souza     | 22222222222 | SILVESTRE  |
| 3  | Beltrano Oliveira | 33333333333 | SULAMERICA |
| 4  | Maria Rodrigues   | 44444444444 | AMIL       |
| 5  | José Pereira      | 55555555555 | SILVESTRE  |
| 7  | Paulo Santos      | 77777777777 | AMIL       |
| 8  | Mariana Oliveira  | 88888888888 | SILVESTRE  |
+----+-------------------+-------------+------------+
```

<h2>2. Operadores matemáticos</h2>

<table align="center"><thead><tr><th>Operador SQL</th><th>Descrição</th></tr></thead><tbody><tr><td>+</td><td>Adição</td></tr><tr><td>-</td><td>Subtração</td></tr><tr><td>/</td><td>Divisão</td></tr><tr><td>*</td><td>Multiplicação</td></tr><tr><td>%</td><td>Módulo (resto da divisão)</td></tr></tbody></table>

```sql
select 2 + 3 as soma;            -- resp.: 5
select 2 - 3 as subtracao;       -- resp.: -1
select 4 / 2 as divisao;         -- resp.: 2
select 2 * 3 as multiplicacao;   -- resp.: 6
select 7 % 3 as resto;           -- resp.: 1
```

<h2>3. Operadores lógicos</h2>

<table align="center"><thead><tr><th>Operador SQL</th><th>Descrição</th></tr></thead><tbody><tr><td>WHERE</td><td>Utilizado para filtrar os registros de uma consulta</td></tr><tr><td>IN</td><td>Verifica se um valor está presente em uma lista de valores</td></tr><tr><td>BETWEEN</td><td>Verifica se um valor está dentro de um intervalo</td></tr><tr><td>AND</td><td>Operador lógico que retorna verdadeiro se todas as condições forem verdadeiras</td></tr><tr><td>OR</td><td>Operador lógico que retorna verdadeiro se pelo menos uma das condições for verdadeira</td></tr><tr><td>LIKE</td><td>Utilizado para encontrar padrões em uma coluna de texto</td></tr><tr><td>REGEXP</td><td>Utilizado para encontrar padrões utilizando expressões regulares</td></tr><tr><td>ISNULL</td><td>Verifica se um valor é nulo</td></tr><tr><td>HAVING</td><td>Utilizado para filtrar os resultados de uma consulta após a cláusula GROUP BY</td></tr></tbody></table>

```sql
-- operador 1
-- where
select * from medico
where id = 1;
```

```plainText
+----+-----------------+-------+---------------+
| id | nome            | crm   | especialidade |
+----+-----------------+-------+---------------+
| 1  | Dr. João Santos | 11111 | cardio        |
+----+-----------------+-------+---------------+
```

```sql
-- operador 2
-- in
select * from medico
where id in (1, 2, 3);
```

```plainText
+----+-------------------+-------+---------------+
| id | nome              | crm   | especialidade |
+----+-------------------+-------+---------------+
| 1  | Dr. João Santos   | 11111 | cardio        |
| 2  | Dra. Maria Silva  | 22222 | neuro         |
| 3  | Dr. Pedro Barbosa | 33333 | psico         |
+----+-------------------+-------+---------------+
```

```sql
-- not in
select * from medico
where id not in (1, 2, 3);
```

```plainText
+----+-------------------+-------+---------------+
| id | nome              | crm   | especialidade |
+----+-------------------+-------+---------------+
| 4  | Dra. Ana Oliveira | 44444 | otorrino      |
| 5  | Dr. Carlos Gomes  | 55555 | pneumo        |
+----+-------------------+-------+---------------+
```

```sql
-- operador 3
-- and
select * from medico
where id between 1 and 3;
```

```plainText
+----+-------------------+-------+---------------+
| id | nome              | crm   | especialidade |
+----+-------------------+-------+---------------+
| 1  | Dr. João Santos   | 11111 | cardio        |
| 2  | Dra. Maria Silva  | 22222 | neuro         |
| 3  | Dr. Pedro Barbosa | 33333 | psico         |
+----+-------------------+-------+---------------+
```

```sql
-- and simulanto between
select * from remedio
where preco >= 15 and preco <= 20;   -- igual ao between
```

```plainText
+----+------------+-------+-----------------+
| id | nome       | preco | planos_cobertos |
+----+------------+-------+-----------------+
| 3  | Remedio 3  | 15.0  | SILVESTRE       |
| 6  | Remedio 6  | 18.5  |                 |
| 9  | Remedio 9  | 16.5  | AMIL,SULAMERICA |
| 12 | Remedio 12 | 17.75 | AMIL            |
| 14 | Remedio 14 | 19.0  | AMIL,SILVESTRE  |
+----+------------+-------+-----------------+
```

```sql
-- operador 5
-- or
select * from paciente
where plano = 'AMIL' or plano = 'SILVESTRE'
```

```plainText
+----+------------------+-------------+-----------+
| id | nome             | cpf         | plano     |
+----+------------------+-------------+-----------+
| 1  | Fulano da Silva  | 11111111111 | AMIL      |
| 2  | Cicrano Souza    | 22222222222 | SILVESTRE |
| 4  | Maria Rodrigues  | 44444444444 | AMIL      |
| 5  | José Pereira     | 55555555555 | SILVESTRE |
| 7  | Paulo Santos     | 77777777777 | AMIL      |
| 8  | Mariana Oliveira | 88888888888 | SILVESTRE |
+----+------------------+-------------+-----------+
```

```sql
-- operador 6
-- like
-- começa com 'Dr.'
select * from medico
where nome like 'Dr.%';
```

```plainText
+----+-------------------+-------+---------------+
| id | nome              | cpf   | especialidade |
+----+-------------------+-------+---------------+
| 1  | Dr. João Santos   | 11111 | cardio        |
| 3  | Dr. Pedro Barbosa | 33333 | psico         |
| 5  | Dr. Carlos Gomes  | 55555 | pneumo        |
+----+-------------------+-------+---------------+
```

```sql
-- termina com 'Santos'
select * from medico
where nome like '%Santos';
```

```plainText
+----+-----------------+-------+---------------+
| id | nome            | cpf   | especialidade |
+----+-----------------+-------+---------------+
| 1  | Dr. João Santos | 11111 | cardio        |
+----+-----------------+-------+---------------+
```

```sql
-- que tem 'Ana'
select * from medico
where nome like '%Ana%';
```

```plainText
+----+-------------------+-------+---------------+
| id | nome              | cpf   | especialidade |
+----+-------------------+-------+---------------+
| 4  | Dra. Ana Oliveira | 44444 | otorrino      |
+----+-------------------+-------+---------------+
```

```sql
-- que tem 'a.' an 3ª posicao
select * from medico
where nome like '__a.%';  -- cada underline é uma posicao
```

```plainText
+----+-------------------+-------+---------------+
| id | nome              | cpf   | especialidade |
+----+-------------------+-------+---------------+
| 2  | Dra. Maria Silva  | 22222 | neuro         |
| 4  | Dra. Ana Oliveira | 44444 | otorrino      |
+----+-------------------+-------+---------------+
```

```sql
-- operador 7
-- regexp
select * from medico
where nome regexp ('Dra.');
```

```plainText
+----+-------------------+-------+---------------+
| id | nome              | cpf   | especialidade |
+----+-------------------+-------+---------------+
| 2  | Dra. Maria Silva  | 22222 | neuro         |
| 4  | Dra. Ana Oliveira | 44444 | otorrino      |
+----+-------------------+-------+---------------+
```

```sql
-- operador 8
-- is not null
select * from remedio
where planos_cobertos is not null;      -- ou isnull(planos_cobertos) <> 1
```

```plainText
+----+------------+-------+---------------------------+
| ID | nome       | preco | planos_cobertos           |
+----+------------+-------+---------------------------+
| 1  | Remedio 1  | 10.5  | AMIL,SILVESTRE            |
| 2  | Remedio 2  | 20.75 | AMIL                      |
| 3  | Remedio 3  | 15.0  | SILVESTRE                 |
| 4  | Remedio 4  | 30.25 | AMIL,SILVESTRE,SULAMERICA |
| 5  | Remedio 5  | 12.0  | SULAMERICA                |
| 7  | Remedio 7  | 25.0  | AMIL,SULAMERICA           |
| 8  | Remedio 8  | 8.75  | SILVESTRE                 |
| 9  | Remedio 9  | 16.5  | AMIL,SULAMERICA           |
| 10 | Remedio 10 | 22.5  | AMIL,SILVESTRE            |
| 11 | Remedio 11 | 14.25 | SILVESTRE,SULAMERICA      |
| 12 | Remedio 12 | 17.75 | AMIL                      |
| 13 | Remedio 13 | 11.5  | SULAMERICA                |
| 14 | Remedio 14 | 19.0  | AMIL,SILVESTRE            |
| 15 | Remedio 15 | 32.0  | AMIL,SULAMERICA           |
+----+------------+-------+---------------------------+
```

```sql
-- is null
select * from remedio
where planos_cobertos is null;         -- ou isnull(planos_cobertos) <> 0
```

```plainText
+----+-----------+-------+-----------------+
| ID | nome      | preco | planos_cobertos |
+----+-----------+-------+-----------------+
| 6  | Remedio 6 | 18.5  | NULL            |
+----+-----------+-------+-----------------+
```

```sql
-- operador 9
-- having
-- soma total do preco dos remedios e seus planos cobertos
select
  group_concat(r.nome separator ', ') as remedios
, r.planos_cobertos as planos
, sum(r.preco) as total
from remedio r
group by r.planos_cobertos
having total >= 30
order by total desc;
```

```plainText
+-----------------------------------+---------------------------+-------+
| remedios                          | planos                    | total |
+-----------------------------------+---------------------------+-------+
| Remedio 7, Remedio 9, Remedio 15  | AMIL,SULAMERICA           | 73.5  |
| Remedio 1, Remedio 10, Remedio 14 | AMIL,SILVESTRE            | 52.0  |
| Remedio 2, Remedio 12             | AMIL                      | 38.5  |
| Remedio 4                         | AMIL,SILVESTRE,SULAMERICA | 30.25 |
+-----------------------------------+---------------------------+-------+
```
