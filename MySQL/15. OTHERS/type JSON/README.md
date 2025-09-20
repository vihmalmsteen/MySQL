# Estudo futuro -> JSON_SET

A função JSON_SET do MySQL é utilizada para atualizar ou adicionar dados em um documento JSON em uma coluna do tipo JSON. Ela permite que você modifique o conteúdo de objetos JSON ao especificar um ou mais caminhos (ou chaves) para os quais você deseja atribuir novos valores.

<h1><b></b></h1>
<p align="justify"></p>
<center></center>

<h1><b>0. Exemplos rápidos</b></h1>

<h4><b>0.1 JSON_OVERLAPS</b></h4>

```sql
-- JSON_OVERLAPS (retorna 1 se há algum elemento único entre dois arrays, ou 0 se não houver)
select json_overlaps('[1]', '[1,2]') 		as `interseção`, 'exemplo 1' as `conjunto` union all
select json_overlaps('[1]', '[2,3]') 		as `interseção`, 'exemplo 2' as `conjunto` union all
select json_overlaps('[1]', '["1"]') 		as `interseção`, 'exemplo 3' as `conjunto` union all
select json_overlaps('["1"]', '[1]') 		as `interseção`, 'exemplo 4' as `conjunto` union all
select json_overlaps('["1"]', '["1"]') 		as `interseção`, 'exemplo 5' as `conjunto` union all
select json_overlaps('[1,2,3]', '[1,4,8]') 	as `interseção`, 'exemplo 6' as `conjunto`;
```

<table align="center"><thead><tr><th>interseção</th><th>conjunto</th></tr></thead><tbody><tr><td>1</td><td>exemplo 1</td></tr><tr><td>0</td><td>exemplo 2</td></tr><tr><td>0</td><td>exemplo 3</td></tr><tr><td>0</td><td>exemplo 4</td></tr><tr><td>1</td><td>exemplo 5</td></tr><tr><td>1</td><td>exemplo 6</td></tr></tbody></table>

<h4><b>0.2 JSON_SEARCH</b></h4>

```sql
-- JSON_SEARCH (procura 1ª ou todas as posições de algo dentro de um array)
select json_search('["1","2","3"]', 'one', '1') as `posições`, 'exemplo 1' as `exemplo` union all
select json_search('["1","2","3"]', 'one', '2') as `posições`, 'exemplo 2' as `exemplo` union all
select json_search('["1","2","3"]', 'one', '3') as `posições`, 'exemplo 3' as `exemplo` union all
select json_search('["1","2","3"]', 'one', '4') as `posições`, 'exemplo 4' as `exemplo` union all
select json_search('["1","2","1"]', 'all', '1') as `posições`, 'exemplo 5' as `exemplo` union all
select json_search('["1","2","1"]', 'all', 1)   as `posições`, 'exemplo 6' as `exemplo` union all
select json_search('["1",1]', 'all', 1)         as `posições`, 'exemplo 7' as `exemplo`;
```

<table align="center"><thead><tr><th>posições</th><th>exemplo</th></tr></thead><tbody><tr><td>&quot;$[0]&quot;</td><td>exemplo 1</td></tr><tr><td>&quot;$[1]&quot;</td><td>exemplo 2</td></tr><tr><td>&quot;$[2]&quot;</td><td>exemplo 3</td></tr><tr><td>NULL </td><td>exemplo 4</td></tr><tr><td>[&quot;$[0]&quot;, &quot;$[2]&quot;]</td><td>exemplo 5</td></tr><tr><td>[&quot;$[0]&quot;, &quot;$[2]&quot;]</td><td>exemplo 6</td></tr><tr><td>&quot;$[0]&quot;</td><td>exemplo 7</td></tr></tbody></table>

<h4><b>0.3 JSON_ARRAY</b></h4>

```sql
-- JSON_ARRAY (cria array com registro da linha, sem possibillidade de particionar)
select json_array(1) 			as `array`, 'exemplo 1' as `exemplo` union all
select json_array('1') 			as `array`, 'exemplo 2' as `exemplo` union all
select json_array(1,2,3) 		as `array`, 'exemplo 3' as `exemplo` union all
select json_array('1','2','3') 		as `array`, 'exemplo 4' as `exemplo` union all
select json_array('1,2,3') 		as `array`, 'exemplo 5' as `exemplo`;
```

<table align="center"><thead><tr><th>array</th><th>exemplo</th></tr></thead><tbody><tr><td>[1]</td><td>exemplo 1</td></tr><tr><td>[&quot;1&quot;]</td><td>exemplo 2</td></tr><tr><td>[1, 2, 3]</td><td>exemplo 3</td></tr><tr><td>[&quot;1&quot;, &quot;2&quot;, &quot;3&quot;]</td><td>exemplo 4</td></tr><tr><td>[&quot;1,2,3&quot;]</td><td>exemplo 5</td></tr></tbody></table>

<h4><b>0.4 JSON_LENGTH</b></h4>

```sql
-- JSON_LENGTH (retorna o tamanho do array, qtd de elementos nele)
select json_length('[1]') 		as `tam array`, 'exemplo 1' as `exemplo` union all
select json_length('[1,2,3,4]') 	as `tam array`, 'exemplo 2' as `exemplo`;
```

<table align="center"><thead><tr><th>tam array</th><th>exemplo</th></tr></thead><tbody><tr><td>1</td><td>exemplo 1</td></tr><tr><td>4</td><td>exemplo 2</td></tr></tbody></table>

<h4><b>0.5 JSON_TABLE</b></h4>

```sql
/* JSON_TABLE quando usado puxando de uma COLUNA DE ARRAYS JSON: */
-- 1. DDL:
create table pedidos (pedidoId int auto_increment primary key,
                      comprador text, 
                      itensIDs json);

insert into pedidos (comprador, itensIDs) values
('ANA DA FONSECA', '[1, 2, 3]'),
('BETO GONÇALVES', '[1, 4, 5]'),
('CARLOS MIRANDA', '[2, 2, 3]'),
('DANILO ALMEIDA', '[4, 5, 7]');

-- 2. SQL:
select p.*, jt.`item ID`
from pedidos p
join json_table(p.`itensIDs`, '$[*]' columns(`item ID` int path '$')) as jt;
```

<table align="center"><thead><tr><th>pedidoId</th><th>comprador</th><th>itensIDs</th><th>item ID</th></tr></thead><tbody><tr><td>1</td><td>ANA DA FONSECA</td><td>[1, 2, 3]</td><td>1</td></tr><tr><td>1</td><td>ANA DA FONSECA</td><td>[1, 2, 3]</td><td>2</td></tr><tr><td>1</td><td>ANA DA FONSECA</td><td>[1, 2, 3]</td><td>3</td></tr><tr><td>2</td><td>BETO GONÇALVES</td><td>[1, 4, 5]</td><td>1</td></tr><tr><td>2</td><td>BETO GONÇALVES</td><td>[1, 4, 5]</td><td>4</td></tr><tr><td>2</td><td>BETO GONÇALVES</td><td>[1, 4, 5]</td><td>5</td></tr><tr><td>3</td><td>CARLOS MIRANDA</td><td>[2, 2, 3]</td><td>2</td></tr><tr><td>3</td><td>CARLOS MIRANDA</td><td>[2, 2, 3]</td><td>2</td></tr><tr><td>3</td><td>CARLOS MIRANDA</td><td>[2, 2, 3]</td><td>3</td></tr><tr><td>4</td><td>DANILO ALMEIDA</td><td>[4, 5, 7]</td><td>4</td></tr><tr><td>4</td><td>DANILO ALMEIDA</td><td>[4, 5, 7]</td><td>5</td></tr><tr><td>4</td><td>DANILO ALMEIDA</td><td>[4, 5, 7]</td><td>7</td></tr></tbody></table>

```sql
/* JSON_TABLE quando usado puxando de uma COLUNA DE STRINGS: */
-- 1. DDL:
create table pedidos (pedidoId int auto_increment primary key,
                      comprador text, 
                      itensIDs text);

insert into pedidos (comprador, itensIDs) values
('ANA DA FONSECA', '1, 2, 3'),
('BETO GONÇALVES', '1, 4, 5'),
('CARLOS MIRANDA', '2, 2, 3'),
('DANILO ALMEIDA', '4, 5, 7');

-- 2. SQL:
select 
  p.* 
, concat('["', replace(p.`itensIDs`, ',', '","'), '"]') as `itensIDs_array`
, jt.`item ID`
from pedidos p
join json_table(
concat('["', replace(p.`itensIDs`, ',', '","'), '"]'), '$[*]' columns(`item ID` int path '$')) as jt;
```

<table align="center"><thead><tr><th>pedidoId</th><th>comprador</th><th>itensIDs</th><th>itensIDs_array</th><th>item ID</th></tr></thead><tbody><tr><td>1</td><td>ANA DA FONSECA</td><td>1, 2, 3</td><td>[&quot;1&quot;,&quot; 2&quot;,&quot; 3&quot;]</td><td>1</td></tr><tr><td>1</td><td>ANA DA FONSECA</td><td>1, 2, 3</td><td>[&quot;1&quot;,&quot; 2&quot;,&quot; 3&quot;]</td><td>2</td></tr><tr><td>1</td><td>ANA DA FONSECA</td><td>1, 2, 3</td><td>[&quot;1&quot;,&quot; 2&quot;,&quot; 3&quot;]</td><td>3</td></tr><tr><td>2</td><td>BETO GONÇALVES</td><td>1, 4, 5</td><td>[&quot;1&quot;,&quot; 4&quot;,&quot; 5&quot;]</td><td>1</td></tr><tr><td>2</td><td>BETO GONÇALVES</td><td>1, 4, 5</td><td>[&quot;1&quot;,&quot; 4&quot;,&quot; 5&quot;]</td><td>4</td></tr><tr><td>2</td><td>BETO GONÇALVES</td><td>1, 4, 5</td><td>[&quot;1&quot;,&quot; 4&quot;,&quot; 5&quot;]</td><td>5</td></tr><tr><td>3</td><td>CARLOS MIRANDA</td><td>2, 2, 3</td><td>[&quot;2&quot;,&quot; 2&quot;,&quot; 3&quot;]</td><td>2</td></tr><tr><td>3</td><td>CARLOS MIRANDA</td><td>2, 2, 3</td><td>[&quot;2&quot;,&quot; 2&quot;,&quot; 3&quot;]</td><td>2</td></tr><tr><td>3</td><td>CARLOS MIRANDA</td><td>2, 2, 3</td><td>[&quot;2&quot;,&quot; 2&quot;,&quot; 3&quot;]</td><td>3</td></tr><tr><td>4</td><td>DANILO ALMEIDA</td><td>4, 5, 7</td><td>[&quot;4&quot;,&quot; 5&quot;,&quot; 7&quot;]</td><td>4</td></tr><tr><td>4</td><td>DANILO ALMEIDA</td><td>4, 5, 7</td><td>[&quot;4&quot;,&quot; 5&quot;,&quot; 7&quot;]</td><td>5</td></tr><tr><td>4</td><td>DANILO ALMEIDA</td><td>4, 5, 7</td><td>[&quot;4&quot;,&quot; 5&quot;,&quot; 7&quot;]</td><td>7</td></tr></tbody></table>

