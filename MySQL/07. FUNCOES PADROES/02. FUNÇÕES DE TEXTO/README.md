<h2>2. FUNÇÕES DE CARACTERES</h2>

<p align="justify">
	Funções para mianipulação de texto (VARCHAR, TEXT, etc.). São algumas:
</p>

<table align="center"><thead><tr><th>FUNÇÃO</th><th>DESCRIÇÃO</th><th>EXEMPLOS</th></tr></thead><tbody><tr><td>CONCAT</td><td>Concatena duas ou mais strings juntas.</td><td>SELECT CONCAT('Hello', 'World'); <br> Resultado: 'HelloWorld'</td></tr><tr><td>LTRIM</td><td>Remove espaços em branco do início de uma string.</td><td>SELECT LTRIM('   Hello'); <br> Resultado: 'Hello'</td></tr><tr><td>RTRIM</td><td>Remove espaços em branco do final de uma string.</td><td>SELECT RTRIM('Hello   '); <br> Resultado: 'Hello'</td></tr><tr><td>TRIM</td><td>Remove espaços em branco do início e do final de uma string.</td><td>SELECT TRIM('   Hello   '); <br> Resultado: 'Hello'</td></tr><tr><td>REVERSE</td><td>Inverte os caracteres de uma string.</td><td>SELECT REVERSE('Hello'); <br> Resultado: 'olleH'</td></tr><tr><td>CHAR_LENGTH</td><td>Retorna o número de caracteres em uma string (conta caracteres multibyte corretamente).</td><td>SELECT CHAR_LENGTH('Olá'); <br> Resultado: 3</td></tr><tr><td>LENGTH</td><td>Retorna o número de caracteres em uma string.</td><td>SELECT LENGTH('Olá'); <br> Resultado: 4</td></tr><tr><td>FIELD</td><td>Retorna a posição de uma string em uma lista de strings especificada.</td><td>SELECT FIELD('apple', 'banana', 'orange', 'apple'); <br> Resultado: 3</td></tr><tr><td>FIND_IN_SET</td><td>Retorna a posição da primeira string que estiver presente em uma lista de strings especificada (array).</td><td>SELECT FIND_IN_SET('apple', 'banana,apple,orange'); <br> Resultado: 2</td></tr><tr><td>REPLACE</td><td>Substitui todas as ocorrências de uma substring em uma string por outra substring.</td><td>SELECT REPLACE('Hello World', 'World', 'Universe'); <br> Resultado: 'Hello Universe'</td></tr><tr><td>LEFT</td><td>Retorna os n primeiros caracteres de uma string.</td><td>SELECT LEFT('Hello', 3); <br> Resultado: 'Hel'</td></tr><tr><td>RIGHT</td><td>Retorna os n últimos caracteres de uma string.</td><td>SELECT RIGHT('Hello', 3); <br> Resultado: 'llo'</td></tr><tr><td>SUBSTRING</td><td>Extrai uma parte de uma string.</td><td>SELECT SUBSTRING('Hello World', 7); <br> Resultado: 'World'</td></tr><tr><td>SUBSTRING_INDEX</td><td>Retorna uma substring de uma string, incluindo apenas o número especificado de ocorrências de um delimitador.</td><td>SELECT SUBSTRING_INDEX('www.example.com', '.', 2); <br> Resultado: 'www.example'</td></tr><tr><td>UPPER</td><td>Converte uma string para letras maiúsculas.</td><td>SELECT UPPER('Hello'); <br> Resultado: 'HELLO'</td></tr><tr><td>LOWER</td><td>Converte uma string para letras minúsculas.</td><td>SELECT LOWER('Hello'); <br> Resultado: 'hello'</td></tr></tbody></table>

```sql
-- exemplos
select
  concat('   ', nome, '   ') as `concat`
, ltrim(concat('   ', nome, '   ')) as `ltrim`
, rtrim(concat('   ', nome, '   ')) as `rtrim`
, trim(concat('   ', nome, '   ')) as `trim`
, reverse(nome) as `reverse`
, char_length(nome) as `char_length`
, length(nome) as `length`
, field(nome, 'Fulano da Silva', 'Cicrano Souza', 'Beltrano Oliveira') as `field`
, find_in_set(nome, 'Fulano da Silva,Cicrano Souza,Beltrano Oliveira') as `find_in_set`
, replace(nome, 'a', 'A') as `replace`
, left(nome, 3) as `left`
, right(nome, 3) as `right`
, substring(nome, 1, 4) as `substring`
, substring_index(concat('TESTE|', nome), '|', 1)  as `substring_index`
, upper(nome) as `upper`
, lower(nome) as `lower`
from paciente;
```

