<h2>1. Variáveis</h2>

<p align="justify">No MySQL, existem 2 tipo de variáveis:</p>

<ol>
  <li><p align="justify"><b>De usuário:</b> São variáveis criadas para a sessão e que serão excluídas ao final dela. Portanto, ficam armazenadas em memória local (RAM). São declaradas com <b>@</b> (arroba). Podem ser declaradas a qualquer momento, (SELECT, PROCEDURE, FUNCTION...). Não é necessário tipá-la.</p></li>
  <li><p align="justify"><b>De sistema:</b> São variáveis que ficam armazenadas fisicamente, não se perdendo ao final da sessão. São declaradas em FUNCTIONS e PROCEDURES com o termo <b>DECLARE</b>. Devem ser tipadas ao final de sua criação com DECLARE.</p></li>
</ol>

<p align="justify">Um breve resumo:</p>

<table align="center"><thead><tr><th>VARIÁVEL</th><th>DECLARAÇÃO</th><th>INPUT DE VALOR</th><th>TIPAGEM</th><th>VALORES</th><th>USO</th></tr></thead><tbody><tr><td>DE USUÁRIO</td><td>@var</td><td>SET @var = valor;</td><td>não</td><td>numéricos e texto</td><td>dentro e fora de FUNCTION, PROCEDURE, TRIGGER</td></tr><tr><td>GLOBAL</td><td>DECLARE var tipo;</td><td>SET var = valor;</td><td>sim</td><td>numéricos, texto, condicionais (IF, CASE)</td><td>somente dentro de FUNCTION, PROCEDURE, TRIGGER</td></tr></tbody></table>

<p align="justify"><b>Atribuir um valor a uma variável</b>, seja do usuário (@) ou do sistema (DECLARE) é feito pelo comando <b>SET</b>.</p>

```sql
-- variável de usuário (@) com valor 10 (SET)
SET @varUser = 10;

-- variável de sistema (DECLARE) com valor 10 (SET)
DECLARE varUser INT;
SET varUser = 10;
```

<p align="justify">Atribuir para múltiplas variáveis um valor para cada uma, pode-se usar os comandos ":=" ou "INTO". Basicamente, o comando ":=" é para ser usado dentro do próprio SELECT (só serve para vars de usuário, @var) ou atribuindo à variável uma query que retorna um único registro.</p>

<ul>
	<li><p align="justify"><b>var := reg: </b>Usado dentro do próprio SELECT (só serve para vars de usuário, @var);</p></li>
	<li><p align="justify"><b>reg INTO var: </b>Atribuindo à uma variável que retorna um único registro.</p></li>
</ul>

<p align="justify">
	<b>Exemplo com vars de usuário, @var:</b>
</p>

```sql
delimiter //
drop procedure if exists medicoRegistro //
create procedure medicoRegistro(medicoId int)
begin
	-- ex 1: SELECT @var := col WHERE      SÓ SERVE PARA VARS DE USUÁRIO (retorna as variáveis em SELECT)
	select 
	  @medicoNome := nome
    , @medicoEspecialidade := especialidade
    from medico
    where id = MedicoId;
   
   -- ex 2: SELECT @var := agregacao       SÓ SERVE PARA VARS DE USUÁRIO (retorna as variáveis em SELECT)
   select 
     @crmMedio := avg(crm)
   , @crmMaximo := max(crm)
   from medico;
  
   -- ex 3: SET @var := (SELECT)
   set @countMedicos1 := (select count(*) from medico);
  
   -- ex 4: SELECT agregacao INTO @var
   select count(*) into @countMedicos2 from medico;
  
   -- retornos
   select @medicoNome,          'ex 1: SELECT @var := col FROM tabela WHERE' as `exemplo` union all
   select @medicoEspecialidade, 'ex 1: SELECT @var := col FROM tabela WHERE' as `exemplo` union all
   select @crmMedio,            'ex 2: SELECT @var := agregacao' as `exemplo` union all
   select @crmMaximo,           'ex 2: SELECT @var := agregacao' as `exemplo` union all
   select @countMedicos1,       'ex 3: SET @var := (SELECT)' as `exemplo` union all
   select @countMedicos2,       'ex 4: SELECT agregacao INTO @var' as `exemplo`;
end //
delimiter ;

call medicoRegistro(1);
```