```sql
/* JSON_TABLE quando usado com strings:
  .1º -> Sempre terá o conteúdo chaveado dentro de um array (inserido dentro de colchetes);
  .2º -> O conteúdo que será parseado, 2º argumento, será sempre '$[*]', ou seja, tudo dentro do colchete da string (1º argumento);
  .3º -> O que de fato indicará as cols da tabela renderizada será o conteudo dentro de path, path '$.chaveNome' */
select jt.* from json_table(
'[
{"appointmentiD":"11", "data_agendada":"2024-05-30", "horario_agendado":"09:00:00", "limite":"400"},
{"appointmentiD":"12", "data_agendada":"2024-05-30", "horario_agendado":"10:00:00", "limite":"400"},
{"appointmentiD":"13", "data_agendada":"2024-05-30", "horario_agendado":"11:00:00", "limite":"400"},
{"appointmentiD":"14", "data_agendada":"2024-05-30", "horario_agendado":"12:00:00", "limite":"400"}
]'
, '$[*]'
columns(
appointmentiD      int      path '$.appointmentiD',
data_agendada      date     path '$.data_agendada',
horario_agendado   time     path '$.horario_agendado',
limite             int      path '$.limite'
)
) as jt
```

<table align="center"><thead><tr><th>appointmentiD</th><th>data_agendada</th><th>horario_agendado</th><th>limite</th></tr></thead><tbody><tr><td>11</td><td>30 mai, 2024</td><td>9:00 AM</td><td>400</td></tr><tr><td>12</td><td>30 mai, 2024</td><td>10:00 AM</td><td>400</td></tr><tr><td>13</td><td>30 mai, 2024</td><td>11:00 AM</td><td>400</td></tr><tr><td>14</td><td>30 mai, 2024</td><td>12:00 PM</td><td>400</td></tr></tbody></table>

```sql
/* Quando uma tabela possui uma coluna JSON:
  .1º -> Pode-se usar JOIN da tabela com a funcao JSON_TABLE. Não precisa da cláusula 'on';
  .2º -> O 1º argumento de JSON_TABLE será a coluna com o JSON, e pode-se extrair com -> a chave com o conteúdo;
  .3º -> Extraindo a chave com o conteúdo desejado, permite que o 2º argumento seja sempre ou '$' quando for um elemento solto ou '$[*]' quando for array;
  .4º -> Quando for array, '$[*]', cada elemento será retornado em uma linha e os demais registros se replicarão.*/

-- DDL teste
create table teste (
id int auto_increment primary key,
nome text,
registros json
);

insert into teste (nome, registros) values
('ana',     '{"idade": 31, "pai":"Alfredo", "mae":"Guta",     "filhos":["Zico","Meirelles"]}'),
('beto',    '{"idade": 40, "pai":"Jairo",   "mae":"Jeronima", "filhos":["Xico","Zakk"]}'),
('claudio', '{"idade": 54, "pai":"Tony",    "mae":"Dalila",   "filhos":["Brito","Jhonny"]}')
;

-- JSON_TABLE (jt1 pegando de chave, jt2 pegando de array)
SELECT t.*, jt1.idades, jt2.rebentos
FROM teste t
JOIN JSON_TABLE(t.registros -> '$.idade',     '$'      COLUMNS (idades   INT  PATH '$')) AS jt1
JOIN JSON_TABLE(t.registros->'$.filhos',      '$[*]'   COLUMNS (rebentos TEXT PATH '$')) AS jt2
;
```

<table align="center"><thead><tr><th>id</th><th>nome</th><th>registros</th><th>idades</th><th>rebentos</th></tr></thead><tbody><tr><td>1</td><td>ana</td><td>{&quot;mae&quot;: &quot;Guta&quot;, &quot;pai&quot;: &quot;Alfredo&quot;, &quot;idade&quot;: 31, &quot;filhos&quot;: [&quot;Zico&quot;, &quot;Meirelles&quot;]}</td><td>31</td><td>Zico</td></tr><tr><td>1</td><td>ana</td><td>{&quot;mae&quot;: &quot;Guta&quot;, &quot;pai&quot;: &quot;Alfredo&quot;, &quot;idade&quot;: 31, &quot;filhos&quot;: [&quot;Zico&quot;, &quot;Meirelles&quot;]}</td><td>31</td><td>Meirelles</td></tr><tr><td>2</td><td>beto</td><td>{&quot;mae&quot;: &quot;Jeronima&quot;, &quot;pai&quot;: &quot;Jairo&quot;, &quot;idade&quot;: 40, &quot;filhos&quot;: [&quot;Xico&quot;, &quot;Zakk&quot;]}</td><td>40</td><td>Xico</td></tr><tr><td>2</td><td>beto</td><td>{&quot;mae&quot;: &quot;Jeronima&quot;, &quot;pai&quot;: &quot;Jairo&quot;, &quot;idade&quot;: 40, &quot;filhos&quot;: [&quot;Xico&quot;, &quot;Zakk&quot;]}</td><td>40</td><td>Zakk</td></tr><tr><td>3</td><td>claudio</td><td>{&quot;mae&quot;: &quot;Dalila&quot;, &quot;pai&quot;: &quot;Tony&quot;, &quot;idade&quot;: 54, &quot;filhos&quot;: [&quot;Brito&quot;, &quot;Jhonny&quot;]}</td><td>54</td><td>Brito</td></tr><tr><td>3</td><td>claudio</td><td>{&quot;mae&quot;: &quot;Dalila&quot;, &quot;pai&quot;: &quot;Tony&quot;, &quot;idade&quot;: 54, &quot;filhos&quot;: [&quot;Brito&quot;, &quot;Jhonny&quot;]}</td><td>54</td><td>Jhonny</td></tr></tbody></table>

```sql
-- JSON_TABLE (converte JSON em tabela, chave é coluna e array são elementos)
SELECT Registro, 'string' as `exemplo`
FROM 
json_table('{"Registro":["ana","beto","claudio"]}', '$.Registro[*]' columns (Registro text path '$')) as jt
union all
SELECT Registro, 'int' as `exemplo`
FROM 
json_table('{"Registro":[1,2,3]}', '$.Registro[*]' columns (Registro int path '$')) as jt;
```

<table align="center"><thead><tr><th>Registro</th><th>exemplo</th></tr></thead><tbody><tr><td>ana</td><td>string</td></tr><tr><td>beto</td><td>string</td></tr><tr><td>claudio</td><td>string</td></tr><tr><td>1</td><td>int</td></tr><tr><td>2</td><td>int</td></tr><tr><td>3</td><td>int</td></tr></tbody></table>

```sql
/* CONVERTENDO STRING EM JSON ARRAY */
-- De uma string numérica, ...
set @json_string_ex1 = "123,124,127";
set @json_string_ex2 = "127";

-- ... sustituir ',' por '","' e acrescentar no início e no fim com CONCAT '["' e ']"' ...
set @json_string_ex1 = concat('["', replace(@json_string_ex1, ',', '","'), '"]');  -- result.: ["123","124","127"]
set @json_string_ex2 = concat('["', replace(@json_string_ex2, ',', '","'), '"]');  -- result.: ["127"]

-- ... para se usar em JSON_TABLE.
select jt1.*, 'exmplo 1' as `exemplo` 
from json_table(@json_string_ex1, '$[*]' columns (numeros int path '$')) as jt1
union all
select jt2.*, 'exemplo 2' as `exemplo` 
from json_table(@json_string_ex2, '$[*]' columns (numeros int path '$')) as jt2;
```

<table align="center"><thead><tr><th>numeros</th><th>exemplo</th></tr></thead><tbody><tr><td>123</td><td>exmplo 1</td></tr><tr><td>124</td><td>exmplo 1</td></tr><tr><td>127</td><td>exmplo 1</td></tr><tr><td>127</td><td>exemplo 2</td></tr></tbody></table>

<h4><b>0.6 JSON_VALID</b></h4>

```sql
-- JSON_VALID (retorna 1 se for componente JSON, 0 se não for)
select json_valid(1) 		as `validacao`, 'exemplo 1' as `exemplo` union all
select json_valid('1') 		as `validacao`, 'exemplo 2' as `exemplo` union all
select json_valid('[1]') 	as `validacao`, 'exemplo 3' as `exemplo` union all
select json_valid('["1"]') 	as `validacao`, 'exemplo 4' as `exemplo`;
```

<table align="center"><thead><tr><th>validacao</th><th>exemplo</th></tr></thead><tbody><tr><td>0</td><td>exemplo 1</td></tr><tr><td>1</td><td>exemplo 2</td></tr><tr><td>1</td><td>exemplo 3</td></tr><tr><td>1</td><td>exemplo 4</td></tr></tbody></table>

<h4><b>0.7 JSON_ARRAYAGG</b></h4>

```sql
create table forms (
    formId int primary key auto_increment,
    userId int not null,
    question varchar(80),
    answer varchar(80),
    foreign key (userId) references users(userId)
);

insert into forms (userId, question, answer) values
    (1, 'Nascimento', '02/04/1987'),
    (1, 'Gênero', 'Feminino'),
    (1, 'Estado', 'RJ'),
    (1, 'Cidade', 'Rio de Janeiro'),
    
    (2, 'Nascimento', '10/09/1991'),
    (2, 'Gênero', 'Masculino'),
    (2, 'Estado', 'SP'),
    (2, 'Cidade', 'São Paulo'),
    
    (3, 'Nascimento', '31/12/1989'),
    (3, 'Gênero', 'Masculino'),
    (3, 'Estado', 'MG'),
    (3, 'Cidade', 'Belo Horizonte');
```

<table align="center"><thead><tr><th>formId</th><th>userId</th><th>question</th><th>answer</th></tr></thead><tbody><tr><td>1</td><td>100</td><td>Nascimento</td><td>02/04/1987</td></tr><tr><td>2</td><td>100</td><td>Gênero</td><td>Feminino</td></tr><tr><td>3</td><td>100</td><td>Estado</td><td>RJ</td></tr><tr><td>4</td><td>100</td><td>Cidade</td><td>Rio de Janeiro</td></tr><tr><td>5</td><td>101</td><td>Nascimento</td><td>10/09/1991</td></tr><tr><td>6</td><td>101</td><td>Gênero</td><td>Masculino</td></tr><tr><td>7</td><td>101</td><td>Estado</td><td>SP</td></tr><tr><td>8</td><td>101</td><td>Cidade</td><td>São Paulo</td></tr><tr><td>9</td><td>102</td><td>Nascimento</td><td>31/01/2000</td></tr><tr><td>10</td><td>102</td><td>Gênero</td><td>Masculino</td></tr><tr><td>11</td><td>102</td><td>Estado</td><td>MG</td></tr><tr><td>12</td><td>102</td><td>Cidade</td><td>Belo Horizonte</td></tr></tbody></table>

