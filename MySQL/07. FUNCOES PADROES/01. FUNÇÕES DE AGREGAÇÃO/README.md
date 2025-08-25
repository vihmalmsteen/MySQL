<h2>1. FUNÇÕES DE AGREGAÇÃO</h2>

<p align="justify">
  As funções de agregação executam um cálculo em conjunto de valores e retornam um único valor. com exceção da função COUNT, as funções de agregação ignoram valores nulos. As funções de agregação normalmente são usadas com a cláusula GROUP BY (que agregam por uma determinada condição, sendo esta uma coluna). As funções de agregação podem ser usadas somente em SELECT e HAVING.
</p>

<table align="center"><thead><tr><th>FUNÇÃO</th><th>DESCRIÇÃO</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>COUNT</td><td>Retorna o número de linhas em uma determinada coluna ou o número total de linhas de uma consulta.</td><td>`SELECT coluna, COUNT(*) FROM tabela GROUP BY coluna;`</td></tr><tr><td>MIN</td><td>Retorna o valor mínimo em uma coluna.</td><td>`SELECT coluna, MIN(outra_coluna) FROM tabela GROUP BY coluna;`</td></tr><tr><td>MAX</td><td>Retorna o valor máximo em uma coluna.</td><td>`SELECT coluna, MAX(outra_coluna) FROM tabela GROUP BY coluna;`</td></tr><tr><td>SUM</td><td>Retorna a soma de valores numéricos em uma coluna.</td><td>`SELECT coluna, SUM(outra_coluna) FROM tabela GROUP BY coluna;`</td></tr><tr><td>AVG</td><td>Retorna a média de valores numéricos em uma coluna.</td><td>`SELECT coluna, AVG(outra_coluna) FROM tabela GROUP BY coluna;`</td></tr><tr><td>GROUP_CONCAT</td><td>Concatena os valores de uma coluna em uma única string, separando-os por um delimitador.</td><td>`SELECT coluna, GROUP_CONCAT(outra_coluna SEPARATOR &#39;, &#39;) FROM tabela GROUP BY coluna;`</td></tr></tbody></table>

```sql
use hospital;
select * from remedio;
```

<table align="center"><thead><tr><th>ID</th><th>nome</th><th>preco</th><th>planos_cobertos</th></tr></thead><tbody><tr><td>1</td><td>Remedio 1</td><td>10,5</td><td>AMIL,SILVESTRE</td></tr><tr><td>2</td><td>Remedio 2</td><td>20,75</td><td>AMIL</td></tr><tr><td>3</td><td>Remedio 3</td><td>15</td><td>SILVESTRE</td></tr><tr><td>4</td><td>Remedio 4</td><td>30,25</td><td>AMIL,SILVESTRE,SULAMERICA</td></tr><tr><td>5</td><td>Remedio 5</td><td>12</td><td>SULAMERICA</td></tr><tr><td>6</td><td>Remedio 6</td><td>18,5</td><td></td></tr><tr><td>7</td><td>Remedio 7</td><td>25</td><td>AMIL,SULAMERICA</td></tr><tr><td>8</td><td>Remedio 8</td><td>8,75</td><td>SILVESTRE</td></tr><tr><td>9</td><td>Remedio 9</td><td>16,5</td><td>AMIL,SULAMERICA</td></tr><tr><td>10</td><td>Remedio 10</td><td>22,5</td><td>AMIL,SILVESTRE</td></tr><tr><td>11</td><td>Remedio 11</td><td>14,25</td><td>SILVESTRE,SULAMERICA</td></tr><tr><td>12</td><td>Remedio 12</td><td>17,75</td><td>AMIL</td></tr><tr><td>13</td><td>Remedio 13</td><td>11,5</td><td>SULAMERICA</td></tr><tr><td>14</td><td>Remedio 14</td><td>19</td><td>AMIL,SILVESTRE</td></tr><tr><td>15</td><td>Remedio 15</td><td>32</td><td>AMIL,SULAMERICA</td></tr></tbody></table>

