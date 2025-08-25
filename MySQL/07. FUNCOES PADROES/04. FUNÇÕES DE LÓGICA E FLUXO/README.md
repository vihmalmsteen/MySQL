<h2>4. FUNÇÕES DE LÓGICA E FLUXO</h2>

<p align="justify">
	São funções de condição (IF, CASE WHEN) ou de teste (ISNULL). <b>Podem ser usadas tanto em SELECT, WHERE, GROUP BY, ORDER BY</b>. Segue:
</p>

<table align="center"><thead><tr><th>FUNÇÃO</th><th>DESCRIÇÃO</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>CASE WHEN</td><td>É uma expressão condicional que permite fazer comparações e retornar valores diferentes com base nas condições.</td><td>SELECT name, CASE WHEN age &gt;= 18 THEN &#39;Maior de idade&#39; ELSE &#39;Menor de idade&#39; END AS status FROM employees;</td></tr><tr><td>IF</td><td>É uma estrutura de controle condicional que permite executar determinadas ações com base em uma condição.</td><td>SELECT name, IF(salary &lt; 1000, &#39;Baixo salário&#39;, &#39;Alto salário&#39;) AS status FROM employees;</td></tr><tr><td>IFNULL</td><td>Retorna o valor especificado se uma expressão for nula, caso contrário, retorna a própria expressão.</td><td>SELECT name, IFNULL(commission, 0) AS commission FROM employees;</td></tr><tr><td>ISNULL</td><td>Verifica se uma expressão é nula e retorna verdadeiro (1) se for, caso contrário, retorna falso (0).</td><td>SELECT name, ISNULL(commission) AS has_commission FROM employees;</td></tr><tr><td>NULLIF</td><td>Compara dois valores e retorna nulo se os valores forem iguais, caso contrário, retorna o primeiro valor.</td><td>SELECT name, NULLIF(age, 0) AS age FROM employees;</td></tr></tbody></table>

```sql
select 
  r.`preco`
, r.`planos_cobertos`
, case when r.`preco` >= 0 and r.`preco` <= 5 then 'A'
       when r.`preco` >  5 and r.`preco` <= 10 then 'B'
       else 'C' end as `case_when`
, if(r.`preco` >= 15, 'X', 'Y') as `if`
, isnull(r.`planos_cobertos`) as `isnull`
, ifnull(r.`planos_cobertos`, 'NULO') as `ifnull`
, if(isnull(r.`planos_cobertos`), 'NULO', 'NAO NULO') as `if_isnull`
from remedio r
order by 
  case when r.`preco` <= 10 then 1 else 2 end desc
, r.`planos_cobertos`
;
```

<table align="center"><thead><tr><th>preco</th><th>planos_cobertos</th><th>case_when</th><th>if</th><th>isnull</th><th>ifnull</th><th>if_isnull</th></tr></thead><tbody><tr><td>18,5</td><td></td><td>C</td><td>X</td><td>1</td><td>NULO</td><td>NULO</td></tr><tr><td>20,75</td><td>AMIL</td><td>C</td><td>X</td><td>0</td><td>AMIL</td><td>NAO NULO</td></tr><tr><td>17,75</td><td>AMIL</td><td>C</td><td>X</td><td>0</td><td>AMIL</td><td>NAO NULO</td></tr><tr><td>10,5</td><td>AMIL,SILVESTRE</td><td>C</td><td>Y</td><td>0</td><td>AMIL,SILVESTRE</td><td>NAO NULO</td></tr><tr><td>22,5</td><td>AMIL,SILVESTRE</td><td>C</td><td>X</td><td>0</td><td>AMIL,SILVESTRE</td><td>NAO NULO</td></tr><tr><td>19</td><td>AMIL,SILVESTRE</td><td>C</td><td>X</td><td>0</td><td>AMIL,SILVESTRE</td><td>NAO NULO</td></tr><tr><td>30,25</td><td>AMIL,SILVESTRE,SULAMERICA</td><td>C</td><td>X</td><td>0</td><td>AMIL,SILVESTRE,SULAMERICA</td><td>NAO NULO</td></tr><tr><td>25</td><td>AMIL,SULAMERICA</td><td>C</td><td>X</td><td>0</td><td>AMIL,SULAMERICA</td><td>NAO NULO</td></tr><tr><td>16,5</td><td>AMIL,SULAMERICA</td><td>C</td><td>X</td><td>0</td><td>AMIL,SULAMERICA</td><td>NAO NULO</td></tr><tr><td>32</td><td>AMIL,SULAMERICA</td><td>C</td><td>X</td><td>0</td><td>AMIL,SULAMERICA</td><td>NAO NULO</td></tr><tr><td>15</td><td>SILVESTRE</td><td>C</td><td>X</td><td>0</td><td>SILVESTRE</td><td>NAO NULO</td></tr><tr><td>14,25</td><td>SILVESTRE,SULAMERICA</td><td>C</td><td>Y</td><td>0</td><td>SILVESTRE,SULAMERICA</td><td>NAO NULO</td></tr><tr><td>12</td><td>SULAMERICA</td><td>C</td><td>Y</td><td>0</td><td>SULAMERICA</td><td>NAO NULO</td></tr><tr><td>11,5</td><td>SULAMERICA</td><td>C</td><td>Y</td><td>0</td><td>SULAMERICA</td><td>NAO NULO</td></tr><tr><td>8,75</td><td>SILVESTRE</td><td>B</td><td>Y</td><td>0</td><td>SILVESTRE</td><td>NAO NULO</td></tr></tbody></table>