```sql
select 
  userId
, json_arrayagg(question) as `questions`
, json_arrayagg(answer) as `answers`
from forms
group by userId;
```

<table align="center"><thead><tr><th>userId</th><th>questions</th><th>answers</th></tr></thead><tbody><tr><td>1</td><td>[ &quot;Nascimento&quot;, &quot;Gênero&quot;, &quot;Estado&quot;, &quot;Cidade&quot; ]</td><td>[ &quot;02/04/1987&quot;, &quot;Feminino&quot;, &quot;RJ&quot;, &quot;Rio de Janeiro&quot; ]</td></tr><tr><td>2</td><td>[ &quot;Nascimento&quot;, &quot;Gênero&quot;, &quot;Estado&quot;, &quot;Cidade&quot; ]</td><td>[ &quot;10/09/1991&quot;, &quot;Masculino&quot;, &quot;SP&quot;, &quot;São Paulo&quot; ]</td></tr><tr><td>3</td><td>[ &quot;Nascimento&quot;, &quot;Gênero&quot;, &quot;Estado&quot;, &quot;Cidade&quot; ]</td><td>[ &quot;31/12/1989&quot;, &quot;Masculino&quot;, &quot;MG&quot;, &quot;Belo Horizonte&quot; ]</td></tr></tbody></table>

<h4><b>0.8 JSON_OBJECTAGG</b></h4>

```sql
create table forms (
    formId int primary key auto_increment,
    userId int not null,
    question varchar(80),
    answer varchar(80),
    foreign key (userId) references users(userId)
);

insert into forms (userId, question, answer) values
    (1, 'Nascimento', '02/04/1987'),
    (1, 'Gênero', 'Feminino'),
    (1, 'Estado', 'RJ'),
    (1, 'Cidade', 'Rio de Janeiro'),
    
    (2, 'Nascimento', '10/09/1991'),
    (2, 'Gênero', 'Masculino'),
    (2, 'Estado', 'SP'),
    (2, 'Cidade', 'São Paulo'),
    
    (3, 'Nascimento', '31/12/1989'),
    (3, 'Gênero', 'Masculino'),
    (3, 'Estado', 'MG'),
    (3, 'Cidade', 'Belo Horizonte');
```

<table align="center"><thead><tr><th>formId</th><th>userId</th><th>question</th><th>answer</th></tr></thead><tbody><tr><td>1</td><td>100</td><td>Nascimento</td><td>02/04/1987</td></tr><tr><td>2</td><td>100</td><td>Gênero</td><td>Feminino</td></tr><tr><td>3</td><td>100</td><td>Estado</td><td>RJ</td></tr><tr><td>4</td><td>100</td><td>Cidade</td><td>Rio de Janeiro</td></tr><tr><td>5</td><td>101</td><td>Nascimento</td><td>10/09/1991</td></tr><tr><td>6</td><td>101</td><td>Gênero</td><td>Masculino</td></tr><tr><td>7</td><td>101</td><td>Estado</td><td>SP</td></tr><tr><td>8</td><td>101</td><td>Cidade</td><td>São Paulo</td></tr><tr><td>9</td><td>102</td><td>Nascimento</td><td>31/01/2000</td></tr><tr><td>10</td><td>102</td><td>Gênero</td><td>Masculino</td></tr><tr><td>11</td><td>102</td><td>Estado</td><td>MG</td></tr><tr><td>12</td><td>102</td><td>Cidade</td><td>Belo Horizonte</td></tr></tbody></table>

```sql
select 
  userId
, json_objectagg(question, answer) as `questions_answers`
from forms
group by userId;
```

<table align="center"><thead><tr><th>userId</th><th>questions_answers</th></tr></thead><tbody><tr><td>1</td><td>{ &quot;Cidade&quot;: &quot;Rio de Janeiro&quot;, &quot;Estado&quot;: &quot;RJ&quot;, &quot;Gênero&quot;: &quot;Feminino&quot;, &quot;Nascimento&quot;: &quot;02/04/1987&quot; }</td></tr><tr><td>2</td><td>{ &quot;Cidade&quot;: &quot;São Paulo&quot;, &quot;Estado&quot;: &quot;SP&quot;, &quot;Gênero&quot;: &quot;Masculino&quot;, &quot;Nascimento&quot;: &quot;10/09/1991&quot; }</td></tr><tr><td>3</td><td>{ &quot;Cidade&quot;: &quot;Belo Horizonte&quot;, &quot;Estado&quot;: &quot;MG&quot;, &quot;Gênero&quot;: &quot;Masculino&quot;, &quot;Nascimento&quot;: &quot;31/12/1989&quot; }</td></tr></tbody></table>

<h1><b>1. CONSULTANDO JSON: json_extract, json_unquote</b></h1>

<p align="justify">Supondo a seguinte tabela "<b>pedidos</b>":</p>

```sql
create table pedidos (ID int not null auto_increment, 
                      DataCompra timestamp default current_timestamp,
                      comprador_ID int,
                      produtos_ID_1 text,     # array
                      produtos_ID_2 json,     # json completo
                      primary key (ID));

insert into pedidos values
(ID, current_timestamp, 1, "[1, 2, 3]", '{"IDs":[1, 2, 3], "produtos":["maça", "cigarro", "pão"]}'),
(ID, current_timestamp, 2, "[1, 3, 4]", '{"IDs":[1, 3, 4], "produtos":["maça", "pão", "leite"]}'),
(ID, current_timestamp, 3, "[3, 4, 5]", '{"IDs":[3, 4, 5], "produtos":["pão", "leite", "bolo"]}'),
(ID, current_timestamp, 4, "[7]"      , '{"IDs":[7],       "produtos":["jujuba"]}'),
(ID, current_timestamp, 2, "[2, 3, 4]", '{"IDs":[2, 3, 4], "produtos":["cigarro", "pão", "leite"]}'),
(ID, current_timestamp, 2, "[9]"      , '{"IDs":[9],       "produtos":["isqueiro"]}'),
(ID, current_timestamp, 2, "[11, 12]" , '{"IDs":[11, 12],  "produtos":["fuzil", "ácido de bateria"]}');
```

<table align="center">
  <thead><tr><th>ID</th><th>DataCompra</th><th>comprador_ID</th><th>produtos_ID_1</th><th>produtos_ID_2</th></tr></thead><tbody><tr><td>1</td><td>2023-05-28 16:06:05</td><td>1</td><td>[1, 2, 3]</td><td>{&quot;IDs&quot;: [1, 2, 3], &quot;produtos&quot;: [&quot;maça&quot;, &quot;cigarro&quot;, &quot;pão&quot;]}</td></tr><tr><td>2</td><td>2023-05-28 16:06:05</td><td>2</td><td>[1, 3, 4]</td><td>{&quot;IDs&quot;: [1, 3, 4], &quot;produtos&quot;: [&quot;maça&quot;, &quot;pão&quot;, &quot;leite&quot;]}</td></tr><tr><td>3</td><td>2023-05-28 16:06:05</td><td>3</td><td>[3, 4, 5]</td><td>{&quot;IDs&quot;: [3, 4, 5], &quot;produtos&quot;: [&quot;pão&quot;, &quot;leite&quot;, &quot;bolo&quot;]}</td></tr><tr><td>4</td><td>2023-05-28 16:06:05</td><td>4</td><td>[7]</td><td>{&quot;IDs&quot;: [7], &quot;produtos&quot;: [&quot;jujuba&quot;]}</td></tr><tr><td>5</td><td>2023-05-28 16:06:05</td><td>2</td><td>[2, 3, 4]</td><td>{&quot;IDs&quot;: [2, 3, 4], &quot;produtos&quot;: [&quot;cigarro&quot;, &quot;pão&quot;, &quot;leite&quot;]}</td></tr><tr><td>6</td><td>2023-05-28 16:06:05</td><td>2</td><td>[9]</td><td>{&quot;IDs&quot;: [9], &quot;produtos&quot;: [&quot;isqueiro&quot;]}</td></tr><tr><td>7</td><td>2023-05-28 16:06:05</td><td>2</td><td>[11, 12]</td><td>{&quot;IDs&quot;: [11, 12], &quot;produtos&quot;: [&quot;fuzil&quot;, &quot;ácido de bateria&quot;]}</td></tr></tbody>
</table>

<p align="justify">Enquanto a coluna <b>produtos_ID_1</b> é um array JSON, <b>produtos_ID_2</b> é um JSON completo, com chaves e elementos (arrays). Pode-se acessar tano as chaves como os elementos pontualmente:</p>

```sql
select 
    p.ID
  , p.produtos_ID_1 ->> '$[0]'             as posicional
  , p.produtos_ID_2 ->> '$.produtos'       as chave
  , p.produtos_ID_2 ->> '$.produtos[0]'    as positional_e_chave
  , p.produtos_ID_2 -> '$.produtos[0]'     as positional_e_chave_quoted
  
from pedidos p;
```

<table align="center">
  <thead><tr><th>ID</th><th>posicional</th><th>chave</th><th>positional_e_chave</th><th>positional_e_chave_quoted</th></tr></thead><tbody><tr><td>1</td><td>1</td><td>[&quot;maça&quot;, &quot;cigarro&quot;, &quot;pão&quot;]</td><td>maça</td><td>&quot;maça&quot;</td></tr><tr><td>2</td><td>1</td><td>[&quot;maça&quot;, &quot;pão&quot;, &quot;leite&quot;]</td><td>maça</td><td>&quot;maça&quot;</td></tr><tr><td>3</td><td>3</td><td>[&quot;pão&quot;, &quot;leite&quot;, &quot;bolo&quot;]</td><td>pão</td><td>&quot;pão&quot;</td></tr><tr><td>4</td><td>7</td><td>[&quot;jujuba&quot;]</td><td>jujuba</td><td>&quot;jujuba&quot;</td></tr><tr><td>5</td><td>2</td><td>[&quot;cigarro&quot;, &quot;pão&quot;, &quot;leite&quot;]</td><td>cigarro</td><td>&quot;cigarro&quot;</td></tr><tr><td>6</td><td>9</td><td>[&quot;isqueiro&quot;]</td><td>isqueiro</td><td>&quot;isqueiro&quot;</td></tr><tr><td>7</td><td>11</td><td>[&quot;fuzil&quot;, &quot;ácido de bateria&quot;]</td><td>fuzil</td><td>&quot;fuzil&quot;</td></tr></tbody>
</table>

<ul>
  <li><p align="justify"><b>2ª col - "posicional":</b>Usado quando a coluna possui um array JSON. Retorna o elemento no array numa dada posição (no exemplo, posição 0). Usa-se <b>colchetes</b>, apenas, para indicar o nº da posição;</p></li>
  <li><p align="justify"><b>3ª col - "chave":</b>Usado qunando a coluna possui um JSON completo. Retorna o conteúdo de uma dada chave (no exemplo, da chave "produtos"). Usa-se a <b>pontuação</b>, apenas, para indicar o nome da chave;</p></li>
  <li><p align="justify"><b>4ª col - "positional_e_chave":</b>Usado quando a coluna possui um JSON completo. Retorna o elemento de uma dada posição de uma dada chave, sem as aspas. Usa-se tanto a <b>pontuação quanto o colchetes</b>, para indicar a chave e a posição, além de <b>seta dupla</b> para remover as aspas;</p></li>
  <li><p align="justify"><b>5ª col - "positional_e_chave_quoted":</b>Usado quando a coluna possui um JSON completo. Mesmo caso da 4ª coluna. Contudo, a <b>"mono-seta"</b> retorna o conteúdo como <b>string</b>.</p></li>
