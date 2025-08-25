<h2>7. FUNÇÕES DE CONVERSÃO</h2>

<p align="justify">Convertem a tipagem de um dado. Segue:</p>

<table align="center"><thead><tr><th>FUNÇÃO</th><th>DESCRIÇÃO</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>CONVERT()</td><td>Converte um valor de um tipo de dados para outro tipo específico.</td><td>`SELECT CONVERT(&#39;123&#39;, INT);`</td></tr><tr><td>CAST()</td><td>Converte um valor em um tipo de dados específico.</td><td>`SELECT CAST(&#39;3.14&#39; AS DECIMAL(4,2));`</td></tr></tbody></table>



<p align="justify">
	Ambas funções fazem a mesma operação de conversão. A escolha é de preferência do usuário. A única diferença é sintática:
</p>

```sql
SELECT CONVERT(col, tipo) AS `col` FROM tabela;
SELECT CAST(col AS tipo) AS `col` FROM tabela;
```

<p align="justify">
	Já os tipos de dados no argumento <b>tipo</b>, são <b>aceitos</b>: <b>CHAR, BINARY, DATE, TIME, DATETIME, DECIMAL, SIGNED, UNSIGNED, FLOAT, DOUBLE, JSON, entre outros.</b>
</p>

```sql
select 
r.`preco` 
, cast(r.`preco` as decimal(10,2)) as `decimal`           -- decimal de 10 ints e 2 decimais
, cast(r.`preco` as float) as `float`                     -- ponto flutuante
, cast(r.`preco` as double) as `double`                   -- ponto flutuante de maior precisao
, cast(r.`preco` as signed) as `inteiroPOSNEG`            -- inteiro positivo e negativo
, cast(r.`preco` as unsigned) as `inteiroPOS`             -- inteiro positivo, somente
, current_timestamp() as `timestamp`                      -- data e hora
, cast(current_timestamp() as date) as `date`             -- data
, cast(current_timestamp() as time) as `time`             -- hora
, cast(current_timestamp() as datetime) as `datetime`     -- data e hora
, cast(r.`preco` as json) as `JSON`                       -- elemento JSON (texto)
, cast(r.`preco` as char) as `char`                       -- string (texto)
from remedio r;
```

<table align="center"><thead><tr><th>preco</th><th>float</th><th>inteiro</th><th>timestamp</th><th>date</th><th>time</th><th>datetime</th><th>decimal</th><th>float</th><th>double</th><th>JSON</th><th>char</th></tr></thead><tbody><tr><td>10,5</td><td>10,5</td><td>10</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>10,5</td><td>10,5</td><td>10,5</td><td>10.5</td><td>10.5</td></tr><tr><td>20,75</td><td>20,75</td><td>21</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>20,75</td><td>20,75</td><td>20,75</td><td>20.75</td><td>20.75</td></tr><tr><td>15</td><td>15</td><td>15</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>15</td><td>15</td><td>15</td><td>15.0</td><td>15</td></tr><tr><td>30,25</td><td>30,25</td><td>30</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>30,25</td><td>30,25</td><td>30,25</td><td>30.25</td><td>30.25</td></tr><tr><td>12</td><td>12</td><td>12</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>12</td><td>12</td><td>12</td><td>12.0</td><td>12</td></tr><tr><td>18,5</td><td>18,5</td><td>18</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>18,5</td><td>18,5</td><td>18,5</td><td>18.5</td><td>18.5</td></tr><tr><td>25</td><td>25</td><td>25</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>25</td><td>25</td><td>25</td><td>25.0</td><td>25</td></tr><tr><td>8,75</td><td>8,75</td><td>9</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>8,75</td><td>8,75</td><td>8,75</td><td>8.75</td><td>8.75</td></tr><tr><td>16,5</td><td>16,5</td><td>16</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>16,5</td><td>16,5</td><td>16,5</td><td>16.5</td><td>16.5</td></tr><tr><td>22,5</td><td>22,5</td><td>22</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>22,5</td><td>22,5</td><td>22,5</td><td>22.5</td><td>22.5</td></tr><tr><td>14,25</td><td>14,25</td><td>14</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>14,25</td><td>14,25</td><td>14,25</td><td>14.25</td><td>14.25</td></tr><tr><td>17,75</td><td>17,75</td><td>18</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>17,75</td><td>17,75</td><td>17,75</td><td>17.75</td><td>17.75</td></tr><tr><td>11,5</td><td>11,5</td><td>12</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>11,5</td><td>11,5</td><td>11,5</td><td>11.5</td><td>11.5</td></tr><tr><td>19</td><td>19</td><td>19</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>19</td><td>19</td><td>19</td><td>19.0</td><td>19</td></tr><tr><td>32</td><td>32</td><td>32</td><td>2023-11-22 19:45:26</td><td>2023-11-22</td><td>19:45:26</td><td>2023-11-22 19:45:26</td><td>32</td><td>32</td><td>32</td><td>32.0</td><td>32</td></tr></tbody></table>
