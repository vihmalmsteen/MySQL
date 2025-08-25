<h2>1. FUNÇÕES</h2>

<h3>1.1 sem BEGIN END</h3>

<p align="justify">
  Existem funções pré definidas como SUM, AVG, REGEXP. Mas, também é possível criar funções personalizadas. Elas ficam armazenadas dentro do banco de dados e sua sintaxe é:
</p>

```sql
-- sem variável declarada pelo usuário
DELIMITER //                                      -- alterando o delimitador de execucao de ';' para '//'
CREATE FUNCTION nomeFuncao ()
RETURNS dadoTipo                                  -- Tipagem do dado que será retornado (INT, FLOAT, TEXT...)
-- comandos ...
RETURN retorno;                                   -- Dado retornado, resultado
//
DELIMITER ;                                       -- voltando para o delimitador original ';'

-- com variável declarada pelo usuário
DELIMITER //                                      -- alterando o delimitador de execucao de ';' para '//'
CREATE FUNCTION nomeFuncao (var1, var2, varN)
RETURNS dadoTipo                                  -- Tipagem do dado que será retornado (INT, FLOAT, TEXT...)
-- comandos ...
RETURN retorno;                                   -- Dado retornado, resultado
//
DELIMITER ;                                       -- voltando para o delimitador original ';'
```

<p align="justify> <b>NOTA: </b> Caso não consiga criar funções, testar a execução do comando abaixo:</p>

```sql
SET GLOBAL log_bin_trust_function_creators = 1;
```

<p align="justify">Exemplos de função:</p>

```sql
SET GLOBAL log_bin_trust_function_creators = 1;

-- sem variáveis declaradas pelo usuário
delimiter //
create function fn_teste1()
returns int
return 2*4;
//
delimiter ;

-- com variáveis declaradas pelo usuário
delimiter //
create function fn_teste2(a int, b int)
returns int
return a*b;
//
delimiter ;


select 
 'fn_teste1' as `funcao`
, fn_teste1() as `resultado`
union all
select 
 'fn_teste2' as `funcao`
, fn_teste2(2,4) as `resultado`;
```

<table align="center"><thead><tr><th>funcao</th><th>resultado</th></tr></thead><tbody><tr><td>fn_teste1</td><td>8</td></tr><tr><td>fn_teste2</td><td>8</td></tr></tbody></table>

<p align="justify">
  Estas funções podem ser executadas em consultas SELECT, assim como as pré definidas:
</p>

<p align="justify">
  <b>EXEMPLO 1: Função que retorna o preço do remédio corrigido pela cotação do dólar.</b>
</p>

```sql
-- criando função 'precoDolar'
delimiter //
create function precoDolar(colPreco float, dolar float)
returns float
return colPreco * dolar;
//
delimiter ;

-- aplicando funcao 'precoDolar' para converter 'preco' da tabela 'remedio'
select 
  r.`nome` as `remedio`
, r.`preco` as `preco R$`
, precoDolar(r.preco, 4.92) as `preco US$`
from remedio r;
```

<table align="center"><thead><tr><th>remedio</th><th>preco R$</th><th>preco US$</th></tr></thead><tbody><tr><td>Remedio 1</td><td>10,5</td><td>51,66</td></tr><tr><td>Remedio 2</td><td>20,75</td><td>102,09</td></tr><tr><td>Remedio 3</td><td>15</td><td>73,8</td></tr><tr><td>Remedio 4</td><td>30,25</td><td>148,83</td></tr><tr><td>Remedio 5</td><td>12</td><td>59,04</td></tr><tr><td>Remedio 6</td><td>18,5</td><td>91,02</td></tr><tr><td>Remedio 7</td><td>25</td><td>123</td></tr><tr><td>Remedio 8</td><td>8,75</td><td>43,05</td></tr><tr><td>Remedio 9</td><td>16,5</td><td>81,18</td></tr><tr><td>Remedio 10</td><td>22,5</td><td>110,7</td></tr><tr><td>Remedio 11</td><td>14,25</td><td>70,11</td></tr><tr><td>Remedio 12</td><td>17,75</td><td>87,33</td></tr><tr><td>Remedio 13</td><td>11,5</td><td>56,58</td></tr><tr><td>Remedio 14</td><td>19</td><td>93,48</td></tr><tr><td>Remedio 15</td><td>32</td><td>157,44</td></tr></tbody></table>