</ul>

<p align="justify">A função <b>json_extract</b> tem o mesmo efeito que o uso de setas para acessar o conteúdo de um array ou JSON completo, enquanto <b>json_unquote</b>possui o mesmo efeito que a seta dupla para remover as aspas:</p>

```sql
select 
    p.ID
  , json_extract(p.produtos_ID_1, '$[0]')                         as posicional_2
  , json_extract(p.produtos_ID_2, '$.produtos')                   as chave_2
  , json_unquote(json_extract(p.produtos_ID_2, '$.produtos[0]'))  as positional_e_chave_2
  , json_extract(p.produtos_ID_2, '$.produtos[0]')                as positional_e_chave_quoted_2
    
from pedidos p;
```

<table align="center">
  <thead><tr><th>ID</th><th>posicional_2</th><th>chave_2</th><th>positional_e_chave_2</th><th>positional_e_chave_quoted_2</th></tr></thead><tbody><tr><td>1</td><td>1</td><td>[&quot;maça&quot;, &quot;cigarro&quot;, &quot;pão&quot;]</td><td>maça</td><td>&quot;maça&quot;</td></tr><tr><td>2</td><td>1</td><td>[&quot;maça&quot;, &quot;pão&quot;, &quot;leite&quot;]</td><td>maça</td><td>&quot;maça&quot;</td></tr><tr><td>3</td><td>3</td><td>[&quot;pão&quot;, &quot;leite&quot;, &quot;bolo&quot;]</td><td>pão</td><td>&quot;pão&quot;</td></tr><tr><td>4</td><td>7</td><td>[&quot;jujuba&quot;]</td><td>jujuba</td><td>&quot;jujuba&quot;</td></tr><tr><td>5</td><td>2</td><td>[&quot;cigarro&quot;, &quot;pão&quot;, &quot;leite&quot;]</td><td>cigarro</td><td>&quot;cigarro&quot;</td></tr><tr><td>6</td><td>9</td><td>[&quot;isqueiro&quot;]</td><td>isqueiro</td><td>&quot;isqueiro&quot;</td></tr><tr><td>7</td><td>11</td><td>[&quot;fuzil&quot;, &quot;ácido de bateria&quot;]</td><td>fuzil</td><td>&quot;fuzil&quot;</td></tr></tbody>
</table>

<h1><b>2. QUEBRANDO JSON ARRAY DE UMA COL EM LINHAS: json_table</b></h1>

<p align="justify">Supondo a seguinte tabela "<b>inscricoes</b>":</p>

```sql
create table inscricoes (chefeID INT, 
                         chefe_nome varchar(50), 
                         modalidade varchar(50), 
                         pilotosID TEXT);

insert into inscricoes values
(100, "ANA", "CHEFE DE EQUIPE", "[1, 2, 3]"),
(101, "BETO", "CHEFE DE EQUIPE", "[4]"),
(102, "PACHECO", "CHEFE DE EQUIPE", "[5, 6, 7, 8]"),
(103, "JUNIOR", "CHEFE DE EQUIPE", "[9, 10, 11, 12, 13, 14]"),
(104, "THIAGO", "CHEFE DE EQUIPE", "[15, 16, 17]"),
(105, "DANILO", "CHEFE DE EQUIPE", "[18]"),
(106, "ISAIAS", "CHEFE DE EQUIPE", "[]"),
(107, "WELLINGTON", "CHEFE DE EQUIPE", "[22, 23]"),
(108, "ROSIVALDO", "CHEFE DE EQUIPE", "[24, 25, 26]")
```

<table align="center">
  <thead><tr><th>chefeID</th><th>chefe_nome</th><th>modalidade</th><th>pilotosID</th></tr></thead><tbody><tr><td>100</td><td>ANA</td><td>CHEFE DE EQUIPE</td><td>[1, 2, 3]</td></tr><tr><td>101</td><td>BETO</td><td>CHEFE DE EQUIPE</td><td>[4]</td></tr><tr><td>102</td><td>PACHECO</td><td>CHEFE DE EQUIPE</td><td>[5, 6, 7, 8]</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td></tr><tr><td>104</td><td>THIAGO</td><td>CHEFE DE EQUIPE</td><td>[15, 16, 17]</td></tr><tr><td>105</td><td>DANILO</td><td>CHEFE DE EQUIPE</td><td>[18]</td></tr><tr><td>106</td><td>ISAIAS</td><td>CHEFE DE EQUIPE</td><td>[]</td></tr><tr><td>107</td><td>WELLINGTON</td><td>CHEFE DE EQUIPE</td><td>[22, 23]</td></tr><tr><td>108</td><td>ROSIVALDO</td><td>CHEFE DE EQUIPE</td><td>[24, 25, 26]</td></tr></tbody>
</table>

<p align="justify">A seguinte query abaixo quebra cada elemento dos arrays da coluna <b>pilotosID</b> em linhas com <b>JSON_TABLE</b>:</p>

```sql
select 
    i.*
  , js_table_pilotos.*
from inscricoes i

join

json_table(
    i.pilotosID
  , '$[*]' columns(PilotoID int path '$')
) js_table_pilotos
```

<table align="center">
  <thead><tr><th>chefeID</th><th>chefe_nome</th><th>modalidade</th><th>pilotosID</th><th>PilotoID</th></tr></thead><tbody><tr><td>100</td><td>ANA</td><td>CHEFE DE EQUIPE</td><td>[1, 2, 3]</td><td>1</td></tr><tr><td>100</td><td>ANA</td><td>CHEFE DE EQUIPE</td><td>[1, 2, 3]</td><td>2</td></tr><tr><td>100</td><td>ANA</td><td>CHEFE DE EQUIPE</td><td>[1, 2, 3]</td><td>3</td></tr><tr><td>101</td><td>BETO</td><td>CHEFE DE EQUIPE</td><td>[4]</td><td>4</td></tr><tr><td>102</td><td>PACHECO</td><td>CHEFE DE EQUIPE</td><td>[5, 6, 7, 8]</td><td>5</td></tr><tr><td>102</td><td>PACHECO</td><td>CHEFE DE EQUIPE</td><td>[5, 6, 7, 8]</td><td>6</td></tr><tr><td>102</td><td>PACHECO</td><td>CHEFE DE EQUIPE</td><td>[5, 6, 7, 8]</td><td>7</td></tr><tr><td>102</td><td>PACHECO</td><td>CHEFE DE EQUIPE</td><td>[5, 6, 7, 8]</td><td>8</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>9</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>10</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>11</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>12</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>13</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>14</td></tr><tr><td>104</td><td>THIAGO</td><td>CHEFE DE EQUIPE</td><td>[15, 16, 17]</td><td>15</td></tr><tr><td>104</td><td>THIAGO</td><td>CHEFE DE EQUIPE</td><td>[15, 16, 17]</td><td>16</td></tr><tr><td>104</td><td>THIAGO</td><td>CHEFE DE EQUIPE</td><td>[15, 16, 17]</td><td>17</td></tr><tr><td>105</td><td>DANILO</td><td>CHEFE DE EQUIPE</td><td>[18]</td><td>18</td></tr><tr><td>107</td><td>WELLINGTON</td><td>CHEFE DE EQUIPE</td><td>[22, 23]</td><td>22</td></tr><tr><td>107</td><td>WELLINGTON</td><td>CHEFE DE EQUIPE</td><td>[22, 23]</td><td>23</td></tr><tr><td>108</td><td>ROSIVALDO</td><td>CHEFE DE EQUIPE</td><td>[24, 25, 26]</td><td>24</td></tr><tr><td>108</td><td>ROSIVALDO</td><td>CHEFE DE EQUIPE</td><td>[24, 25, 26]</td><td>25</td></tr><tr><td>108</td><td>ROSIVALDO</td><td>CHEFE DE EQUIPE</td><td>[24, 25, 26]</td><td>26</td></tr></tbody>
</table>

<p align="justify">A função <b>json_table</b> tem como argumentos:</p>
<ul>
  <li><b>1º argumento:</b> Coluna de conteúdo JSON (<b>i.pilotosID</b>);</li>
  <li><b>2º argumento:</b> O <b>primeiro componente</b> é a extração do conteúdo (<b>'$[*]'</b>). O <b>segundo componente</b> é a conversão em coluna, dando nome (<b>PilotoID</b>) e tipagem (<b>int path '$'</b>).</li>
</ul>

<p align="justify">Não é necessário declarar a cláusula <b>on</b> neste caso, pois, de maneira implícita é entendido o vínculo de cada elemento, repetindo os demais elementos linha a linha <b>n</b> vezes, sendo <b>n</b> o nº de elementos extarído do JSON.</p>
<p align="justify"><b>Nota:</b> Só é possível <b>inner join</b>, portanto, para casos em que haja elementos vazios no JSON, será necessária uma subquery puxando os vazios e unindo ambos os resultados através de <b>union all</b>. Repare que o ISAIAS não possui piloto atrelado a ele, e como só é possível <b>inner join</b>, ele foi removido do resultado. Caso se quisesse ver todos os casos, quem tem ou não conteúdo algum conteúdo (neste caso, piloto atrelado), ter-se-ia que:</p>

```sql
-- 1ª subquery
select a.* from 
(
  select 
      i.*
    , js_table_pilotos.*
  from inscricoes i

  join

  json_table(
      i.pilotosID
    , '$[*]' columns(PilotoID int path '$')
  ) js_table_pilotos
) as a



union all


-- 2ª subquery
select 
	i.*
  , null as PilotoID       -- gerar mesmas cols da subquery 1
from inscricoes i
where i.pilotosID = "[]"   -- somente os sem registro
```