```sql
select  
  group_concat(r.`nome` separator ', ') as `group_concat`    -- concatenação dos nomes dos remédos em r.`nome`
, count(*) as `count`					     -- contagem de todos os registros da tabela
, min(r.`preco`) as `min`                                    -- valor mínimo de preco
, max(r.`preco`) as `max`                                    -- valor máximo de preco
, avg(r.`preco`) as `avg`                                    -- valor médio de preco
, sum(r.`preco`) as `sum`                                    -- soma geral de preco
from remedio r
;
```

<table align="center"><thead><tr><th>group_concat</th><th>count</th><th>min</th><th>max</th><th>avg</th><th>sum</th></tr></thead><tbody><tr><td>Remedio 1, Remedio 2, Remedio 3, Remedio 4, Remedio 5, Remedio 6, Remedio 7, Remedio 8, Remedio 9, Remedio 10, Remedio 11, Remedio 12, Remedio 13, Remedio 14, Remedio 15</td><td>15</td><td>8,75</td><td>32</td><td>18,28333333</td><td>274,25</td></tr></tbody></table>

<p align="justify">
	Acima, <b>não se usou GROUP BY</b>. Pois,  <b>intenção foi realizar contas no geral, sem agregação</b>.
</p>

```sql
-- Dos remédios prescritos:
-- (1) O nº da consulta, ou ID, da consulta a qual o remédio foi prescrito;
-- (2) Os nomes dos remédios;
-- (3) Os preços dos remédios;
-- (4) total de remédios prescritos;
-- (5) média do preço dos remédios;
-- (6) soma dos preços dos remédios;
-- (7) agrupados por especialidade do médico.

select  
  m.`especialidade`                                                 -- (7)
, group_concat(rc.`consulta_id` separator ', ') as `nº consulta`    -- (1)
, group_concat(r.`nome` separator ', ') as `remedios`               -- (2)
, group_concat(r.`preco` separator ', ') as `precos`                -- (3)
, count(*) as `contagem`                                            -- (4)
, round(avg(r.`preco`), 2) as `preco medio R$`                      -- (5)
, round(sum(r.`preco`), 2) as `total prescrito R$`                  -- (6)
from remedio r
	inner join receita rc on rc.`remedio_id` = r.`id`
	inner join consulta c on c.`id` = rc.`consulta_id`
	inner join medico m on m.`id` = c.`medico_id`
group by m.`especialidade`                                          -- (7)
order by `contagem` desc
;
```

<table align="justify"><thead><tr><th>especialidade</th><th>nº consulta</th><th>remedios</th><th>precos</th><th>contagem</th><th>preco medio R$</th><th>total prescrito R$</th></tr></thead><tbody><tr><td>cardio</td><td>1, 6, 11</td><td>Remedio 1, Remedio 6, Remedio 11</td><td>10.5, 18.5, 14.25</td><td>3</td><td>14,42</td><td>43,25</td></tr><tr><td>neuro</td><td>2, 7, 12</td><td>Remedio 2, Remedio 7, Remedio 12</td><td>20.75, 25, 17.75</td><td>3</td><td>21,17</td><td>63,5</td></tr><tr><td>psico</td><td>3, 8</td><td>Remedio 3, Remedio 8</td><td>15, 8.75</td><td>2</td><td>11,88</td><td>23,75</td></tr><tr><td>otorrino</td><td>4, 9</td><td>Remedio 4, Remedio 9</td><td>30.25, 16.5</td><td>2</td><td>23,38</td><td>46,75</td></tr><tr><td>pneumo</td><td>5, 10</td><td>Remedio 5, Remedio 10</td><td>12, 22.5</td><td>2</td><td>17,25</td><td>34,5</td></tr></tbody></table>

<p align="justify">
	Da quer acima, dois detalhes:
</p>

<ol>
	<li><p align="justify"><b>Agrupamento: </b>Sempre que se desejar agregar por algum campo/coluna, usar GROUP BY. Basicamente, <b>todas as colunas chamadas que não possuem uma operação são inseridas no GROUP BY</b> quando se deseja agregar por algum campo;</p></li>
	<li><p align="justify"><b>JOIN: </b>Como a ideia gira em torno dos remédios (preço, contagem), a <b>tabela principal, da cláusula FROM, é a tabela 'remedio'</b>.</p></li>