<table align="center"><thead><tr><th>concat</th><th>ltrim</th><th>rtrim</th><th>trim</th><th>reverse</th><th>char_length</th><th>length</th><th>field</th><th>find_in_set</th><th>replace</th><th>left</th><th>right</th><th>substring</th><th>substring_index</th><th>upper</th><th>lower</th></tr></thead><tbody><tr><td>   Fulano da Silva   </td><td>Fulano da Silva   </td><td>   Fulano da Silva</td><td>Fulano da Silva</td><td>avliS ad onaluF</td><td>15</td><td>15</td><td>1</td><td>1</td><td>FulAno dA SilvA</td><td>Ful</td><td>lva</td><td>Fula</td><td>TESTE</td><td>FULANO DA SILVA</td><td>fulano da silva</td></tr><tr><td>   Cicrano Souza   </td><td>Cicrano Souza   </td><td>   Cicrano Souza</td><td>Cicrano Souza</td><td>azuoS onarciC</td><td>13</td><td>13</td><td>2</td><td>2</td><td>CicrAno SouzA</td><td>Cic</td><td>uza</td><td>Cicr</td><td>TESTE</td><td>CICRANO SOUZA</td><td>cicrano souza</td></tr><tr><td>   Beltrano Oliveira   </td><td>Beltrano Oliveira   </td><td>   Beltrano Oliveira</td><td>Beltrano Oliveira</td><td>arievilO onartleB</td><td>17</td><td>17</td><td>3</td><td>3</td><td>BeltrAno OliveirA</td><td>Bel</td><td>ira</td><td>Belt</td><td>TESTE</td><td>BELTRANO OLIVEIRA</td><td>beltrano oliveira</td></tr><tr><td>   Maria Rodrigues   </td><td>Maria Rodrigues   </td><td>   Maria Rodrigues</td><td>Maria Rodrigues</td><td>seugirdoR airaM</td><td>15</td><td>15</td><td>0</td><td>0</td><td>MAriA Rodrigues</td><td>Mar</td><td>ues</td><td>Mari</td><td>TESTE</td><td>MARIA RODRIGUES</td><td>maria rodrigues</td></tr><tr><td>   José Pereira   </td><td>José Pereira   </td><td>   José Pereira</td><td>José Pereira</td><td>ariereP ésoJ</td><td>12</td><td>13</td><td>0</td><td>0</td><td>José PereirA</td><td>Jos</td><td>ira</td><td>José</td><td>TESTE</td><td>JOSÉ PEREIRA</td><td>josé pereira</td></tr><tr><td>   Ana Silva   </td><td>Ana Silva   </td><td>   Ana Silva</td><td>Ana Silva</td><td>avliS anA</td><td>9</td><td>9</td><td>0</td><td>0</td><td>AnA SilvA</td><td>Ana</td><td>lva</td><td>Ana </td><td>TESTE</td><td>ANA SILVA</td><td>ana silva</td></tr><tr><td>   Paulo Santos   </td><td>Paulo Santos   </td><td>   Paulo Santos</td><td>Paulo Santos</td><td>sotnaS oluaP</td><td>12</td><td>12</td><td>0</td><td>0</td><td>PAulo SAntos</td><td>Pau</td><td>tos</td><td>Paul</td><td>TESTE</td><td>PAULO SANTOS</td><td>paulo santos</td></tr><tr><td>   Mariana Oliveira   </td><td>Mariana Oliveira   </td><td>   Mariana Oliveira</td><td>Mariana Oliveira</td><td>arievilO anairaM</td><td>16</td><td>16</td><td>0</td><td>0</td><td>MAriAnA OliveirA</td><td>Mar</td><td>ira</td><td>Mari</td><td>TESTE</td><td>MARIANA OLIVEIRA</td><td>mariana oliveira</td></tr><tr><td>   Pedro Gomes   </td><td>Pedro Gomes   </td><td>   Pedro Gomes</td><td>Pedro Gomes</td><td>semoG ordeP</td><td>11</td><td>11</td><td>0</td><td>0</td><td>Pedro Gomes</td><td>Ped</td><td>mes</td><td>Pedr</td><td>TESTE</td><td>PEDRO GOMES</td><td>pedro gomes</td></tr></tbody></table>

<p align="justify">
	<b>NOTA: </b> A função REPLACE pode ser usada em cláusulas de UPDATE.
</p>

```sql
-- antes
select nome from paciente where nome regexp('Fulano');         -- retorna 'Fulano da Silva'

-- UPDATE com REPLACE
UPDATE paciente
SET nome = REPLACE(nome, 'Fulano da Silva', 'Fulano Silva');

-- depois
select nome from paciente where nome regexp('Fulano');         -- retorna 'Fulano Silva'
```