<table align="center">
  <thead><tr><th>chefeID</th><th>chefe_nome</th><th>modalidade</th><th>pilotosID</th><th>PilotoID</th></tr></thead><tbody><tr><td>100</td><td>ANA</td><td>CHEFE DE EQUIPE</td><td>[1, 2, 3]</td><td>1</td></tr><tr><td>100</td><td>ANA</td><td>CHEFE DE EQUIPE</td><td>[1, 2, 3]</td><td>2</td></tr><tr><td>100</td><td>ANA</td><td>CHEFE DE EQUIPE</td><td>[1, 2, 3]</td><td>3</td></tr><tr><td>101</td><td>BETO</td><td>CHEFE DE EQUIPE</td><td>[4]</td><td>4</td></tr><tr><td>102</td><td>PACHECO</td><td>CHEFE DE EQUIPE</td><td>[5, 6, 7, 8]</td><td>5</td></tr><tr><td>102</td><td>PACHECO</td><td>CHEFE DE EQUIPE</td><td>[5, 6, 7, 8]</td><td>6</td></tr><tr><td>102</td><td>PACHECO</td><td>CHEFE DE EQUIPE</td><td>[5, 6, 7, 8]</td><td>7</td></tr><tr><td>102</td><td>PACHECO</td><td>CHEFE DE EQUIPE</td><td>[5, 6, 7, 8]</td><td>8</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>9</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>10</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>11</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>12</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>13</td></tr><tr><td>103</td><td>JUNIOR</td><td>CHEFE DE EQUIPE</td><td>[9, 10, 11, 12, 13, 14]</td><td>14</td></tr><tr><td>104</td><td>THIAGO</td><td>CHEFE DE EQUIPE</td><td>[15, 16, 17]</td><td>15</td></tr><tr><td>104</td><td>THIAGO</td><td>CHEFE DE EQUIPE</td><td>[15, 16, 17]</td><td>16</td></tr><tr><td>104</td><td>THIAGO</td><td>CHEFE DE EQUIPE</td><td>[15, 16, 17]</td><td>17</td></tr><tr><td>105</td><td>DANILO</td><td>CHEFE DE EQUIPE</td><td>[18]</td><td>18</td></tr><tr><td>107</td><td>WELLINGTON</td><td>CHEFE DE EQUIPE</td><td>[22, 23]</td><td>22</td></tr><tr><td>107</td><td>WELLINGTON</td><td>CHEFE DE EQUIPE</td><td>[22, 23]</td><td>23</td></tr><tr><td>108</td><td>ROSIVALDO</td><td>CHEFE DE EQUIPE</td><td>[24, 25, 26]</td><td>24</td></tr><tr><td>108</td><td>ROSIVALDO</td><td>CHEFE DE EQUIPE</td><td>[24, 25, 26]</td><td>25</td></tr><tr><td>108</td><td>ROSIVALDO</td><td>CHEFE DE EQUIPE</td><td>[24, 25, 26]</td><td>26</td></tr><tr><td>106</td><td>ISAIAS</td><td>CHEFE DE EQUIPE</td><td>[]</td><td></td></tr></tbody>
</table>

<p align="justify">Enquanto a 1ª subquery é a quebra em linhas com json_table, a 2ª subquery é para retornar apenas os casos vazios. Para a união de ambas as consultas com <b>union all</b>, elas devem ter a mesma quantidade de colunas e com os mesmos nomes. Por isso, é criada uma coluna nula na 2ª subquery com o mesmo nome da respectiva coluna na 1ª subquery.</p>

<p align="justify"><b>NOTA:</b> Também é possível operar com JSON_TABLE nos joins iniciais. Útil para evitar subqueries (sub_A join JSON_TABLE). Da seguinte forma:</p>

```sql
select 
  i.`id` as `InscricaoID`
, p.`id` as `PedidoID`
, upper(i.`nome`) as `Chefe`
, i.detalhes ->> '$.team' as `time`
from inscricoes i
        left join evento_modalidade_categoria emc                                   on i.evento_modalidade_categoria_id = emc.id
        left join evento_modalidade em                                              on emc.evento_modalidade_id = em.id
        left join eventos e                                                         on e.id = em.evento_id
        left join pedidos p                                                         on p.id = i.pedido_id
        left join kits k                                                            on i.kit_id = k.id
        left join usuarios u                                                        on u.id = p.usuario_id

join

json_table(
    i.detalhes ->> '$.team'
  , '$[*]' columns(PilotoID int path '$')
) js_table

    where e.evento = "30 ª EDIÇÃO RALLY DOS SERTÕES 2022"
      and p.status = '1'
      and i.status = '1'
      and em.nome <> "EXTRAS"
      and em.nome = 'Chefe de Equipe'
```

<h1><b>3. COMPARAÇÃO ENTRE ARRAYS: json_overlaps</b></h1>

<p align="justify">Imagine que haja duas tabelas relacionadas e que possuem cada uma um JSON array, e que este array é referente a mesma informação. Mas, que pode existir em um registro de uma tabela mas não existir no registro da outra e vice-versa. Como no diagrama abaixo:</p>

<p align="center">
	<img src="https://lh3.googleusercontent.com/pw/AJFCJaVpPQrVjezD0Yf2pjcaHbuWsKooZWSKdgLo9X7HxkeKpR5uk9ImiIYbxXLc88quA0vEzBuGOm9DBwXGDJNVXs3il1tyg3PQO-Q5CH982V2IUoYFE5KnmXEo2RmFWujeWxDbGhC1Oj6i5rBuBCy5EMYqvA=w625-h441-s-no?authuser=0">
</p>

<p align="justify">É possível comparar um array com outro e retornar aqueles que existem em ambas com o uso de <b>json_overlaps</b>. Sua sintaxe:</p>

```
json_overlaps(<array 1>, <array 2>)
```

<p align="justify">Dadas as seguintes tabelas:</p>

```sql
create table cupons (ID int NOT NULL AUTO_INCREMENT,
                     TIPO varchar(50),
                     desconto float(10,2),
                     kit text,
                     primary key (ID));

insert into cupons values
(null, "percentual", 0.10, "[1, 3]"),
(null, "integral", 1.00, "[7]"),
(null, "valor", 120, "[9, 11]");
```

<table align="center">
	<thead><tr><th>ID</th><th>TIPO</th><th>desconto</th><th>kit</th></tr></thead><tbody><tr><td>1</td><td>percentual</td><td>0.1</td><td>[1, 3]</td></tr><tr><td>2</td><td>integral</td><td>1</td><td>[7]</td></tr><tr><td>3</td><td>valor</td><td>120</td><td>[9, 11]</td></tr></tbody>
</table>

```sql
create table pilotos (ID int auto_increment, 
                      piloto_nome varchar(50),
                      kit_ID int,
                      primary key (ID));

insert into pilotos values
(ID, "ADALBERTO", 1),
(ID, "MARCOS", 1),
(ID, "JAIRO", 2),
(ID, "CLAUDIO", 2),
(ID, "MAURICIO", 1),
(ID, "VITOR", 3),
(ID, "YURI", 4),
(ID, "GAGARIN", 7),
(ID, "MASLOW", 7);
```

<table align="center">
	<thead><tr><th>ID</th><th>piloto_nome</th><th>kit_ID</th></tr></thead><tbody><tr><td>1</td><td>ADALBERTO</td><td>1</td></tr><tr><td>2</td><td>MARCOS</td><td>1</td></tr><tr><td>3</td><td>JAIRO</td><td>2</td></tr><tr><td>4</td><td>CLAUDIO</td><td>2</td></tr><tr><td>5</td><td>MAURICIO</td><td>1</td></tr><tr><td>6</td><td>VITOR</td><td>3</td></tr><tr><td>7</td><td>YURI</td><td>4</td></tr><tr><td>8</td><td>GAGARIN</td><td>7</td></tr><tr><td>9</td><td>MASLOW</td><td>7</td></tr></tbody>
</table>

<p align="justify">A tabela <b>pilotos</b> contém os pilotos e seus kits, enquanto a tabela <b>cupons</b> tem os kits válidos para o referido cupom. E se quisessemos <b>ver os pilotos que têm kit passível de cupom</b>?</p>

```sql
select p.* from pilotos p
  where json_overlaps(
                      # 1º argumento: transforma cada registro de kit_ID em um array
                      (json_array(p.kit_ID))                       
                      ,
                      # 2º argumento: pega todos os IDs dos kits e os transforma em um único array
                      (select 
                        json_arrayagg(JTc.JS_cupom)
                          from cupons c
                            join
                        json_table(c.kit, '$[*]' columns(JS_cupom int path '$')) as JTc)
                     );
```

<table align="center">
	<thead><tr><th>ID</th><th>piloto_nome</th><th>kit_ID</th></tr></thead><tbody><tr><td>1</td><td>ADALBERTO</td><td>1</td></tr><tr><td>2</td><td>MARCOS</td><td>1</td></tr><tr><td>5</td><td>MAURICIO</td><td>1</td></tr><tr><td>6</td><td>VITOR</td><td>3</td></tr><tr><td>8</td><td>GAGARIN</td><td>7</td></tr><tr><td>9</td><td>MASLOW</td><td>7</td></tr></tbody>
</table>

<p align="justify">A query produziu o resultado acima, que contém apenas os pilotos que possuem um kit passível de uso de cupom. A função <b>json_overlaps</b> foi inserida na cláusula <b>where</b> por se tratar de uma filtragem. Note que cada argumento é uma query, contidas entre parênteses. Enquanto o 1º argumento transforma linha a linha o ID do kit em um array (com função <b>json_array</b> que transforma em array cada registro de uma coluna), o 2º argumento transforma em um único e grande array todos IDs de kits registrados em algum cupom (isto foi feito com a função <b>json_arrayagg</b>, sendo uma <b>window function</b> que gera arrays).</p>

<p align="justify">Para melhor entender cada argumento:</p>
<p align="justify"><b>1º argumento: query 1 com function <i>json_array</i></b></p>

```sql
select
  p.*
, json_array(p.kit_ID)
from pilotos p;
```

<table align="center">
	<thead><tr><th>ID</th><th>piloto_nome</th><th>kit_ID</th><th>json_array(p.kit_ID)</th></tr></thead><tbody><tr><td>1</td><td>ADALBERTO</td><td>1</td><td>[1]</td></tr><tr><td>2</td><td>MARCOS</td><td>1</td><td>[1]</td></tr><tr><td>3</td><td>JAIRO</td><td>2</td><td>[2]</td></tr><tr><td>4</td><td>CLAUDIO</td><td>2</td><td>[2]</td></tr><tr><td>5</td><td>MAURICIO</td><td>1</td><td>[1]</td></tr><tr><td>6</td><td>VITOR</td><td>3</td><td>[3]</td></tr><tr><td>7</td><td>YURI</td><td>4</td><td>[4]</td></tr><tr><td>8</td><td>GAGARIN</td><td>7</td><td>[7]</td></tr><tr><td>9</td><td>MASLOW</td><td>7</td><td>[7]</td></tr></tbody>
</table>

<p align="justify"><b>2º argumento: query 2 com window function <i>json_arrayagg</i></b></p>

```sql
select 
json_arrayagg(JTc.JS_cupom)
from cupons c

join

json_table(c.kit, 
           '$[*]' columns(JS_cupom int path '$')
          ) as JTc;
```

<table align="center">
	<thead><tr><th>json_arrayagg(JTc.JS_cupom)</th></tr></thead><tbody><tr><td>[1, 3, 7, 9, 11]</td></tr></tbody>
</table>

<p align="justify">Por se tratar de uma window function, <b>json_arrayagg</b> pode ser usada com particionamento através da cláusula <b>over(partition by <i>col</i>)</b>:</p>

```sql
select 
  c.*
, json_arrayagg(JTc.JS_cupom) over(partition by c.tipo) as `array particionado por tipo de cupom`
from cupons c

join

json_table(c.kit, 
           '$[*]' columns(JS_cupom int path '$')
          ) as JTc;
```