</ol>

<p align="justify">
	Agora, suponhamos que a consulta 11 teve seu remédio alterado para o nº 1. Fazendo um UPDATE e rodando novamente a consulta acima, teremos:
</p>

```sql
-- UPDATE (1)
update receita 
set remedio_id = 1 
where consulta_id = 11;

-- CONSULTA (2)
select  
  m.`especialidade`
, group_concat(rc.`consulta_id` separator ', ') as `nº consulta`
, group_concat(distinct r.`nome` separator ', ') as `remedios`                      -- uso de DISTINCT
, group_concat(r.`preco` separator ', ') as `precos`
, count(*) as `contagem`
, round(avg(r.`preco`), 2) as `preco medio R$`
, round(sum(r.`preco`), 2) as `total prescrito R$`
from remedio r
	inner join receita rc on rc.`remedio_id` = r.`id`
	inner join consulta c on c.`id` = rc.`consulta_id`
	inner join medico m on m.`id` = c.`medico_id`
group by m.`especialidade`
order by `contagem` desc
;
```

<table align="justify"><thead><tr><th>especialidade</th><th>nº consulta</th><th>remedios</th><th>precos</th><th>contagem</th><th>preco medio R$</th><th>total prescrito R$</th></tr></thead><tbody><tr><td>cardio</td><td>1, 6, 11</td><td>Remedio 1, Remedio 6</td><td>10.5, 18.5, 10.5</td><td>3</td><td>13,17</td><td>39,5</td></tr><tr><td>neuro</td><td>2, 7, 12</td><td>Remedio 12, Remedio 2, Remedio 7</td><td>20.75, 25, 17.75</td><td>3</td><td>21,17</td><td>63,5</td></tr><tr><td>psico</td><td>3, 8</td><td>Remedio 3, Remedio 8</td><td>15, 8.75</td><td>2</td><td>11,88</td><td>23,75</td></tr><tr><td>otorrino</td><td>4, 9</td><td>Remedio 4, Remedio 9</td><td>30.25, 16.5</td><td>2</td><td>23,38</td><td>46,75</td></tr><tr><td>pneumo</td><td>5, 10</td><td>Remedio 10, Remedio 5</td><td>12, 22.5</td><td>2</td><td>17,25</td><td>34,5</td></tr></tbody></table>

<p align="justify">
	O que ocorre é que para o 1º registro da consulta, 'cardio', há 3 consultas: 1, 6 e 11. E os remédios prescritos foram, respectivamente os 1, 6 e 1. Ou seja, o remédio 1 foi receitado duas vezes. Caso a cláusula DISTINCT dentro de GROUP_CONCAT não fosse utilizada, haveria repetição de "Remedio 1" na 1ª e 3ª posição da string. <b>Agrupar textos distintos com GROUP_CONCAT evitando repetição, usar DISTINCT</b>.
</p>

<p align="justify">
	Outra possibilidade é a utilização da cláusula WITH ROLLUP no GROUP BY. Esta cláusula gera um subtotal para o grupo no ROLLUP.
</p>

```sql
select  
  ifnull(m.`especialidade`, 'TOTAL') as `especialidade`
, group_concat(rc.`consulta_id` separator ', ') as `nº consulta`
, group_concat(distinct r.`nome` separator ', ') as `remedios`
, group_concat(r.`preco` separator ', ') as `precos`
, count(*) as `contagem`
, round(avg(r.`preco`), 2) as `preco medio R$`
, round(sum(r.`preco`), 2) as `total prescrito R$`
from remedio r
	inner join receita rc on rc.`remedio_id` = r.`id`
	inner join consulta c on c.`id` = rc.`consulta_id`
	inner join medico m on m.`id` = c.`medico_id`
group by m.`especialidade` with rollup
order by 
  case when isnull(m.`especialidade`) then 2 else 1 end
, `contagem` desc
;
```

