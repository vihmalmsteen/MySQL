<h2>1. UNION e UNION ALL</h2>

<p align="justify">
  Concatenam o resultado de duas consultas (queries) em um só, colando os resultados um abaixo do outro. Para isso, ambas as consultas devem ter a mesma quantidade de colunas e com os mesmos nomes. A diferença entre UNION e UNION ALL está relacionada à forma como as consultas combinam os resultados das consultas individuais.
</p>

<ul>
  <li><p align="justify"><b>UNION: </b>O operador UNION é usado para combinar o resultado de duas ou mais consultas em um único conjunto de resultados. Ele elimina automaticamente quaisquer linhas duplicadas do conjunto de resultados combinado. Cada consulta individual deve ter a mesma quantidade de colunas e os tipos de dados correspondentes nas colunas devem ser compatíveis. Se houver linhas duplicadas nos resultados das duas consultas, o UNION irá eliminá-las, retornando apenas uma instância delas no conjunto de resultados combinado.</p></li>
  <li><p align="justify"><b>UNION ALL: </b>O operador UNION ALL também combina o resultado de duas ou mais consultas em um único conjunto de resultados, mas não elimina as linhas duplicadas. Ele retorna todas as linhas de cada consulta individual, incluindo possíveis duplicatas. Cada consulta individual também deve ter a mesma quantidade de colunas e os tipos de dados correspondentes nas colunas devem ser compatíveis. O UNION ALL irá retornar todas as linhas das duas consultas, sem eliminar quaisquer duplicatas. Isso pode resultar em um conjunto de resultados maiores do que o obtido com o UNION.</p></li>
</ul>

```sql
-- union
SELECT coluna1, coluna2 FROM tabela1
UNION
SELECT coluna1, coluna2 FROM tabela2;

-- union all
SELECT coluna1, coluna2 FROM tabela1
UNION ALL
SELECT coluna1, coluna2 FROM tabela2;
```

<p align="justify">
  Em resumo, a diferença principal entre UNION e UNION ALL é que o <b>UNION remove as linhas duplicadas</b> do conjunto de resultados, enquanto o <b>UNION ALL retorna todas</b> as linhas das consultas individuais, independentemente das duplicatas. A escolha entre eles depende dos requisitos específicos da consulta e se você deseja ou não eliminar duplicatas do resultado final.
</p>

<h2>2. SUBQUERIES (SUBCONSULTAS)</h2>

<p align="justify">
  São queries select que estão condicionadas/dependem de outra query select. Tais como:
</p>

```sql
-- subquery 1: SELECT dentro de FROM
select a.*
from (select cols from tabela) as a

-- subquery 2: SELECT no SELECT -> pseudo-join devido ao where interno
select
  a.*
, (select col from subtabela where subtabela.col = tabela.col) as `nomeCol`
from tabela

-- subquery 3: JOINS entre SUBQUERIES
select
  a.*
, b.*
from
(select cols from tabela1) as a
join
(select cols from tabela2) as b
on a.col = b.col
```

<p align="justify">
	A subquery 1 acima ainda possui um outro meio mais performático. Como dito acima, trata-se de um 'pseudo-join', pois, estabelece-se um vínculo entre duas colunas no WHERE. Contudo, <b>fazer de fato o JOIN é mais performático que o aplicado na subquery 1</b>.
</p>

<p align="justify">
	A subquery 2 se assemelha com CTEs (common table expressions). Em geral, CTEs são mais legíveis e subqueries tendem a performar melhor.
</p>

<p align="justify">E a subquery 3 é bastante utilizada, e para fazê-la basta ter nas tabelas fato (A e B) uma coluna que converse entre elas para aplicar na cláusula ON.</p>

```sql
/*1. consultas de cardio*/

-- jeito 1: filter WHERE com IN com SELECT
select * 
from consulta
where medico_id in (select id 
                    from medico 
                    where especialidade = 'cardio'
                   )
;

-- jeito 2: JOIN com WHERE
select c.* 
from consulta c
left join medico m on c.`medico_id` = m.`id`
where m.especialidade = 'cardio'
;
```

<table align="center"><thead><tr><th>id</th><th>medico_id</th><th>paciente_id</th><th>data</th></tr></thead><tbody><tr><td>1</td><td>1</td><td>1</td><td>2022-01-01 09:00:00</td></tr><tr><td>6</td><td>1</td><td>6</td><td>2022-01-02 13:00:00</td></tr><tr><td>11</td><td>1</td><td>2</td><td>2022-01-02 16:00:00</td></tr></tbody></table>

```sql
-- jeito 3: SELECT no SELECT ('pseudo-join')
select 
  c.*
, (select m.especialidade from medico m where m.id = c.medico_id) as `especialidade`
from consulta c
having `especialidade` = 'cardio'
;
```