<table align="center">
	<thead><tr><th>ID</th><th>TIPO</th><th>desconto</th><th>kit</th><th>array particionado por tipo de cupom</th></tr></thead><tbody><tr><td>2</td><td>integral</td><td>1</td><td>[7]</td><td>[7]</td></tr><tr><td>1</td><td>percentual</td><td>0.1</td><td>[1, 3]</td><td>[1, 3]</td></tr><tr><td>1</td><td>percentual</td><td>0.1</td><td>[1, 3]</td><td>[1, 3]</td></tr><tr><td>3</td><td>valor</td><td>120</td><td>[9, 11]</td><td>[9, 11]</td></tr><tr><td>3</td><td>valor</td><td>120</td><td>[9, 11]</td><td>[9, 11]</td></tr></tbody>
</table>

<h1><b>4. ITENS EM PEDIDOS - CONSULTANDO PEDIDOS QUE CONTÊM CERTOS ITENS: json_arrayagg, json_length, json_search</b></h1>

<p align="justify">
	Imagina a seguinte tabela:
</p>

```sql
create table produtosVendidos (
  itemID     int       not null auto_increment,
  pedidoID   int       not null,
  dataCompra date      not null,
  nome       text      not null,
  preco      float     not null,
  primary key (itemID)
  );

insert into produtosVendidos values 
(itemID, 101, '2023-06-01', 'pão', 0.20),
(itemID, 101, '2023-06-01', 'leite', 2.80),
(itemID, 101, '2023-06-01', 'leite', 2.80),
(itemID, 101, '2023-06-01', 'manteiga', 1.30),
(itemID, 102, '2023-06-04', 'pão', 0.20), 
(itemID, 102, '2023-06-04', 'manteiga', 1.30), 
(itemID, 103, '2023-06-01', 'leite', 2.80),
(itemID, 103, '2023-06-07', 'presunto', 1.80)
;

select * from produtosVendidos;
```

<table align="center"><thead><tr><th>itemID</th><th>pedidoID</th><th>dataCompra</th><th>nome</th><th>preco</th></tr></thead><tbody><tr><td>1</td><td>101</td><td>2023-06-01</td><td>pão</td><td>0.2</td></tr><tr><td>2</td><td>101</td><td>2023-06-01</td><td>leite</td><td>2.8</td></tr><tr><td>3</td><td>101</td><td>2023-06-01</td><td>leite</td><td>2.8</td></tr><tr><td>4</td><td>101</td><td>2023-06-01</td><td>manteiga</td><td>1.3</td></tr><tr><td>5</td><td>102</td><td>2023-06-04</td><td>pão</td><td>0.2</td></tr><tr><td>6</td><td>102</td><td>2023-06-04</td><td>manteiga</td><td>1.3</td></tr><tr><td>7</td><td>103</td><td>2023-06-01</td><td>leite</td><td>2.8</td></tr><tr><td>8</td><td>103</td><td>2023-06-07</td><td>presunto</td><td>1.8</td></tr></tbody></table>

<p align="justify">
	Caso quisessemos ver os itens vendidos que são de algum tipo, bastaria filtrar. Como, por exemplo, o produto leite:
</p>

```sql
select * from produtosVendidos where nome = 'leite';
```

<table align="center"><thead><tr><th>itemID</th><th>pedidoID</th><th>dataCompra</th><th>nome</th><th>preco</th></tr></thead><tbody><tr><td>2</td><td>101</td><td>2023-06-01</td><td>leite</td><td>2.8</td></tr><tr><td>3</td><td>101</td><td>2023-06-01</td><td>leite</td><td>2.8</td></tr><tr><td>7</td><td>103</td><td>2023-06-01</td><td>leite</td><td>2.8</td></tr></tbody></table>

<p align="justify">
	Note que cada linha é um produto vendido dentro de um pedido, ou seja, a quantidade de linhas como mesmo `pedidoID` é a quantidade de itens daquele pedido. Assim, para ver em quais pedidos o produto leite foi vendido a consulta acima atende. Mas, e se quisessemos pegar todos os itens dos pedidos que tem algum leite vendido? E a quantidade de leites destes pedidos? Neste caso, pode-se trabalhar com funções JSON, fazendo arrays dos itens particionados por pedido.
</p>

<p align="jusitfy">Das 3 funções JSON, temos:</p>

<p align="justify">
	Função JSON_ARRAYAGG, que cria um array com os elementos de uma coluna e funciona com partições `over(partition by)`.
</p>

```sql
JSON_ARRAYAGG(arg1) OVER(PARTITION BY arg2)
```

<ul>
	<li><p><b>arg1: </b>Coluna com elementos que virarão array JSON (`nomes`);</p></li>
	<li><p><b>arg2: </b>Coluna com elementos que particionarão cada array (`pedidoID`);</p></li>
</ul>

<p align="justify">
	Função JSON_SEARCH, que procura um determinado elemento no conjunto de elementos de um array JSON.
</p>

```sql
JSON_SEARCH(arg1, arg2, arg3)
```

<ul>
	<li><p align="justify"><b>arg1: </b>Coluna com arrays. Que, neste exemplo, será a função JSON_ARAYAGG;</p></li>
	<li><p align="justify"><b>arg2: </b>Argumento que pode ser ‘one’ ou ‘all’. Quando ‘one’, indica para retornar a 1ª posição encontrada do elemento a se procurar. Quando ‘all’ retorna todas as posições encontradas do elemento a se procurar no array. Com ambos argumentos, será retornado como resultado um array de cada posição;</p></li>
	<li><p align="justify"><b>arg3: </b>Elemento a ser procurado, uma string.</p></li>
</ul>

<p align="justify">
	Função JSON_LENGTH, que retorna o tamanho, a quantidade de elementos dentro de um array JSON.
</p>

```sql
JSON_LENGTH(array json)
```

```sql
select 
  pv.`itemID`
, pv.`pedidoID`
, json_arrayagg(pv.`nome`) over(partition by pv.`pedidoID`) as `produtos no pedido`
, json_length(json_arrayagg(pv.`nome`) over(partition by pv.`pedidoID`)) as `itens/pedido`
, json_search(json_arrayagg(pv.`nome`) over(partition by pv.`pedidoID`), 'one', 'leite') as `posição do 1º leite`
, json_search(json_arrayagg(pv.`nome`) over(partition by pv.`pedidoID`), 'all', 'leite') as `posição dos leites`
, case when isnull(json_search(json_arrayagg(pv.`nome`) over(partition by pv.`pedidoID`), 'one', 'leite')) 
       then 'sem leite' 
       else 'com leite' end as `tem leite?`
, json_length(json_search(json_arrayagg(pv.`nome`) over(partition by pv.`pedidoID`), 'all', 'leite')) as `quantos leites no pedido?`
, pv.`dataCompra`
, pv.`nome`
, pv.`preco`
from produtosVendidos pv;
```

<table align="center"><thead><tr><th>itemID</th><th>pedidoID</th><th>dataCompra</th><th>nome</th><th>preco</th><th>produtos no pedido</th><th>itens/pedido</th><th>posição do 1º leite</th><th>posição dos leites</th><th>tem leite?</th><th>quantos leites no pedido?</th></tr></thead><tbody><tr><td>1</td><td>101</td><td>2023-06-01</td><td>pão</td><td>0.2</td><td>[&quot;pão&quot;, &quot;leite&quot;, &quot;leite&quot;, &quot;manteiga&quot;]</td><td>4</td><td>&quot;$[1]&quot;</td><td>[&quot;$[1]&quot;, &quot;$[2]&quot;]</td><td>com leite</td><td>2</td></tr><tr><td>2</td><td>101</td><td>2023-06-01</td><td>leite</td><td>2.8</td><td>[&quot;pão&quot;, &quot;leite&quot;, &quot;leite&quot;, &quot;manteiga&quot;]</td><td>4</td><td>&quot;$[1]&quot;</td><td>[&quot;$[1]&quot;, &quot;$[2]&quot;]</td><td>com leite</td><td>2</td></tr><tr><td>3</td><td>101</td><td>2023-06-01</td><td>leite</td><td>2.8</td><td>[&quot;pão&quot;, &quot;leite&quot;, &quot;leite&quot;, &quot;manteiga&quot;]</td><td>4</td><td>&quot;$[1]&quot;</td><td>[&quot;$[1]&quot;, &quot;$[2]&quot;]</td><td>com leite</td><td>2</td></tr><tr><td>4</td><td>101</td><td>2023-06-01</td><td>manteiga</td><td>1.3</td><td>[&quot;pão&quot;, &quot;leite&quot;, &quot;leite&quot;, &quot;manteiga&quot;]</td><td>4</td><td>&quot;$[1]&quot;</td><td>[&quot;$[1]&quot;, &quot;$[2]&quot;]</td><td>com leite</td><td>2</td></tr><tr><td>5</td><td>102</td><td>2023-06-04</td><td>pão</td><td>0.2</td><td>[&quot;pão&quot;, &quot;manteiga&quot;]</td><td>2</td><td></td><td></td><td>sem leite</td><td></td></tr><tr><td>6</td><td>102</td><td>2023-06-04</td><td>manteiga</td><td>1.3</td><td>[&quot;pão&quot;, &quot;manteiga&quot;]</td><td>2</td><td></td><td></td><td>sem leite</td><td></td></tr><tr><td>7</td><td>103</td><td>2023-06-01</td><td>leite</td><td>2.8</td><td>[&quot;leite&quot;, &quot;presunto&quot;]</td><td>2</td><td>&quot;$[0]&quot;</td><td>&quot;$[0]&quot;</td><td>com leite</td><td>1</td></tr><tr><td>8</td><td>103</td><td>2023-06-07</td><td>presunto</td><td>1.8</td><td>[&quot;leite&quot;, &quot;presunto&quot;]</td><td>2</td><td>&quot;$[0]&quot;</td><td>&quot;$[0]&quot;</td><td>com leite</td><td>1</td></tr></tbody></table>

<p align="justify">
	Repare que, nas colunas de posição, há em uma a posição apenas do 1º elemento 'leite' encontrado, enquanto na segunda retorna todas as posições que o elemento 'leite' está presente. A coluna 'tem leite?' nada mais é que um teste para ver qual pedido tem leite. Filtrando por ela, <b>retorna todos os pedidos que contêm leite e não somente os itens que são leite</b>. A última coluna, 'quantos leites no pedido?' é o tamanho (length) do array, pois, cada posição é de um elemento 'leite'.
</p>

<h1><b>5. JSON_TABLE QUEBRANDO - SOLUÇÃO</b></h1>

<p align="justify">
	Certas vezes, a função JSON_TABLE pode ter problemas para reconhecer como JSON o campo informado no 1º argumento. Neste caso, pode-se forçar com que ela reconheça imputando a função JSON_EXTRACT no campo. Supondo o DB 'lojinha', uma tabela 'pedidosCartao' contendo várias colunas de datas de compensação de cartão de crédito para os pedidos:
</p>