<table align="center"><thead><tr><th>especialidade</th><th>nº consulta</th><th>remedios</th><th>precos</th><th>contagem</th><th>preco medio R$</th><th>total prescrito R$</th></tr></thead><tbody><tr><td>cardio</td><td>1, 6, 11</td><td>Remedio 1, Remedio 6</td><td>10.5, 18.5, 10.5</td><td>3</td><td>13,17</td><td>39,5</td></tr><tr><td>neuro</td><td>2, 7, 12</td><td>Remedio 12, Remedio 2, Remedio 7</td><td>20.75, 25, 17.75</td><td>3</td><td>21,17</td><td>63,5</td></tr><tr><td>psico</td><td>3, 8</td><td>Remedio 3, Remedio 8</td><td>15, 8.75</td><td>2</td><td>11,88</td><td>23,75</td></tr><tr><td>otorrino</td><td>4, 9</td><td>Remedio 4, Remedio 9</td><td>30.25, 16.5</td><td>2</td><td>23,38</td><td>46,75</td></tr><tr><td>pneumo</td><td>5, 10</td><td>Remedio 10, Remedio 5</td><td>12, 22.5</td><td>2</td><td>17,25</td><td>34,5</td></tr><tr><td>TOTAL</td><td>1, 6, 11, 2, 7, 12, 3, 8, 4, 9, 5, 10</td><td>Remedio 1, Remedio 10, Remedio 12, Remedio 2, Remedio 3, Remedio 4, Remedio 5, Remedio 6, Remedio 7, Remedio 8, Remedio 9</td><td>10.5, 18.5, 10.5, 20.75, 25, 17.75, 15, 8.75, 30.25, 16.5, 12, 22.5</td><td>12</td><td>17,33</td><td>208</td></tr></tbody></table>

<p align="justify">
	Acima, como só há agrupamento em um campo, especialidade, o subtotal é o total geral da tabela. Ainda, repare no tratamento em <b>ORDER BY</b> que aceita <b>CASE WHEN</b> e também no <b>tratamento de 'especialidade' no SELECT</b>, pois, quando há ROLLUP, o campo de subtotal retorna NULL na coluna agregada, podendo-se subtituir com <b>IFNULL</b> o retorno nulo.
</p>

<h3>1.1 Particionamento</h3>

Particionamento é aplicar funções em partes ou grupos de dados. Funciona quase como um GROUP BY, mas não há redução nas linhas retornadas. A sintaxe:

```sql
SELECT
func(col) OVER(PARTITION BY col_A, col_B, col_N ORDER BY col_X, col_Y, col_Z) AS `col`
FROM tabela
```

<p align="justify">
	No trecho, `func(col)` representa a função que se aplica em uma janela definida por `PARTITION BY col_A, col_B, col_N`. Isso significa que a função será aplicada separadamente para cada combinação distinta dos valores das colunas col_A, col_B e col_N. Além disso, a cláusula `ORDER BY col_X, col_Y, col_Z` é usada para especificar a ordem em que as linhas serão processadas dentro de cada partição. Essa ordem pode influenciar o comportamento da função OVER, pois algumas funções podem ter resultados diferentes dependendo da ordem. Por fim, `AS col` é um alias opcional que você pode usar para dar um nome à coluna resultante. Isso pode ser útil ao selecionar os resultados da consulta.	
</p>

```sql
-- GROUP BY `planos_cobertos` -> registros são agrupados por planos
select 
  planos_cobertos
, sum(preco) as `soma`
from remedio 
group by planos_cobertos
order by `soma` desc
;
```

<table align="center"><thead><tr><th>planos_cobertos</th><th>soma</th></tr></thead><tbody><tr><td>AMIL,SULAMERICA</td><td>73,5</td></tr><tr><td>AMIL,SILVESTRE</td><td>52</td></tr><tr><td>AMIL</td><td>38,5</td></tr><tr><td>AMIL,SILVESTRE,SULAMERICA</td><td>30,25</td></tr><tr><td>SILVESTRE</td><td>23,75</td></tr><tr><td>SULAMERICA</td><td>23,5</td></tr><tr><td></td><td>18,5</td></tr><tr><td>SILVESTRE,SULAMERICA</td><td>14,25</td></tr></tbody></table>