<table align="center"><thead><tr><th>@medicoNome</th><th>exemplo</th></tr></thead><tbody><tr><td>Dr. João Santos</td><td>ex 1: SELECT @var := col FROM tabela WHERE</td></tr><tr><td>cardio</td><td>ex 1: SELECT @var := col FROM tabela WHERE</td></tr><tr><td>33333</td><td>ex 2: SELECT @var := agregacao</td></tr><tr><td>55555</td><td>ex 2: SELECT @var := agregacao</td></tr><tr><td>5</td><td>ex 3: SET @var := (SELECT)</td></tr><tr><td>5</td><td>ex 4: SELECT agregacao INTO @var</td></tr></tbody></table>

<p align="justify">
	<b>Exemplo com vars de sistema, DECLARE var:</b>
</p>

```sql
delimiter //
drop procedure if exists medicoRegistro //
create procedure medicoRegistro(medicoId int)
begin
	declare medicoNome text;
	declare medicoEspecialidade text;
	declare crmMedio int;
	declare crmMaximo int;
	declare countMedicos1 int;

    -- ex 1: SELECT col1, col2 INTO var1, var2 FROM tabela WHERE
    select 
      nome, especialidade
    into 
      medicoNome, medicoEspecialidade
    from medico
    where id = MedicoId;
   
   -- ex 2: SELECT agg1, agg2 INTO var1, var2
   select 
     avg(crm), max(crm)
   into 
     crmMedio, crmMaximo
   from medico;
  
   -- ex 3: SET var := (SELECT)
   set countMedicos1 := (select count(*) from medico);
  
   -- retornos
   select medicoNome,          'ex 1: SELECT col1, col2 INTO var1, var2 FROM tabela WHERE' as `exemplo` union all
   select medicoEspecialidade, 'ex 1: SELECT col1, col2 INTO var1, var2 FROM tabela WHERE' as `exemplo` union all
   select crmMedio,            'ex 2: SELECT agg1, agg2 INTO var1, var2' as `exemplo` union all
   select crmMaximo,           'ex 2: SELECT agg1, agg2 INTO var1, var2' as `exemplo` union all
   select countMedicos1,       'ex 3: SET var := (SELECT)' as `exemplo`;
end //
delimiter ;

call medicoRegistro(1);
```

<table align="center"><thead><tr><th>medicoNome</th><th>exemplo</th></tr></thead><tbody><tr><td>Dr. João Santos</td><td>ex 1: SELECT col1, col2 INTO var1, var2 FROM tabela WHERE</td></tr><tr><td>cardio</td><td>ex 1: SELECT col1, col2 INTO var1, var2 FROM tabela WHERE</td></tr><tr><td>33333</td><td>ex 2: SELECT agg1, agg2 INTO var1, var2</td></tr><tr><td>55555</td><td>ex 2: SELECT agg1, agg2 INTO var1, var2</td></tr><tr><td>5</td><td>ex 3: SET var := (SELECT)</td></tr></tbody></table>

<p align="justify"><b>A diferença entre os comandos := e INTO dentro de SELECT em variáveis de usuário @var é que:</b></p>

<ul>
	<li><p align="justify"><b>:= no SELECT: </b>Retorna as variáveis dentro de um SELECT;</p></li>
	<li><p align="justify"><b>INTO no SELECT: </b>Somente armazena registro na variável, não tendo o SELECT retornado.</p></li>
</ul>

<p align="justify"><b>NOTA: </b> Em alguns casos de declarações de funções ou procedimentos, caso haja erro de execução, uma das possibilidades é a permissão de criação de funções sem mencionar a declaração de segurança quando a gravação binária está ativada. Em termos curtos, basta executar este comando uma vez: <b>SET GLOBAL log_bin_trust_function_creators = 1;</b>. A execução dessa instrução permite que funções/procedimentos sejam criadas sem a necessidade de especificar a declaração de segurança DETERMINISTIC, NO SQL ou READS SQL DATA.</p>

```sql
/* variável de usuário */
SET @nome_variavel = 'valor';

/* variável de sistema para FUNCTION */
-- permitindo criação de funções sem declaração de segurança
SET GLOBAL log_bin_trust_function_creators = 1;

-- criando função
DELIMITER //
CREATE FUNCTION exemplo()
RETURNS INT
BEGIN
  DECLARE id INT DEFAULT 1;
  DECLARE nome VARCHAR(100);
  DECLARE salarioMedio DECIMAL(10, 2);
  DECLARE salarioMaximo DECIMAL(10, 2);

  SET id = 31245;
  SET nome = 'ALFREDO';
  SELECT
    AVG(salario)
  , MAX(salario)
  INTO
    salarioMedio
  , salarioMaximo
  FROM tabela;
  
  RETURN id;
END //
DELIMITER ;
```