```sql
-- DDL
CREATE TABLE `pedidoscartao` (
  `IdPedido` int,
  `ValorPedido` decimal(10,2),
  `NumParcelas` int,
  `ValorParcela` decimal(10,2),
  `DataCompra` date,
  `DataCompensacao1` date,
  `DataCompensacao2` date,
  `DataCompensacao3` date,
  `DataCompensacao4` date,
  `DataCompensacao5` date
);

-- consulta
SELECT a.IdPedido, a.ValorPedido, a.NumParcelas, a.ValorParcela, a.DataCompra, jt.datinhas FROM (
SELECT 
  pc.IdPedido, pc.ValorPedido, pc.NumParcelas, pc.ValorParcela, pc.DataCompra
, json_array(pc.DataCompensacao1,pc.DataCompensacao2,pc.DataCompensacao3,pc.DataCompensacao4,pc.DataCompensacao5) AS datas FROM pedidosCartao pc
) AS a
JOIN json_table(json_extract(datas, '$[*]'), '$[*]' COLUMNS(datinhas date PATH '$')) AS jt
WHERE jt.datinhas IS NOT null
;
```

<table align="center"><thead><tr><th>IdPedido</th><th>ValorPedido</th><th>NumParcelas</th><th>ValorParcela</th><th>DataCompra</th><th>datinhas</th></tr></thead><tbody><tr><td>1</td><td>11,2</td><td>3</td><td>3,73</td><td>2023-12-30</td><td>2024-01-29</td></tr><tr><td>1</td><td>11,2</td><td>3</td><td>3,73</td><td>2023-12-30</td><td>2024-02-28</td></tr><tr><td>1</td><td>11,2</td><td>3</td><td>3,73</td><td>2023-12-30</td><td>2024-03-29</td></tr><tr><td>2</td><td>13,3</td><td>4</td><td>3,33</td><td>2023-12-25</td><td>2024-01-24</td></tr><tr><td>2</td><td>13,3</td><td>4</td><td>3,33</td><td>2023-12-25</td><td>2024-02-23</td></tr><tr><td>2</td><td>13,3</td><td>4</td><td>3,33</td><td>2023-12-25</td><td>2024-03-24</td></tr><tr><td>2</td><td>13,3</td><td>4</td><td>3,33</td><td>2023-12-25</td><td>2024-04-23</td></tr><tr><td>3</td><td>10,05</td><td>2</td><td>5,03</td><td>2023-12-17</td><td>2024-01-16</td></tr><tr><td>3</td><td>10,05</td><td>2</td><td>5,03</td><td>2023-12-17</td><td>2024-02-15</td></tr><tr><td>4</td><td>11,55</td><td>5</td><td>2,31</td><td>2023-12-24</td><td>2024-01-23</td></tr><tr><td>4</td><td>11,55</td><td>5</td><td>2,31</td><td>2023-12-24</td><td>2024-02-22</td></tr><tr><td>4</td><td>11,55</td><td>5</td><td>2,31</td><td>2023-12-24</td><td>2024-03-23</td></tr><tr><td>4</td><td>11,55</td><td>5</td><td>2,31</td><td>2023-12-24</td><td>2024-04-22</td></tr><tr><td>4</td><td>11,55</td><td>5</td><td>2,31</td><td>2023-12-24</td><td>2024-05-22</td></tr></tbody></table>

<h1><b>6. SOLUÇÃO ALTERNATIVA À FUNÇÃO JSON_TABLE: CROSS JOIN</b></h1>

<p align="justify">Alternativamente, pode-se usar um CROSS JOIN com uma tabela de referência numérica, em que cada número será uma posição de um elemento no array a ser extraído. Supondo a mesma situação do tópico anterior, com a tabela 'pedidosCartao':</p>

```sql
-- DDL
CREATE TABLE `pedidoscartao` (
  `IdPedido` int,
  `ValorPedido` decimal(10,2),
  `NumParcelas` int,
  `ValorParcela` decimal(10,2),
  `DataCompra` date,
  `DataCompensacao1` date,
  `DataCompensacao2` date,
  `DataCompensacao3` date,
  `DataCompensacao4` date,
  `DataCompensacao5` date
);

-- consulta
SELECT 
	pc.IdPedido, pc.ValorPedido, pc.NumParcelas, pc.ValorParcela, pc.DataCompra, 
	CONVERT(JSON_EXTRACT(pc.Compensacoes, CONCAT('$[', numbers.n, ']')), date) AS Compensacao
FROM (
	SELECT 
	  pc.IdPedido, pc.ValorPedido, pc.NumParcelas, pc.ValorParcela, pc.DataCompra 
	, json_array(pc.DataCompensacao1,pc.DataCompensacao2,pc.DataCompensacao3,pc.DataCompensacao4,pc.DataCompensacao5) Compensacoes
	FROM pedidosCartao pc
) pc

CROSS JOIN

(
    SELECT 0 AS n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
) AS numbers

having Compensacao IS NOT null
ORDER BY pc.IdPedido, pc.Compensacoes
;
```

<table align="center"><thead><tr><th>IdPedido</th><th>ValorPedido</th><th>NumParcelas</th><th>ValorParcela</th><th>DataCompra</th><th>datinhas</th></tr></thead><tbody><tr><td>1</td><td>11,2</td><td>3</td><td>3,73</td><td>2023-12-30</td><td>2024-01-29</td></tr><tr><td>1</td><td>11,2</td><td>3</td><td>3,73</td><td>2023-12-30</td><td>2024-02-28</td></tr><tr><td>1</td><td>11,2</td><td>3</td><td>3,73</td><td>2023-12-30</td><td>2024-03-29</td></tr><tr><td>2</td><td>13,3</td><td>4</td><td>3,33</td><td>2023-12-25</td><td>2024-01-24</td></tr><tr><td>2</td><td>13,3</td><td>4</td><td>3,33</td><td>2023-12-25</td><td>2024-02-23</td></tr><tr><td>2</td><td>13,3</td><td>4</td><td>3,33</td><td>2023-12-25</td><td>2024-03-24</td></tr><tr><td>2</td><td>13,3</td><td>4</td><td>3,33</td><td>2023-12-25</td><td>2024-04-23</td></tr><tr><td>3</td><td>10,05</td><td>2</td><td>5,03</td><td>2023-12-17</td><td>2024-01-16</td></tr><tr><td>3</td><td>10,05</td><td>2</td><td>5,03</td><td>2023-12-17</td><td>2024-02-15</td></tr><tr><td>4</td><td>11,55</td><td>5</td><td>2,31</td><td>2023-12-24</td><td>2024-01-23</td></tr><tr><td>4</td><td>11,55</td><td>5</td><td>2,31</td><td>2023-12-24</td><td>2024-02-22</td></tr><tr><td>4</td><td>11,55</td><td>5</td><td>2,31</td><td>2023-12-24</td><td>2024-03-23</td></tr><tr><td>4</td><td>11,55</td><td>5</td><td>2,31</td><td>2023-12-24</td><td>2024-04-22</td></tr><tr><td>4</td><td>11,55</td><td>5</td><td>2,31</td><td>2023-12-24</td><td>2024-05-22</td></tr></tbody></table>

<h1><b>7. MÚLTIPLOS JSON_TABLE EM VÁRIAS COLUNAS JSON</b></h1>

<p align="justify">
	Imagine a situação:
</p>

```sql
create table exemplo (
  id int auto_increment primary key,
  numsOne int,
  numsTwo JSON,
  numsThree JSON,
  numsFour JSON
);

insert into exemplo values
  (id, 200, '[1,2]', '[60,70]', '[230,460]'),
  (id, 300, '[4,5]', '[80,90]', '[880,990]');

select * from exemplo;
```

<table align="center"><thead><tr><th>id</th><th>numsOne</th><th>numsTwo</th><th>numsThree</th><th>numsFour</th></tr></thead><tbody><tr><td>1</td><td>200</td><td>[1,2]</td><td>[60,70]</td><td>[230,460]</td></tr><tr><td>2</td><td>300</td><td>[4,5]</td><td>[80,90]</td><td>[880,990]</td></tr></tbody></table>

<p align="justify">
	Imagine que cada 1º elemento de cada array faz correlação com os demais 1ºs elementos dos outros arrays do mesmo INSERT e assim sucessivamente. A maneira correta de usar JSON_TABLE neste caso é com uso de ordenador e JOIN entre os JSON_TABLE e con o vínculo ON nos ordenadores:
</p>

```sql
select e.id, e.numsOne, jt1.idx, jt1.numTwo, jt2.numThree, jt3.numFour
from exemplo e
	join json_table(
  		e.numsTwo, '$[*]' columns(
          idx for ordinality, NumTwo int path '$'
        )
    ) as jt1
    	join json_table(
  		e.NumsThree, '$[*]' columns(
          idx for ordinality, NumThree int path '$'
        )
    ) as jt2 on jt1.idx = jt2.idx
    	join json_table(
  		e.NumsFour, '$[*]' columns(
          idx for ordinality, NumFour int path '$'
        )
    ) as jt3  on jt1.idx = jt3.idx
;
```

<table align="center"><thead><tr><th>id</th><th>numsOne</th><th>idx</th><th>numTwo</th><th>numThree</th><th>numFour</th></tr></thead><tbody><tr><td>1</td><td>200</td><td>1</td><td>1</td><td>60</td><td>230</td></tr><tr><td>1</td><td>200</td><td>2</td><td>2</td><td>70</td><td>460</td></tr><tr><td>2</td><td>300</td><td>1</td><td>4</td><td>80</td><td>880</td></tr><tr><td>2</td><td>300</td><td>2</td><td>5</td><td>90</td><td>990</td></tr></tbody></table>


<h1><b>8. FUNÇÕES AGREGADORAS EM JSON</b></h1>

<p>
	Funções de agregação <b>GROUP BY</b> assim como <b>SUM</b>, <b>MEAN</b>, <b>GROUP_CONCAT</b>, etc. Mas, que permite o retorno de estruturas JSON.
</p>

<h1><b>8.1. JSON_ARRAYAGG</b></h1>

<p>Cria uma coluna de arrays com elementos agrupados por categorias. Sintaxe:</p>

```sql
SELECT
  col_agrup_1
, col_agrup_2
, JSON_ARRAYAGG(col_para_array) as `arrays`
FROM TABLE
GROUP BY col_agrup_1, col_agrup_2
```

<p><b>Exemplo: </b>Supondo as tabelas abaixo, retornar os usuários e suas perguntas e respostas de formulário, <b>sem estourar a cardinalidade</b>:</p>

```sql
create table users (
    userId int primary key auto_increment,
    name varchar(191) not null,
    email varchar(50) not null
);

insert into users (userId, name, email) values
    (1, 'Ana', 'ana.ana@email.com'),
    (2, 'Beto', 'beto123@email.com'),
    (3, 'Carlos', 'car_lupi10@gmail.com');
```

<table align="center"><thead><tr><th>userId</th><th>name</th><th>email</th></tr></thead><tbody><tr><td>100</td><td>Ana</td><td>ana.ana@email.com</td></tr><tr><td>101</td><td>Beto</td><td>beto123@email.com</td></tr><tr><td>102</td><td>Carlos</td><td>car_vega@gmail.com</td></tr></tbody></table>