```sql
-- OVER(partition by `planos_cobertos`) -> todos os registros retornam e a soma ocorre nos grupos de planos.
select 
  planos_cobertos
, sum(preco) over(partition by planos_cobertos) as `soma`
from remedio
order by `soma` desc
;
```

<table align="center"><thead><tr><th>planos_cobertos</th><th>soma</th></tr></thead><tbody><tr><td>AMIL,SULAMERICA</td><td>73,5</td></tr><tr><td>AMIL,SULAMERICA</td><td>73,5</td></tr><tr><td>AMIL,SULAMERICA</td><td>73,5</td></tr><tr><td>AMIL,SILVESTRE</td><td>52</td></tr><tr><td>AMIL,SILVESTRE</td><td>52</td></tr><tr><td>AMIL,SILVESTRE</td><td>52</td></tr><tr><td>AMIL</td><td>38,5</td></tr><tr><td>AMIL</td><td>38,5</td></tr><tr><td>AMIL,SILVESTRE,SULAMERICA</td><td>30,25</td></tr><tr><td>SILVESTRE</td><td>23,75</td></tr><tr><td>SILVESTRE</td><td>23,75</td></tr><tr><td>SULAMERICA</td><td>23,5</td></tr><tr><td>SULAMERICA</td><td>23,5</td></tr><tr><td></td><td>18,5</td></tr><tr><td>SILVESTRE,SULAMERICA</td><td>14,25</td></tr></tbody></table>

<p align="justify">Várias funções podem conter cláusula de particionamento <b>OVER</b> como SUM, AVG, COUNT. Mas, nem todas aceitam, como o caso de GROUP_CONCAT. Neste último caso, a solução é trabalhar com ARRAYS JSON com a função JSON_ARRAYAGG.</p>

```sql
select
  r.*
, count(*) over(partition by r.`planos_cobertos`) as `count/plano`
, avg(r.`preco`) over(partition by r.`planos_cobertos`) as `avg/plano`
, json_arrayagg(r.`nome`) over(partition by r.`planos_cobertos`) as `json_arrayagg`
from remedio r;
```