<table align="center"><thead><tr><th>medicoNome</th><th>exemplo</th></tr></thead><tbody><tr><td>Dr. João Santos</td><td>ex 1: SELECT col1, col2 INTO var1, var2 FROM tabela WHERE</td></tr><tr><td>cardio</td><td>ex 1: SELECT col1, col2 INTO var1, var2 FROM tabela WHERE</td></tr><tr><td>33333</td><td>ex 2: SELECT agg1, agg2 INTO var1, var2</td></tr><tr><td>55555</td><td>ex 2: SELECT agg1, agg2 INTO var1, var2</td></tr><tr><td>5</td><td>ex 3: SET var := (SELECT)</td></tr><tr><td>0</td><td>call medicoRegistro(1)</td></tr></tbody></table>

<h3>1.1 Variáveis de usuário</h3>

<p align="justify">
  Para a variável de usuário, você pode usar seu valor em diferentes partes do seu código. Como em cláusulas SELECT, WHERE, etc.:
</p>

```sql
SELECT coluna
FROM tabela
WHERE coluna = @nome_variavel;
```

```sql
set @variavelPreco = 10;
set @variavelTexto = 'SILVESTRE';

select
r.`preco`
, @variavelPreco as `variavelPreco`
, case when r.`preco` > @variavelPreco then 'maior'
       else 'menor' end as 'testeNum'
, r.`planos_cobertos`
, @variavelTexto as `variavelTexto`
, r.`planos_cobertos` regexp (@variavelTexto) as `testeText`
from remedio r
where r.`planos_cobertos` regexp (@variavelTexto)
;
```

<table align="center"><thead><tr><th>preco</th><th>variavelPreco</th><th>testeNum</th><th>planos_cobertos</th><th>variavelTexto</th><th>testeText</th></tr></thead><tbody><tr><td>10,5</td><td>10</td><td>maior</td><td>AMIL,SILVESTRE</td><td>SILVESTRE</td><td>1</td></tr><tr><td>15</td><td>10</td><td>maior</td><td>SILVESTRE</td><td>SILVESTRE</td><td>1</td></tr><tr><td>30,25</td><td>10</td><td>maior</td><td>AMIL,SILVESTRE,SULAMERICA</td><td>SILVESTRE</td><td>1</td></tr><tr><td>8,75</td><td>10</td><td>menor</td><td>SILVESTRE</td><td>SILVESTRE</td><td>1</td></tr><tr><td>22,5</td><td>10</td><td>maior</td><td>AMIL,SILVESTRE</td><td>SILVESTRE</td><td>1</td></tr><tr><td>14,25</td><td>10</td><td>maior</td><td>SILVESTRE,SULAMERICA</td><td>SILVESTRE</td><td>1</td></tr><tr><td>19</td><td>10</td><td>maior</td><td>AMIL,SILVESTRE</td><td>SILVESTRE</td><td>1</td></tr></tbody></table>

<p align="justify">Variáveis de usuário não podem receber condicionais como <b>IF-ELIF-ELSE-END IF</b> ou <b>CASE WHEN END</b>. O único meio é através de FUNCTIONS ou PROCEDURES, criando dentro destes uma variável de usuário que receberá a variável DECLARE de dentro da FUNCTION ou PROCEDURE.</p>

<h3>1.2 Variáveis globais</h3>

<p align="justify">
  <b>Variáveis globais</b> podem ser usadas somente em estruturas como FUNCTION, PROCEDURE, TRIGGER. Devem ser tipadas e podem receber condicionais como IF e CASE WHEN.
</p>

<p align="justify">
  <b>EXEMPLO 1: Variável global em FUNCTION que retorna a faixa etária com base na idade fornecida.</b>
</p>

