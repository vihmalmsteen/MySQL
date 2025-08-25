<h2>3. FUNÇÕES DE CLASSIFICAÇÃO</h2>

<p align="justify">
	Funções que dão ordenação ou separam em grupos. Algumas:
</p>

<table align="center"><thead><tr><th>FUNÇÃO</th><th>DESCRIÇÃO</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>ROW_NUMBER</td><td>Atribui um número sequencial a cada linha retornada em um conjunto de resultados.</td><td>SELECT ROW_NUMBER() OVER (ORDER BY id) AS row_num, id, name FROM tabela</td></tr><tr><td>RANK</td><td>Atribui um número de classificação a cada linha com base em uma coluna especificada.</td><td>SELECT RANK() OVER (ORDER BY score DESC) AS rank, name, score FROM tabela</td></tr><tr><td>DENSE_RANK</td><td>Atribui um número de classificação a cada linha, sem pular números classificados em caso de empate.</td><td>SELECT DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank, name, salary FROM tabela</td></tr><tr><td>NTILE</td><td>Distribui as linhas em grupos com base em um número definido e atribui um número a cada grupo.</td><td>SELECT NTILE(4) OVER (ORDER BY age) AS ntile_group, name, age FROM tabela</td></tr></tbody></table>

select 
  p.*
, row_number() over() as `row_number`
, rank() over(order by p.`nome`) as `rank`
, dense_rank() over(order by p.`plano`) as `dense_rank`
, ntile(4) over() as `ntile_4`
from paciente p
order by p.`id`
;

<table align="center"><thead><tr><th>id</th><th>nome</th><th>cpf</th><th>plano</th><th>row_number</th><th>rank</th><th>dense_rank</th><th>ntile_4</th></tr></thead><tbody><tr><td>1</td><td>Fulano Silva</td><td>11111111111</td><td>AMIL</td><td>1</td><td>4</td><td>1</td><td>1</td></tr><tr><td>2</td><td>Cicrano Souza</td><td>22222222222</td><td>SILVESTRE</td><td>2</td><td>3</td><td>2</td><td>2</td></tr><tr><td>3</td><td>Beltrano Oliveira</td><td>33333333333</td><td>SULAMERICA</td><td>3</td><td>2</td><td>3</td><td>4</td></tr><tr><td>4</td><td>Maria Rodrigues</td><td>44444444444</td><td>AMIL</td><td>4</td><td>6</td><td>1</td><td>1</td></tr><tr><td>5</td><td>José Pereira</td><td>55555555555</td><td>SILVESTRE</td><td>5</td><td>5</td><td>2</td><td>2</td></tr><tr><td>6</td><td>Ana Silva</td><td>66666666666</td><td>SULAMERICA</td><td>6</td><td>1</td><td>3</td><td>3</td></tr><tr><td>7</td><td>Paulo Santos</td><td>77777777777</td><td>AMIL</td><td>7</td><td>8</td><td>1</td><td>1</td></tr><tr><td>8</td><td>Mariana Oliveira</td><td>88888888888</td><td>SILVESTRE</td><td>8</td><td>7</td><td>2</td><td>3</td></tr><tr><td>9</td><td>Pedro Gomes</td><td>99999999999</td><td>SULAMERICA</td><td>9</td><td>9</td><td>3</td><td>4</td></tr></tbody></table>

<p align="justify">
	<b>DENSE_RANK</b> no geral é mais aplicável que <b>RANK</b>. O último <b>ORDER BY</b> é necessário para manter a classificação. Caso contrário, a última ordenação dentro do último <b>OVER</b> será a ordenação da tabela. Um ponto importante é que estas funções, por natureza, utilizam a cláusula <b>OVER</b>, o que significa que elas trabalham com particionamento. Sendo a sintaxe <b>básica de colunas particionadas</b>:
</p>

```sql
SELECT
func(col) OVER(PARTITION BY col_A, col_B, col_N ORDER BY col_X, col_Y, col_Z) AS `col`
FROM tabela
```

<p align="justify">Ainda, outras funções também podem conter cláusula de particionamento <b>OVER</b> como SUM, AVG, COUNT. Mas, nem todas aceitam, como o caso de GROUP_CONCAT. Neste último caso, a solução é trabalhar com ARRAYS JSON com a função JSON_ARRAYAGG.</p>