<table align="justify"><thead><tr><th>ID</th><th>nome</th><th>preco</th><th>planos_cobertos</th><th>count/plano</th><th>avg/plano</th><th>json_arrayagg</th></tr></thead><tbody><tr><td>6</td><td>Remedio 6</td><td>18,5</td><td></td><td>1</td><td>18,5</td><td>[&quot;Remedio 6&quot;]</td></tr><tr><td>2</td><td>Remedio 2</td><td>20,75</td><td>AMIL</td><td>2</td><td>19,25</td><td>[&quot;Remedio 2&quot;, &quot;Remedio 12&quot;]</td></tr><tr><td>12</td><td>Remedio 12</td><td>17,75</td><td>AMIL</td><td>2</td><td>19,25</td><td>[&quot;Remedio 2&quot;, &quot;Remedio 12&quot;]</td></tr><tr><td>1</td><td>Remedio 1</td><td>10,5</td><td>AMIL,SILVESTRE</td><td>3</td><td>17,33333333</td><td>[&quot;Remedio 1&quot;, &quot;Remedio 10&quot;, &quot;Remedio 14&quot;]</td></tr><tr><td>10</td><td>Remedio 10</td><td>22,5</td><td>AMIL,SILVESTRE</td><td>3</td><td>17,33333333</td><td>[&quot;Remedio 1&quot;, &quot;Remedio 10&quot;, &quot;Remedio 14&quot;]</td></tr><tr><td>14</td><td>Remedio 14</td><td>19</td><td>AMIL,SILVESTRE</td><td>3</td><td>17,33333333</td><td>[&quot;Remedio 1&quot;, &quot;Remedio 10&quot;, &quot;Remedio 14&quot;]</td></tr><tr><td>4</td><td>Remedio 4</td><td>30,25</td><td>AMIL,SILVESTRE,SULAMERICA</td><td>1</td><td>30,25</td><td>[&quot;Remedio 4&quot;]</td></tr><tr><td>7</td><td>Remedio 7</td><td>25</td><td>AMIL,SULAMERICA</td><td>3</td><td>24,5</td><td>[&quot;Remedio 7&quot;, &quot;Remedio 9&quot;, &quot;Remedio 15&quot;]</td></tr><tr><td>9</td><td>Remedio 9</td><td>16,5</td><td>AMIL,SULAMERICA</td><td>3</td><td>24,5</td><td>[&quot;Remedio 7&quot;, &quot;Remedio 9&quot;, &quot;Remedio 15&quot;]</td></tr><tr><td>15</td><td>Remedio 15</td><td>32</td><td>AMIL,SULAMERICA</td><td>3</td><td>24,5</td><td>[&quot;Remedio 7&quot;, &quot;Remedio 9&quot;, &quot;Remedio 15&quot;]</td></tr><tr><td>3</td><td>Remedio 3</td><td>15</td><td>SILVESTRE</td><td>2</td><td>11,875</td><td>[&quot;Remedio 3&quot;, &quot;Remedio 8&quot;]</td></tr><tr><td>8</td><td>Remedio 8</td><td>8,75</td><td>SILVESTRE</td><td>2</td><td>11,875</td><td>[&quot;Remedio 3&quot;, &quot;Remedio 8&quot;]</td></tr><tr><td>11</td><td>Remedio 11</td><td>14,25</td><td>SILVESTRE,SULAMERICA</td><td>1</td><td>14,25</td><td>[&quot;Remedio 11&quot;]</td></tr><tr><td>5</td><td>Remedio 5</td><td>12</td><td>SULAMERICA</td><td>2</td><td>11,75</td><td>[&quot;Remedio 5&quot;, &quot;Remedio 13&quot;]</td></tr><tr><td>13</td><td>Remedio 13</td><td>11,5</td><td>SULAMERICA</td><td>2</td><td>11,75</td><td>[&quot;Remedio 5&quot;, &quot;Remedio 13&quot;]</td></tr></tbody></table>

<h4>1.2 PARTITION BY vs ORDER BY</h4>

<p align="justify">
	A cláusula PARTITION BY é para partitionar dentro de algum critério, enquanto ORDER BY é para ordenar a agregação de forma acumulada. Exemplo: com o DB 'lojinha' na tabela 'produtos', acumular os valores dos preços por tipo:
</p>

```sql
SELECT 
  p.*
, count(*) over(PARTITION BY p.tipo ORDER BY p.id) AS `contagemAc`
FROM produtos p
;
```

<table align="center"><thead><tr><th>id</th><th>produto</th><th>tipo</th><th>preco</th><th>contagemAc</th></tr></thead><tbody><tr><td>4</td><td>ovo</td><td>animais</td><td>1,1</td><td>1</td></tr><tr><td>7</td><td>café</td><td>bebidas</td><td>1,3</td><td>1</td></tr><tr><td>9</td><td>suco</td><td>bebidas</td><td>0,8</td><td>2</td></tr><tr><td>5</td><td>presunto</td><td>frios</td><td>2,4</td><td>1</td></tr><tr><td>6</td><td>queijo</td><td>frios</td><td>1,8</td><td>2</td></tr><tr><td>8</td><td>mortadela</td><td>frios</td><td>1,2</td><td>3</td></tr><tr><td>10</td><td>banana</td><td>frutas</td><td>0,75</td><td>1</td></tr><tr><td>11</td><td>maça</td><td>frutas</td><td>0,55</td><td>2</td></tr><tr><td>2</td><td>leite</td><td>lacteos</td><td>1,4</td><td>1</td></tr><tr><td>3</td><td>manteiga</td><td>lacteos</td><td>1,35</td><td>2</td></tr><tr><td>1</td><td>pao</td><td>padaria</td><td>1,2</td><td>1</td></tr></tbody></table>