```sql
delimiter //
create function varGlobal(sua_idade int)
returns text
begin
declare uma_variavel_global text;
set uma_variavel_global = case 
  when sua_idade >  0 and sua_idade <= 10 then 'faixa de 0~10'
  when sua_idade > 11 and sua_idade <= 20 then 'faixa de 11~20'
  when sua_idade > 21 and sua_idade <= 30 then 'faixa de 21~30'
  when sua_idade > 31 and sua_idade <= 40 then 'faixa de 31~40'
  when sua_idade > 41 and sua_idade <= 50 then 'faixa de 41~50'
  when sua_idade > 51 and sua_idade <= 60 then 'faixa de 51~60'
  when sua_idade > 61 and sua_idade <= 70 then 'faixa de 61~70'
  else '71+' end;
return uma_variavel_global;
end //
delimiter ;

select varGlobal(32);
```

<table align="center"><thead><tr><th>varGlobal(32)</th></tr></thead><tbody><tr><td>faixa de 31~40</td></tr></tbody></table>

<p align="justify">A ordem dos comandos é bastante importante. Em sequência:</p>

<ol>
	<li><p align="justify">
		<b>DELIMITER: </b> Boa prática sempre usá-la. Altera o finalizador de comando de ponto e vírgula para um outro. Ao final, após o último END, retorna-se ao ponto e vírgula.
	</p></li>
	<li><p align="justify">
		<b>CREATE FUNCTION: </b>Dá-se o nome e se seta as variáveis que o usuário irá informar à função.
	</p></li>
	<li><p align="justify">
		<b>RETURNS: </b>Define o tipo do retorno ao final da função, em RETURN.
	</p></li>
	<li><p align="justify">
		<b>BEGIN: </b>Inicia as linhas de comandos adicionais da função.
	</p></li>
	<li><p align="justify">
		<b>DECLARE: </b>Quando for necessário declarar uma variável global, haverá o DECLARE logo após BEGIN. Note que cada DECLARE deve conter ponto e vírgula ao final, mesmo com outro delimitador setado.
	</p></li>
	<li><p align="justify">
		<b>SET: </b>Se houve DECLARE, haverá SET para cada variável. Pois, através de SET se designa um valor (SET var = valor ou função). Também deve ser finalizado com ponto e vírgula.
	</p></li>
	<li><p align="justify">
		<b>RETURN: </b>O retorno da FUNCTION em si, que acima será o valor da variável global 'uma_variavel_global'. Note o ponto e vírgula ao final que sempre deve existir.
	</p></li>
	<li><p align="justify">
		<b>END: </b> Este END finaliza o BEGIN, sempre após o RETURN e deve finalizar com o DELIMITER setado ('//' por convenção).
	</p></li>
	<li><p align="justify">
		<b>DELIMITER: </b>Último DELIMITER para alterar para ponto e vírgula novamente.
	</p></li>
	<li><p>
		<b>NOTA: Todos os comandos dentro de BEGIN END devem conter ponto e vírgula ao final.</b>
	</p></li>
</ol>

<p align="justify">
	<b>EXEMPLO 2: Criar uma função que separe o nome e sobrenome do paciente pelo espaço entre eles.</b>
</p>

```sql
delimiter //
create function separar(nome text)
returns text
begin
declare sep text;
set sep = concat('NOME: ', 
                 substring_index(nome, ' ', 1) , 
                 ' | SOBRENOME: ', 
                 substring_index(nome, ' ', -1)
                 );
return sep;
end //
delimiter ;

select separar(nome) from paciente limit 5;
```

<table align="center"><thead><tr><th>separar(nome)</th></tr></thead><tbody><tr><td>NOME: Fulano | SOBRENOME: Silva</td></tr><tr><td>NOME: Cicrano | SOBRENOME: Souza</td></tr><tr><td>NOME: Beltrano | SOBRENOME: Oliveira</td></tr><tr><td>NOME: Maria | SOBRENOME: Rodrigues</td></tr><tr><td>NOME: José | SOBRENOME: Pereira</td></tr></tbody></table>

<h3>1.3 Atribuindo valor de variável via SELECT: INTO</h3>

<p align="justify">Meio de estabelecer o valor de uma variável através do resultado de umma consulta SELECT. Pode ser usado dentro de FUNCION ou PROCEDURE. Seja dentro de FUNCTION ou PROCEDURE, a sintaxe é a mesma:</p>

```sql
BEGIN
  -- os valores das colunas 1 e 2 ...
  SELECT
    funcaoAgregacao(col1) as `valor1`
  , funcaoAgregacao(col2) as `valor2`
  -- ... entrarão nas variáveis var1 e var2
  INTO
    var1
  , var2
  FROM tabela
END
```

<p align="justify"><b>EXEMPLO 1: Em FUNCTION.</b></p>