<table align="center"><thead><tr><th>id</th><th>medico_id</th><th>paciente_id</th><th>data</th><th>especialidade</th></tr></thead><tbody><tr><td>1</td><td>1</td><td>1</td><td>2022-01-01 09:00:00</td><td>cardio</td></tr><tr><td>6</td><td>1</td><td>6</td><td>2022-01-02 13:00:00</td><td>cardio</td></tr><tr><td>11</td><td>1</td><td>2</td><td>2022-01-02 16:00:00</td><td>cardio</td></tr></tbody></table>

<p align="justify">
	Métodos 1 e 2 promovem mesmo resultado. Método 3 é levemente diferente, retornando adicionalmente a coluna `especialidade`. Podendo se tornar igual ao resultado das demais com uso de subquery. Lembrando que o método 3 é menos performático.
</p>

```sql
/*2. total de consultas por especialidade*/
-- SEM subquery
select 
  m.`especialidade`
, count(*) as `total`
from consulta c
left join medico m on c.`medico_id` = m.`id`
group by m.`especialidade`
order by `total` desc
;

-- COM subquery
select
  a.`especialidade`
, count(*) as `total`
from (
select 
  c.`id` as `consultaId`
, c.`data` as `dataConsulta`
, m.`especialidade`
from consulta c
left join medico m on c.`medico_id` = m.`id`
) as a
group by a.`especialidade`
order by `total` desc
;
```

<table align="center"><thead><tr><th>especialidade</th><th>total</th></tr></thead><tbody><tr><td>cardio</td><td>3</td></tr><tr><td>neuro</td><td>3</td></tr><tr><td>psico</td><td>2</td></tr><tr><td>otorrino</td><td>2</td></tr><tr><td>pneumo</td><td>2</td></tr></tbody></table>

<p align="justify">
	Ambos resultados promovem a tabela acima. É o "gosto do freguês".
</p>

```sql
/*
Pegar todas as consultas de 'cardio' e algumas INFOs adicionais, quando houver (LEFT JOIN). 
Cols:
ID da consulta, data da consulta, medico, especialidade, paciente, 
plano, descricao da receita, remedio, planos que cobrem o remedio, preco do remedio
*/

-- jeito 1: JOINS, somente
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
	left join medico m on c.`medico_id` = m.`id`
	left join paciente p on c.`paciente_id` = p.`id`
	left join receita rc on rc.`consulta_id` = c.`id`
	left join remedio rm on rm.`ID` = rc.`remedio_id`
where 1=1
  and m.`especialidade` = 'cardio'
;

-- jeito 2: JOINS entre SUBQUERIES A e B
select
  A.`consultaID`
, A.`dataConsulta`
, A.`medico`
, A.`especialidade`
, A.`paciente`
, A.`plano`
, B.`descricao`
, B.`remedio`
, B.`planos_cobertos`
, B.`preco`
from 
(
select
  c.`id` as `consultaID`
, c.`data` as `dataConsulta`
, m.`nome` as `medico`
, m.`especialidade`
, p.`nome` as `paciente`
, p.`plano`
, c.`id` as `consulta_id`
from consulta c
	left join medico m on c.`medico_id` = m.`id`
	left join paciente p on c.`paciente_id` = p.`id`
where 1=1
  and m.`especialidade` = 'cardio'
) as A  
  left join
(
select
  rc.`descricao`
, rm.`nome` as `remedio`
, rm.`planos_cobertos`
, rm.`preco`
, rc.`consulta_id`
from receita rc
	left join remedio rm on rm.`ID` = rc.`remedio_id`
) as B
on A.`consulta_id` = B.`consulta_id`
;
```

<table align="center"><thead><tr><th>consultaID</th><th>dataConsulta</th><th>medico</th><th>especialidade</th><th>paciente</th><th>plano</th><th>descricao</th><th>remedio</th><th>planos_cobertos</th><th>preco</th></tr></thead><tbody><tr><td>1</td><td>2022-01-01 09:00:00</td><td>Dr. João Santos</td><td>cardio</td><td>Fulano da Silva</td><td>AMIL</td><td>Prescrição A</td><td>Remedio 1</td><td>AMIL,SILVESTRE</td><td>10,5</td></tr><tr><td>6</td><td>2022-01-02 13:00:00</td><td>Dr. João Santos</td><td>cardio</td><td>Ana Silva</td><td>SULAMERICA</td><td>Prescrição F</td><td>Remedio 6</td><td></td><td>18,5</td></tr><tr><td>11</td><td>2022-01-02 16:00:00</td><td>Dr. João Santos</td><td>cardio</td><td>Cicrano Souza</td><td>SILVESTRE</td><td>Prescrição K</td><td>Remedio 11</td><td>SILVESTRE,SULAMERICA</td><td>14,25</td></tr></tbody></table>

<p align="justify">
	Ambas consultas promovem o mesmo resultado. A 2ª é apenas para mostrar como <b>é possível fazer JOINS entre duas SUBQUERIES</b>.
</p>
