<h2>JOINS</h2>

<p align="justify">
  Joins são operações em linguagem SQL que combinam dados de diferentes tabelas com base em uma condição específica. Essas condições são estabelecidas através da utilização de colunas relacionadas entre as tabelas. Existem vários tipos de joins em SQL. Os joins são muito úteis para realizar consultas complexas que envolvem dados de várias tabelas, permitindo combinar e relacionar informações de forma eficiente. Alguns dos mais comuns são:
</p>

<ul>
  <li><p align="justify"><b>INNER JOIN: </b>Combina registros de duas tabelas que têm valores correspondentes nas colunas relacionadas.</p></li>
  <li><p align="justify"><b>LEFT JOIN: </b>Retorna todos os registros da tabela da esquerda e os registros correspondentes na tabela da direita.</p></li>
  <li><p align="justify"><b>RIGHT JOIN: </b>Retorna todos os registros da tabela da direita e os registros correspondentes na tabela da esquerda.</p></li>
  <li><p align="justify"><b>FULL OUTER JOIN: </b>Retorna todos os registros de ambas as tabelas, combinando os registros quando há correspondência.</p></li>
  <li><p align="justify"><b>CROSS JOIN: </b>Retorna o produto cartesiano de duas tabelas, ou seja, todas as combinações possíveis entre os registros das tabelas.</p></li>
</ul>

<p align="justify">
  <b>NOTA: </b>No MySQL, não há a possibilidade direta de se realizar um FULL OUTER JOIN. No entanto, o que simula este JOIN é a sintaxe abaixo:
</p>

```sql
SELECT * FROM A LEFT JOIN B ON A.id = B.id
UNION ALL
SELECT * FROM A RIGHT JOIN B ON A.id = B.id
WHERE A.id IS NULL;
```

<p align="justify">
  Neste exemplo, o primeiro SELECT realiza um Left Join para obter todos os registros de "A" e suas correspondências em "B". O segundo SELECT realiza um Right Join para obter todos os registros de "B" que não possuem correspondência em "A". A cláusula WHERE A.id IS NULL é usada para filtrar os registros que não têm correspondência em "A".
</p>

<p align="justify">
  Observe que essa é uma solução alternativa para simular um Full Outer Join no MySQL, mas pode ter um desempenho inferior em comparação com um banco de dados que possui suporte nativo a essa operação. Portanto, é importante considerar a estrutura e tamanho dos dados antes de utilizar essa abordagem.
</p>

<p align="justify">
  Repare também que o <b>CROSS JOIN</b> não possui cláusula ON. Isto porquê ele será o produto cartesiano de cada registro de uma tabela com outra. Ou seja, tudo é cruzado e não há referência (ON):
</p>

```sql
SELECT * FROM tabela1 CROSS JOIN tabela2;
```

<p align="justify">
	<b>Dois detalhes muito importantes sobre JOINS:</b>
</p>

<ul>
	<li><p align="justify"><b>Atenção na tabela principal do FROM: </b>Se quiser saber informações de vendas, deve haver uma tabela VENDAS, se quer saber sobre níveis de estoque, deve haver uma tabela ESTOQUE, se quer saber sobre produtos cadastrados, deve haver uma tabela PRODUTOS. Ou seja, <b>sempre haverá uma tabela principal que deve estar no FROM e direcionará o início do passeio nos JOINS</b>.</p></li>
	<li><p align="justify"><b>Atenção à cardinalidade: </b>Olhar o <b>diagrama de entidade (ER diagram) ajuda muito a entender como os dados se conversam</b> e pode dar insights de como escrever consultas. Não somente, entender a <b>cardinalidade ajuda a entender a lógica do banco e construir consultas mais assertivas</b>.</p></li>
</ul>

<p align="justify">
	Aproveitando os exercícios do capítulo anterior de SUBQUERIES, vejamos os últimos exercícios.
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
	Note acima que como se queria informações das consultas, a tabela principal é justamente CONSULTA. A partir dela, os JOINS são construídos.
</p>