```sql
delimiter //
create function exemplo_1 (remedioId int)
returns float
begin
	declare valor int;
	select preco into valor
	from remedio where id = remedioId;
return valor;
end //
delimiter ;

select exemplo_1(1);
```

<table align="center"><thead><tr><th>exemplo_1(1)</th></tr></thead><tbody><tr><td>10</td></tr></tbody></table>

<p align="justify"><b>EXEMPLO 2: Em PROCEDURE.</b></p>

```sql
delimiter //
create procedure exemplo_2(in remedioId int, 
                           taxa float, 
                           out precoAntigo float, 
                           out precoNovo float)
begin 
	select
	  preco as `precoAntigo`
	, preco * (1 + taxa) as `precoNovo`
	into
	  precoAntigo                       -- var precoAntigo recebe valor de col `precoAntigo`
	, precoNovo                         -- var precoNovo recebe valor de col `precoNovo`
	from remedio
	where id = remedioId;
end //
delimiter ;

call exemplo_2(1, 0.1, @precoAntigo, @precoNovo);
select @precoAntigo, @precoNovo;
```

<table align="center"><thead><tr><th>@precoAntigo</th><th>@precoNovo</th></tr></thead><tbody><tr><td>10,5</td><td>11,55000019</td></tr></tbody></table>

<h3>1.4 Variáveis de parâmetros de PROCEDURES: IN, OUT, INOUT</h3>

<p align="justify">
	São tipagens de variáveis declaradas em STORED PROCEDURES durante a criação dos procedimentos.
</p>

<ul>
	<li><p align="justify"><b>IN: </b>Informa que a variável é apenas de entrada. Deve apenas ser informado um valor no parâmetro da PROCEDURE. É default caso não declarado em PROCEDURES.</p></li>

```sql
DELIMITER //
CREATE PROCEDURE exemplo_in(var INT)                -- (var INT) = (IN var INT)
MAIN: BEGIN
	select var;
END //
DELIMITER ;

CALL exemplo_in(10);                                -- retorna 10
```

<li><p align="justify"><b>OUT: </b>Indica que a variável será criada pela PROCEDURE. Ao chamar o procedimento, <b>deve ser informado apenas @var nos parâmetros</b>.</p></li>

```sql
DELIMITER //
CREATE PROCEDURE exemplo_out(OUT var INT)
MAIN: BEGIN
	SELECT AVG(col) INTO var FROM tabela;
END //
DELIMITER ;

CALL exemplo_out(@var);                            -- param é o nome da variável
SELECT @var;                                       -- @var = média de col
```

<li><p align="justify"><b>INOUT: </b>Indica que uma variável entrará na PROCEDURE e terá seu valor alterado alterado por ela. Portanto, a variável <b>INOUT de um procedimento deve ser criado antes de ser chamado e informado na CALL como @var</b>.</p></li>
</ul>

```sql
DELIMITER //
CREATE PROCEDURE exemplo_inout(INOUT var INT)
MAIN: BEGIN
	SELECT AVG(col)*1.1 INTO @var FROM tabela;
END //
DELIMITER ;

SELECT avg(col) INTO var FROM tabela;              -- criando @var
SELECT @var;                                       -- @var = x
CALL exemplo_inout(@var);                          -- param é o nome da variável (já criada) 
SELECT @var;                                       -- @var = x 10% maior
```

<p><b>Exemplo IN: Puxando preço de um remédioID.</b></p>

```sql
delimiter //
drop procedure if exists teste //
create procedure teste(variavel int)
main:
begin
	select preco from remedio where id = variavel;
end //
delimiter ;

call teste(3);     -- retorna 15
```

<p><b>Exemplo OUT: Retornando a média de preços dos remédios.</b></p>

```sql
delimiter //
drop procedure if exists teste //
create procedure teste(out variavel int)
main:
begin
	select avg(preco) into variavel from remedio;
end //
delimiter ;

call teste(@variavel);
select @variavel;      -- retorna 15
```

<p><b>Exemplo INOUT: Subindo a média dos preços em 10%.</b></p>

```sql
select round(avg(preco),2) into @variavel from remedio;

delimiter //
drop procedure if exists teste //
create procedure teste(inout variavel int)
main:
begin
	select round(avg(preco)*1.1,2) into variavel from remedio;
end //
delimiter ;

select @variavel;         -- 19.39
call teste(@variavel);
select @variavel;         -- 21
```