<p align="justify">
  <b>EXEMPLO 2: Função que retorna a quantidade de planos cobertos pelo remédio.</b>
</p>

```sql
delimiter //
create function arranjoTexto(coluna text)
returns text
return case when length(coluna) - length(replace(coluna, ',', '')) = 0
            then '1 plano'
            when length(coluna) - length(replace(coluna, ',', '')) = 1
            then '2 planos'
            when length(coluna) - length(replace(coluna, ',', '')) = 2
            then '3+ planos' 
            else null end;
//
delimiter ;

select 
  r.`nome`
, r.`planos_cobertos`
, arranjoTexto(r.`planos_cobertos`) as `qtdPlanos`
from remedio r;

/*
Sobre o CASE WHEN, a diferença entre o tamanho LENGTH de cada registro e o tamanho LENGTH do registro sem vírgula (pela substituição de ',' por '' em REPLACE).
A diferença é a quantidade de vírgulas.
No 1º when, se a diferença é 0 só tem 1 argumento (1 plano, sem vírgulas)
No 2º when, se a diferença é 1 tem 2 argumentos (2 planos, 1 vírgula)
No 3º when, se a diferença é 2 tem 3 argumentos (3 planos, 2 vírgulas)
*/
```

<table align="center"><thead><tr><th>nome</th><th>planos_cobertos</th><th>qtdPlanos</th></tr></thead><tbody><tr><td>Remedio 1</td><td>AMIL,SILVESTRE</td><td>2 planos</td></tr><tr><td>Remedio 2</td><td>AMIL</td><td>1 plano</td></tr><tr><td>Remedio 3</td><td>SILVESTRE</td><td>1 plano</td></tr><tr><td>Remedio 4</td><td>AMIL,SILVESTRE,SULAMERICA</td><td>3+ planos</td></tr><tr><td>Remedio 5</td><td>SULAMERICA</td><td>1 plano</td></tr><tr><td>Remedio 6</td><td></td><td></td></tr><tr><td>Remedio 7</td><td>AMIL,SULAMERICA</td><td>2 planos</td></tr><tr><td>Remedio 8</td><td>SILVESTRE</td><td>1 plano</td></tr><tr><td>Remedio 9</td><td>AMIL,SULAMERICA</td><td>2 planos</td></tr><tr><td>Remedio 10</td><td>AMIL,SILVESTRE</td><td>2 planos</td></tr><tr><td>Remedio 11</td><td>SILVESTRE,SULAMERICA</td><td>2 planos</td></tr><tr><td>Remedio 12</td><td>AMIL</td><td>1 plano</td></tr><tr><td>Remedio 13</td><td>SULAMERICA</td><td>1 plano</td></tr><tr><td>Remedio 14</td><td>AMIL,SILVESTRE</td><td>2 planos</td></tr><tr><td>Remedio 15</td><td>AMIL,SULAMERICA</td><td>2 planos</td></tr></tbody></table>

<b>EXEMPLO 3: Função que concatena o preço e o ID dos remédios.</b>

```sql
delimiter //
create function preco_id(col1 float, col2 text)
returns text
return concat(col1, '_', col2);;
//
delimiter ;

select 
  r.`id`
, r.`preco`
, preco_id(r.`preco`, r.`id`) as `preco_id`
from remedio r
limit 5;
```

<table align="center"><thead><tr><th>id</th><th>preco</th><th>preco_id</th></tr></thead><tbody><tr><td>1</td><td>10,5</td><td>10.5_1</td></tr><tr><td>2</td><td>20,75</td><td>20.75_2</td></tr><tr><td>3</td><td>15</td><td>15_3</td></tr><tr><td>4</td><td>30,25</td><td>30.25_4</td></tr><tr><td>5</td><td>12</td><td>12_5</td></tr></tbody></table>

