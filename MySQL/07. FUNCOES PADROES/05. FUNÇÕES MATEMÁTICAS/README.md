<h2>5. FUNÇÕES MATEMÁTICAS</h2>

<p align="justify">Permitem operações matemáticas. Segue:</p>

<table align="center"><thead><tr><th>FUNÇÃO</th><th>DESCRIÇÃO</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>ABS()</td><td>Retorna o valor absoluto de um número.</td><td>ABS(-5)</td></tr><tr><td>ROUND()</td><td>Arredonda um número para um número de casas decimais específico.</td><td>ROUND(3.14159, 2)</td></tr><tr><td>CEILING()</td><td>Arredonda um número para o próximo número inteiro maior ou igual.</td><td>CEILING(1.5)</td></tr><tr><td>FLOOR()</td><td>Arredonda um número para o próximo número inteiro menor ou igual.</td><td>FLOOR(2.8)</td></tr><tr><td>RAND()</td><td>Retorna um número aleatório entre 0 e 1.</td><td>RAND()</td></tr><tr><td>POWER()</td><td>Retorna um número elevado a uma potência específica.</td><td>POWER(2, 3)</td></tr><tr><td>SQRT()</td><td>Retorna a raiz quadrada de um número.</td><td>SQRT(16)</td></tr><tr><td>MOD()</td><td>Retorna o resto da divisão de um número por outro.</td><td>MOD(10, 3)</td></tr><tr><td>TRUNCATE()</td><td>Trunca um número para um número específico de casas decimais.</td><td>TRUNCATE(3.14159, 3)</td></tr><tr><td>SIGN()</td><td>Retorna o sinal de um número (-1 para negativo, 0 para zero, 1 para positivo).</td><td>SIGN(-5)</td></tr></tbody></table>

```sql
select
  r.`preco`
, abs(-1 * r.`preco`) as `abs`
, round(r.`preco`, 1) as `round`
, ceiling(r.`preco`) as `ceiling`
, floor(r.`preco`) as `floor`
, rand(r.`preco`) as `rand`
, power(r.`preco`, 1/2) as `power`     -- elevado a 0.5 é raíz quadrada
, sqrt(r.`preco`) as `sqrt`
, mod(r.`preco`, 3) as `mod`
, truncate(r.`preco`, 1) as `truncate`
, sign(r.`preco`) as `sign`
from remedio r;
```

<table align="center"><thead><tr><th>preco</th><th>abs</th><th>round</th><th>ceiling</th><th>floor</th><th>rand</th><th>power</th><th>sqrt</th><th>mod</th><th>truncate</th><th>sign</th></tr></thead><tbody><tr><td>10,5</td><td>10,5</td><td>10,5</td><td>11</td><td>10</td><td>0,657051522</td><td>3,240370349</td><td>3,240370349</td><td>1,5</td><td>10,5</td><td>1</td></tr><tr><td>20,75</td><td>20,75</td><td>20,8</td><td>21</td><td>20</td><td>0,409065722</td><td>4,55521679</td><td>4,55521679</td><td>2,75</td><td>20,7</td><td>1</td></tr><tr><td>15</td><td>15</td><td>15</td><td>15</td><td>15</td><td>0,907967069</td><td>3,872983346</td><td>3,872983346</td><td>0</td><td>15</td><td>1</td></tr><tr><td>30,25</td><td>30,25</td><td>30,2</td><td>31</td><td>30</td><td>0,660713707</td><td>5,5</td><td>5,5</td><td>0,25</td><td>30,2</td><td>1</td></tr><tr><td>12</td><td>12</td><td>12</td><td>12</td><td>12</td><td>0,157417741</td><td>3,464101615</td><td>3,464101615</td><td>0</td><td>12</td><td>1</td></tr><tr><td>18,5</td><td>18,5</td><td>18,5</td><td>19</td><td>18</td><td>0,658516394</td><td>4,301162634</td><td>4,301162634</td><td>0,5</td><td>18,5</td><td>1</td></tr><tr><td>25</td><td>25</td><td>25</td><td>25</td><td>25</td><td>0,40979816</td><td>5</td><td>5</td><td>1</td><td>25</td><td>1</td></tr><tr><td>8,75</td><td>8,75</td><td>8,8</td><td>9</td><td>8</td><td>0,406868413</td><td>2,958039892</td><td>2,958039892</td><td>2,75</td><td>8,7</td><td>1</td></tr><tr><td>16,5</td><td>16,5</td><td>16,5</td><td>17</td><td>16</td><td>0,158150175</td><td>4,062019202</td><td>4,062019202</td><td>1,5</td><td>16,5</td><td>1</td></tr><tr><td>22,5</td><td>22,5</td><td>22,5</td><td>23</td><td>22</td><td>0,659248831</td><td>4,74341649</td><td>4,74341649</td><td>1,5</td><td>22,5</td><td>1</td></tr><tr><td>14,25</td><td>14,25</td><td>14,2</td><td>15</td><td>14</td><td>0,65778396</td><td>3,774917218</td><td>3,774917218</td><td>2,25</td><td>14,2</td><td>1</td></tr><tr><td>17,75</td><td>17,75</td><td>17,8</td><td>18</td><td>17</td><td>0,658516394</td><td>4,213074887</td><td>4,213074887</td><td>2,75</td><td>17,7</td><td>1</td></tr><tr><td>11,5</td><td>11,5</td><td>11,5</td><td>12</td><td>11</td><td>0,157417741</td><td>3,391164992</td><td>3,391164992</td><td>2,5</td><td>11,5</td><td>1</td></tr><tr><td>19</td><td>19</td><td>19</td><td>19</td><td>19</td><td>0,908699503</td><td>4,358898944</td><td>4,358898944</td><td>1</td><td>19</td><td>1</td></tr><tr><td>32</td><td>32</td><td>32</td><td>32</td><td>32</td><td>0,161079922</td><td>5,656854249</td><td>5,656854249</td><td>2</td><td>32</td><td>1</td></tr></tbody></table>