```sql
create table forms (
    formId int primary key auto_increment,
    userId int not null,
    question varchar(80),
    answer varchar(80),
    foreign key (userId) references users(userId)
);

insert into forms (userId, question, answer) values
    (1, 'Nascimento', '02/04/1987'),
    (1, 'Gênero', 'Feminino'),
    (1, 'Estado', 'RJ'),
    (1, 'Cidade', 'Rio de Janeiro'),
    (2, 'Nascimento', '10/09/1991'),
    (2, 'Gênero', 'Masculino'),
    (2, 'Estado', 'SP'),
    (2, 'Cidade', 'São Paulo'),
    (3, 'Nascimento', '31/12/1989'),
    (3, 'Gênero', 'Masculino'),
    (3, 'Estado', 'MG'),
    (3, 'Cidade', 'Belo Horizonte');
```

<table align="center"><thead><tr><th>formId</th><th>userId</th><th>question</th><th>answer</th></tr></thead><tbody><tr><td>1</td><td>100</td><td>Nascimento</td><td>02/04/1987</td></tr><tr><td>2</td><td>100</td><td>Gênero</td><td>Feminino</td></tr><tr><td>3</td><td>100</td><td>Estado</td><td>RJ</td></tr><tr><td>4</td><td>100</td><td>Cidade</td><td>Rio de Janeiro</td></tr><tr><td>5</td><td>101</td><td>Nascimento</td><td>10/09/1991</td></tr><tr><td>6</td><td>101</td><td>Gênero</td><td>Masculino</td></tr><tr><td>7</td><td>101</td><td>Estado</td><td>SP</td></tr><tr><td>8</td><td>101</td><td>Cidade</td><td>São Paulo</td></tr><tr><td>9</td><td>102</td><td>Nascimento</td><td>31/01/2000</td></tr><tr><td>10</td><td>102</td><td>Gênero</td><td>Masculino</td></tr><tr><td>11</td><td>102</td><td>Estado</td><td>MG</td></tr><tr><td>12</td><td>102</td><td>Cidade</td><td>Belo Horizonte</td></tr></tbody></table>

```sql
select 
  u.userId
, u.name
, json_arrayagg(question) as questions_array
, json_arrayagg(answer) as answers_array
from users u
    join forms f on f.userId = u.userId
group by u.userId, u.name;
```

<table align="center"><thead><tr><th>userId</th><th>name</th><th>questions_array</th><th>answers_array</th></tr></thead><tbody><tr><td>1</td><td>Ana</td><td>[ &quot;Nascimento&quot;, &quot;Gênero&quot;, &quot;Estado&quot;, &quot;Cidade&quot; ]</td><td>[ &quot;02/04/1987&quot;, &quot;Feminino&quot;, &quot;RJ&quot;, &quot;Rio de Janeiro&quot; ]</td></tr><tr><td>2</td><td>Beto</td><td>[ &quot;Nascimento&quot;, &quot;Gênero&quot;, &quot;Estado&quot;, &quot;Cidade&quot; ]</td><td>[ &quot;10/09/1991&quot;, &quot;Masculino&quot;, &quot;SP&quot;, &quot;São Paulo&quot; ]</td></tr><tr><td>3</td><td>Carlos</td><td>[ &quot;Nascimento&quot;, &quot;Gênero&quot;, &quot;Estado&quot;, &quot;Cidade&quot; ]</td><td>[ &quot;31/12/1989&quot;, &quot;Masculino&quot;, &quot;MG&quot;, &quot;Belo Horizonte&quot; ]</td></tr></tbody></table>

<p><b>Útil</b> quando não se quer estourar a cardinalidade do resultado, retornar toda a informação e permitir algum nível de manipulação posterior via consulta. Muito porque se mantém a ordenação dos elementos quando múltiplas colunas de arrays são chamadas (no mesmo registro, 1º elemento de uma col array corresponde ao 1º elemento de outra col array). Pode-se mesclar futuramente dentro de uma subconsulta para retornar uma ou outra pergunta posicionalmente:</p>

```sql
select 
  a.name
, a.questions_array ->> '$[0]' as `pergunta 1`
, a.answers_array ->> '$[0]' as `resposta 1`
from (
    select 
      u.userId
    , u.name
    , json_arrayagg(question) as questions_array
    , json_arrayagg(answer) as answers_array
    from users u
    join forms f on f.userId = u.userId
    group by u.userId, u.name
) as a
;
```

<table align="center"><thead><tr><th>name</th><th>pergunta 1</th><th>resposta 1</th></tr></thead><tbody><tr><td>Ana</td><td>Nascimento</td><td>02/04/1987</td></tr><tr><td>Beto</td><td>Nascimento</td><td>10/09/1991</td></tr><tr><td>Carlos</td><td>Nascimento</td><td>31/12/1989</td></tr></tbody></table>

<h1><b>8.2. JSON_OBJECTAGG</b></h1>

<p>Função irmã de JSON_ARRAYAGG, mas que retorna um objeto chaveado. Sintaxe:</p>

```sql
SELECT
  col_agrup
, JSON_ARRAYAGG(col_chave, col_valor) as `objs`
FROM TABLE
GROUP BY col_agrup
```

<p><b>Exemplo: </b>Supondo as tabelas abaixo, retornar os usuários e seus formulários preenchidos de modo semi-estruturado (objetos JSON):</p>

```sql
create table users (
    userId int primary key auto_increment,
    name varchar(191) not null,
    email varchar(50) not null
);

insert into users (userId, name, email) values
    (1, 'Ana', 'ana.ana@email.com'),
    (2, 'Beto', 'beto123@email.com'),
    (3, 'Carlos', 'car_lupi10@gmail.com');
```

<table align="center"><thead><tr><th>userId</th><th>name</th><th>email</th></tr></thead><tbody><tr><td>100</td><td>Ana</td><td>ana.ana@email.com</td></tr><tr><td>101</td><td>Beto</td><td>beto123@email.com</td></tr><tr><td>102</td><td>Carlos</td><td>car_vega@gmail.com</td></tr></tbody></table>

```sql
create table forms (
    formId int primary key auto_increment,
    userId int not null,
    question varchar(80),
    answer varchar(80),
    foreign key (userId) references users(userId)
);

insert into forms (userId, question, answer) values
    (1, 'Nascimento', '02/04/1987'),
    (1, 'Gênero', 'Feminino'),
    (1, 'Estado', 'RJ'),
    (1, 'Cidade', 'Rio de Janeiro'),
    (2, 'Nascimento', '10/09/1991'),
    (2, 'Gênero', 'Masculino'),
    (2, 'Estado', 'SP'),
    (2, 'Cidade', 'São Paulo'),
    (3, 'Nascimento', '31/12/1989'),
    (3, 'Gênero', 'Masculino'),
    (3, 'Estado', 'MG'),
    (3, 'Cidade', 'Belo Horizonte');
```

<table align="center"><thead><tr><th>formId</th><th>userId</th><th>question</th><th>answer</th></tr></thead><tbody><tr><td>1</td><td>100</td><td>Nascimento</td><td>02/04/1987</td></tr><tr><td>2</td><td>100</td><td>Gênero</td><td>Feminino</td></tr><tr><td>3</td><td>100</td><td>Estado</td><td>RJ</td></tr><tr><td>4</td><td>100</td><td>Cidade</td><td>Rio de Janeiro</td></tr><tr><td>5</td><td>101</td><td>Nascimento</td><td>10/09/1991</td></tr><tr><td>6</td><td>101</td><td>Gênero</td><td>Masculino</td></tr><tr><td>7</td><td>101</td><td>Estado</td><td>SP</td></tr><tr><td>8</td><td>101</td><td>Cidade</td><td>São Paulo</td></tr><tr><td>9</td><td>102</td><td>Nascimento</td><td>31/01/2000</td></tr><tr><td>10</td><td>102</td><td>Gênero</td><td>Masculino</td></tr><tr><td>11</td><td>102</td><td>Estado</td><td>MG</td></tr><tr><td>12</td><td>102</td><td>Cidade</td><td>Belo Horizonte</td></tr></tbody></table>

```sql
select 
  u.userId
, u.name
, json_objectagg(question, answer) as `forms_obj`
from users u 
    join forms f
group by u.userId
;
```

<table align="center"><thead><tr><th>userId</th><th>name</th><th>forms_obj</th></tr></thead><tbody><tr><td>1</td><td>Ana</td><td>{ &quot;Cidade&quot;: &quot;São Paulo&quot;, &quot;Estado&quot;: &quot;SP&quot;, &quot;Gênero&quot;: &quot;Masculino&quot;, &quot;Nascimento&quot;: &quot;10/09/1991&quot; }</td></tr><tr><td>2</td><td>Beto</td><td>{ &quot;Cidade&quot;: &quot;Rio de Janeiro&quot;, &quot;Estado&quot;: &quot;RJ&quot;, &quot;Gênero&quot;: &quot;Feminino&quot;, &quot;Nascimento&quot;: &quot;10/09/1991&quot; }</td></tr><tr><td>3</td><td>Carlos</td><td>{ &quot;Cidade&quot;: &quot;São Paulo&quot;, &quot;Estado&quot;: &quot;MG&quot;, &quot;Gênero&quot;: &quot;Masculino&quot;, &quot;Nascimento&quot;: &quot;31/12/1989&quot; }</td></tr></tbody></table>

<p><b>Útil</b> quando há necessidade de retornar registros únicos (users, produtos, etc) sem repetições, mas que outra informação necessária pode estourar a cardinalidade. Evita múltiplos JOINs o que pode tornar mais viável a consulta. Na situação de formulário de perguntas, por exemplo, para cada pergunta seria necessária um JOIN filtrando somente a pergunta referente a coluna respectiva, lenvando ao scans desnecessários dentro da mesma tabela. Bastaria agregar por um objeto e consultar dentro dos dados semi-estruturados pela chave (JSON_EXTRACT) para gerar as colunas de respostas:</p>

```sql
select 
  a.userId
, a.name
, a.forms_obj ->> '$."Estado"' as Estado
, a.forms_obj ->> '$."Cidade"' as Cidade
, a.forms_obj ->> '$."Gênero"' as Gênero
, a.forms_obj ->> '$."Nascimento"' as Nascimento
from (
    select 
      u.userId
    , u.name
    , json_objectagg(question, answer) as `forms_obj`
    from users u 
        join forms f
    group by u.userId
) as a
;
```

<table align="center"><thead><tr><th>userId</th><th>name</th><th>Estado</th><th>Cidade</th><th>Gênero</th><th>Nascimento</th></tr></thead><tbody><tr><td>1</td><td>Ana</td><td>SP</td><td>São Paulo</td><td>Masculino</td><td>10/09/1991</td></tr><tr><td>2</td><td>Beto</td><td>RJ</td><td>Rio de Janeiro</td><td>Feminino</td><td>10/09/1991</td></tr><tr><td>3</td><td>Carlos</td><td>MG</td><td>São Paulo</td><td>Masculino</td><td>31/12/1989</td></tr></tbody></table>