<h3>1.2 com BEGIN END</h3>

<p align="justify">
  A cláusula `BEGIN…END` é usada em blocos de código dentro de funções, procedimentos armazenados ou triggers no MySQL. Essa cláusula marca o início e o fim de um bloco de código, permitindo que você agrupe várias instruções SQL em um único bloco lógico. Essencialmente, ela define um escopo para o código contido dentro do bloco. Dentro de um bloco `BEGIN…END`, você pode incluir declarativos de variáveis <b>SET ou DECLARE</b>, instruções <b>SQL </b>, instruções de controle de fluxo (como <b>IF, ELSE, WHILE, LOOP)</b> e instruções de <b>manipulação de exceções</b>. A cláusula `BEGIN` indica o início do bloco e a cláusula `END` indica o fim do bloco.
</p>

```sql
-- sintaxe
DELIMITER //
CREATE FUNCTION funcao(var1, var2, varN)
RETURNS tipo
BEGIN
-- comandos...
RETURNS retorno;
END //
DELIMITER ;
```

<p align="justify"> <b>EXEMPLO 1: Função que calcula o imposto do remédio (com IF-ELIF-ELSE-END IF).</b></p>

```sql
DELIMITER //
CREATE FUNCTION impostoRemedio(precoRemedio float) 
RETURNS float
BEGIN
    DECLARE imposto float;
    IF precoRemedio > 0 and precoRemedio < 12 THEN
        SET imposto = precoRemedio * 0.1;              -- Imposto de 10% para remédios até 12
    ELSEIF precoRemedio < 20 THEN
        SET imposto = precoRemedio * 0.15;             -- Imposto de 15% para remédios até 20
    ELSE
        SET imposto = precoRemedio * 0.2;              -- Imposto de 20% para remédios acima de 20
    END IF;    
    RETURN imposto;
END//
DELIMITER ;

select
  r.`nome` as `remedio`
, r.`preco`
, impostoRemedio(r.`preco`) as `imposto`
, round(impostoRemedio(r.`preco`) / r.`preco`, 2) as `alíquota'`
from remedio r
limit 5;
```

<table align="center"><thead><tr><th>nome</th><th>preco</th><th>imposto</th><th>alíquota&#39;</th></tr></thead><tbody><tr><td>Remedio 1</td><td>10,5</td><td>1,05</td><td>0,1</td></tr><tr><td>Remedio 2</td><td>20,75</td><td>4,15</td><td>0,2</td></tr><tr><td>Remedio 3</td><td>15</td><td>2,25</td><td>0,15</td></tr><tr><td>Remedio 4</td><td>30,25</td><td>6,05</td><td>0,2</td></tr><tr><td>Remedio 5</td><td>12</td><td>1,8</td><td>0,15</td></tr></tbody></table>

<p align="justify">
  <b>EXEMPLO 2: Função que calcula o preço líquido do remédio, sem imposto (com CASE WHEN-END).</b>
</p>

```sql
DELIMITER //
CREATE FUNCTION precoLiquido(preco float) 
RETURNS float
BEGIN
    DECLARE liquido float;
    SET liquido = CASE
        WHEN preco > 0 AND preco < 12 THEN preco * (1 - 0.1)    -- Imposto de 10% para remédios até 12
        WHEN preco < 20 THEN preco * (1 - 0.15)                 -- Imposto de 15% para remédios até 20
        ELSE preco * (1 - 0.2)                                  -- Imposto de 20% para remédios acima de 20
    END;
    RETURN liquido;
END //
DELIMITER ;


select
  r.`nome`