```sql
select
  r.*
, count(*) over(partition by r.`planos_cobertos`) as `count/plano`
, avg(r.`preco`) over(partition by r.`planos_cobertos`) as `avg/plano`
, json_arrayagg(r.`nome`) over(partition by r.`planos_cobertos`) as `json_arrayagg`
from remedio r;
```

<table align="justify"><thead><tr><th>ID</th><th>nome</th><th>preco</th><th>planos_cobertos</th><th>count/plano</th><th>avg/plano</th><th>json_arrayagg</th></tr></thead><tbody><tr><td>6</td><td>Remedio 6</td><td>18,5</td><td></td><td>1</td><td>18,5</td><td>[&quot;Remedio 6&quot;]</td></tr><tr><td>2</td><td>Remedio 2</td><td>20,75</td><td>AMIL</td><td>2</td><td>19,25</td><td>[&quot;Remedio 2&quot;, &quot;Remedio 12&quot;]</td></tr><tr><td>12</td><td>Remedio 12</td><td>17,75</td><td>AMIL</td><td>2</td><td>19,25</td><td>[&quot;Remedio 2&quot;, &quot;Remedio 12&quot;]</td></tr><tr><td>1</td><td>Remedio 1</td><td>10,5</td><td>AMIL,SILVESTRE</td><td>3</td><td>17,33333333</td><td>[&quot;Remedio 1&quot;, &quot;Remedio 10&quot;, &quot;Remedio 14&quot;]</td></tr><tr><td>10</td><td>Remedio 10</td><td>22,5</td><td>AMIL,SILVESTRE</td><td>3</td><td>17,33333333</td><td>[&quot;Remedio 1&quot;, &quot;Remedio 10&quot;, &quot;Remedio 14&quot;]</td></tr><tr><td>14</td><td>Remedio 14</td><td>19</td><td>AMIL,SILVESTRE</td><td>3</td><td>17,33333333</td><td>[&quot;Remedio 1&quot;, &quot;Remedio 10&quot;, &quot;Remedio 14&quot;]</td></tr><tr><td>4</td><td>Remedio 4</td><td>30,25</td><td>AMIL,SILVESTRE,SULAMERICA</td><td>1</td><td>30,25</td><td>[&quot;Remedio 4&quot;]</td></tr><tr><td>7</td><td>Remedio 7</td><td>25</td><td>AMIL,SULAMERICA</td><td>3</td><td>24,5</td><td>[&quot;Remedio 7&quot;, &quot;Remedio 9&quot;, &quot;Remedio 15&quot;]</td></tr><tr><td>9</td><td>Remedio 9</td><td>16,5</td><td>AMIL,SULAMERICA</td><td>3</td><td>24,5</td><td>[&quot;Remedio 7&quot;, &quot;Remedio 9&quot;, &quot;Remedio 15&quot;]</td></tr><tr><td>15</td><td>Remedio 15</td><td>32</td><td>AMIL,SULAMERICA</td><td>3</td><td>24,5</td><td>[&quot;Remedio 7&quot;, &quot;Remedio 9&quot;, &quot;Remedio 15&quot;]</td></tr><tr><td>3</td><td>Remedio 3</td><td>15</td><td>SILVESTRE</td><td>2</td><td>11,875</td><td>[&quot;Remedio 3&quot;, &quot;Remedio 8&quot;]</td></tr><tr><td>8</td><td>Remedio 8</td><td>8,75</td><td>SILVESTRE</td><td>2</td><td>11,875</td><td>[&quot;Remedio 3&quot;, &quot;Remedio 8&quot;]</td></tr><tr><td>11</td><td>Remedio 11</td><td>14,25</td><td>SILVESTRE,SULAMERICA</td><td>1</td><td>14,25</td><td>[&quot;Remedio 11&quot;]</td></tr><tr><td>5</td><td>Remedio 5</td><td>12</td><td>SULAMERICA</td><td>2</td><td>11,75</td><td>[&quot;Remedio 5&quot;, &quot;Remedio 13&quot;]</td></tr><tr><td>13</td><td>Remedio 13</td><td>11,5</td><td>SULAMERICA</td><td>2</td><td>11,75</td><td>[&quot;Remedio 5&quot;, &quot;Remedio 13&quot;]</td></tr></tbody></table>