, r.`preco`
, precoLiquido(r.`preco`) as `precoSemImposto`
, round((r.`preco` - precoLiquido(r.`preco`)) / r.`preco`, 2) as `aliquota`
from remedio r
limit 5;
```

<table align="center"><thead><tr><th>nome</th><th>preco</th><th>precoSemImposto</th><th>aliquota</th></tr></thead><tbody><tr><td>Remedio 1</td><td>10,5</td><td>9,45</td><td>0,1</td></tr><tr><td>Remedio 2</td><td>20,75</td><td>16,6</td><td>0,2</td></tr><tr><td>Remedio 3</td><td>15</td><td>12,75</td><td>0,15</td></tr><tr><td>Remedio 4</td><td>30,25</td><td>24,2</td><td>0,2</td></tr><tr><td>Remedio 5</td><td>12</td><td>10,2</td><td>0,15</td></tr></tbody></table>

<p align="justify">
  No MySQL, as <b>funções</b> têm <b>algumas limitações</b> quando se trata de <b>instruções RETURN</b>:
</p>

<ol>
  <li><p align="justify">Uma função só pode ter uma instrução RETURN. Portanto, não é possível ter múltiplas instruções RETURN em uma função. A execução da função será interrompida assim que a primeira instrução RETURN for encontrada.</p></li>
  <li><p align="justify">O tipo de dados do valor retornado pela função deve corresponder ao tipo de dados declarado na declaração da função. Por exemplo, se a função é declarada como retornando um inteiro (INT), então a instrução RETURN deve retornar um valor do tipo inteiro.</p></li>
  <li><p align="justify">A instrução RETURN deve ser a última instrução na função. Ou seja, não é possível ter código ou instruções executadas após uma instrução RETURN na função.</p></li>
  <li><p align="justify">Se a função é definida com DETERMINISTIC ou READS SQL DATA, as instruções RETURN só podem ser usadas se estiverem em blocos BEGIN...END. Se a função é definida com NO SQL, não é permitido usar a instrução RETURN dentro de blocos BEGIN...END.</p></li>
  <li><p align="justify">A instrução RETURN não pode ser usada diretamente em um trigger ou procedimento armazenado. Para retornar um valor em um trigger ou procedimento armazenado, você precisará usar uma variável OUT ou uma variável local para armazenar o valor que deseja retornar.</p></li>
</ol>

<h3>1.3 Múltiplos RETURNS em condicionais</h3>

<p align="justify">
  Há a possibilidade de haver múltiplos retornos (RETURN) em uma função, desde que cada RETURN seja oriundo de um condicional como IF ou CASE WHEN.
</p>

<p align="justify">
  <b>EXEMPLO: Criando função para strings que funcione como JSON_EXTRACT, retornando o elemento de um texto separado por vírgulas e caso o índice fornecido seja superior à quantidade de elementos no texto, retornar nulo.</b>
</p>

```sql
-- criando função com múltiplos RETURN
DELIMITER //
CREATE FUNCTION get_array_element(arr TEXT, indice INT)
RETURNS TEXT
BEGIN
    DECLARE num_elements INT;
    DECLARE elemento TEXT;
    SET num_elements = (SELECT LENGTH(arr) - LENGTH(REPLACE(arr, ',', '')) + 1);
    IF indice > num_elements OR indice <= 0 THEN
        RETURN NULL;
    ELSE
        SET elemento = SUBSTRING_INDEX(SUBSTRING_INDEX(arr, ',', indice), ',', -1);
        RETURN elemento;
    END IF;
END //
DELIMITER ;

-- executando
select 
  r.planos_cobertos
, get_array_element(r.planos_cobertos, 1) as `1`
, get_array_element(r.planos_cobertos, 2) as `2`
, get_array_element(r.planos_cobertos, 3) as `3`
, get_array_element(r.planos_cobertos, 4) as `4`
from remedio r 
;
```

<table align="center"><thead><tr><th>planos_cobertos</th><th>1</th><th>2</th><th>3</th><th>4</th></tr></thead><tbody><tr><td>AMIL,SILVESTRE</td><td>AMIL</td><td>SILVESTRE</td><td>NULL</td><td>NULL</td></tr><tr><td>AMIL</td><td>AMIL</td><td>NULL</td><td>NULL</td><td>NULL</td></tr><tr><td>SILVESTRE</td><td>SILVESTRE</td><td>NULL</td><td>NULL</td><td>NULL</td></tr><tr><td>AMIL,SILVESTRE,SULAMERICA</td><td>AMIL</td><td>SILVESTRE</td><td>SULAMERICA</td><td>NULL</td></tr><tr><td>SULAMERICA</td><td>SULAMERICA</td><td>NULL</td><td>NULL</td><td>NULL</td></tr><tr><td>NULL</td><td>NULL</td><td>NULL</td><td>NULL</td><td>NULL</td></tr><tr><td>AMIL,SULAMERICA</td><td>AMIL</td><td>SULAMERICA</td><td>NULL</td><td>NULL</td></tr><tr><td>SILVESTRE</td><td>SILVESTRE</td><td>NULL</td><td>NULL</td><td>NULL</td></tr><tr><td>AMIL,SULAMERICA</td><td>AMIL</td><td>SULAMERICA</td><td>NULL</td><td>NULL</td></tr><tr><td>AMIL,SILVESTRE</td><td>AMIL</td><td>SILVESTRE</td><td>NULL</td><td>NULL</td></tr><tr><td>SILVESTRE,SULAMERICA</td><td>SILVESTRE</td><td>SULAMERICA</td><td>NULL</td><td>NULL</td></tr><tr><td>AMIL</td><td>AMIL</td><td>NULL</td><td>NULL</td><td>NULL</td></tr><tr><td>SULAMERICA</td><td>SULAMERICA</td><td>NULL</td><td>NULL</td><td>NULL</td></tr><tr><td>AMIL,SILVESTRE</td><td>AMIL</td><td>SILVESTRE</td><td>NULL</td><td>NULL</td></tr><tr><td>AMIL,SULAMERICA</td><td>AMIL</td><td>SULAMERICA</td><td>NULL</td><td>NULL</td></tr></tbody></table>

<h3>1.4 FUNCTION com variável SELECT</h3>

<p align="justify">
  É possivel realizar operações em tabelas e armazenar o valor dentro de uma variável DECLARE para serem usadas no escopo da FUNCTION ou como resultado da função. No entanto, como variáveis são valores pontuais, recebem exatamente um único valor, não sendo possível inserir um conjunto de dados (tabelas inteiras de um SELECT). A sintaxe da variável DECLARE:
</p>

```sql
DECLARE var tipo;
select funcao(col) INTO var FROM tabela;
```

<p align="justify">Geralmente, uma função é aplicada em uma coluna (col) de uma tabela e o resultado é armazenado (INTO) variável declarada (var).</p>

<p align="justify">
  <b>EXEMLPO 1: Criar função que retorna a média de preços da tabela de remédios.</b>
</p>

```sql
delimiter //
create function medioPreco()
returns float
begin
declare media float;
select avg(preco) into media from remedio;
return media;
end //
delimiter ;

select medioPreco();
```

<table align="center"><thead><tr><th>medioPreco()</th></tr></thead><tbody><tr><td>18,2833</td></tr></tbody></table>

<p align="justify">
  <b>EXEMLPO 2: Criar função que retorna a média de preço de remédios prescritos por médicos de uma determinada especialidade.</b>
</p>

```sql
-- criando frunção
delimiter //
create function precoMedio (plano text, espec text)
returns float
begin
	declare valorMedio float;
    select avg(a.preco) into valorMedio from 
    (
    select r.preco
    from remedio r
    	inner join receita rc on r.`ID` = rc.`remedio_id`
    	inner join consulta c on c.`id` = rc.`consulta_id`
    	inner join medico m on m.`id` = c.`medico_id`
    	where 1=1
    	  and r.`planos_cobertos` regexp(plano)
          and m.`especialidade` regexp(espec)
    ) as a;
   return valorMedio;
end //
delimiter ;

-- check para plano 'AMIL' e especialidade 'otorrino'
select precoMedio('AMIL', 'otorrino');
```

<table align="center"><thead><tr><th>precoMedio(&#39;AMIL&#39;, &#39;otorrino&#39;)</th></tr></thead><tbody><tr><td>23,375</td></tr></tbody></table>
