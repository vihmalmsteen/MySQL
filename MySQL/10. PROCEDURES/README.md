<h2>1. PROCEDURES</h2>

<p align="justify">
  São procedimentos armazenados salvos em um servidor de banco de dados para aperfeiçoar o desempenho e a consistência das tarefas repetitivas, podendo ser escritos em linguagem SQL e extensões SQL, e condicionais <b>IF-ELSEIF-ELSE-END-IF</b> ou <b>CASE WHEN</b>. Podem ser usados para as seguintes tarefas:
</p>

<ol>
  <li><p align="justify">Controlar autorização de acesso;</p></li>
  <li><p align="justify">Criar um caminho de auditoria de atividades em tabelas de banco de dados;</p></li>
  <li><p align="justify">Separar instruções de definição e de manipulação de dados relativas a um banco de dados e aplicações que acessam (PROCEDURE que executa SELECTs).</p></li>
</ol>

<p align="justify">
	<b>Procedures</b> podem retornar <b>variáveis</b> ou mesmo consultas <b>SELECT</b>. Neste último caso, é mais performático que consultar via SELECT. Pois, procedures são compiladas enquanto queries SELECT são processadas durante a execução.
</p>

<p align="justify">
  Podemos receber parâmetros e usá-los em instruções SQL que serão executadas dentro da Stored Procedure (SP). Sua sintaxe:
</p>

```sql
-- CRIAR
DELIMITER //
DROP PROCEDURE IF EXISTS procedimento //
CREATE PROCEDURE procedimento (params)
BEGIN
-- comandos;
END //
DELIMITER ;

-- CHAMAR
CALL procedimento(params);
```

<p align="justify">
  <b>NOTA: </b> O comando <b>BEGIN END</b> é <b>obrigatório</b> em <b>PROCEDURE</b>. Além disso, <b>chamar uma PROCEDURE</b> é feito com o comando <b>CALL</b> .
</p>

<p align="justify">Exemplo simples de PROCEDURE que retorna múltiplas consultas SELECT:</p>

```sql
delimiter //
create procedure chamadas ()
begin
	select * from medico;                           -- consulta 1
	select * from paciente;                         -- consulta 2
	select 'Consultas realizadas.' as `msg`;        -- consulta 3
end //
delimiter ;

call chamadas();         -- retorna consultas 1, 2, 3
```

<h3>1.1 PARÂMETROS DAS VARIÁVEIS - IN, OUT, INOUT</h3>

<p align="justify">
  Parâmetros IN, OUT e INOUT são usados em stored procedures e funções para passar valores entre a chamada do programa e o procedimento. Aqui estão alguns exemplos de cada tipo de parâmetro:
</p>

<ol>
  <li><p align="justify">
    <b>Parâmetro IN: </b>Este tipo de parâmetro é usado para passar valores de entrada para o procedimento ou função. O valor é fornecido pelo programa chamador e é somente leitura dentro do procedimento. Exemplo:

```sql
CREATE PROCEDURE GetEmployee(IN employee_id INT, OUT employee_name VARCHAR(100))
BEGIN
   SELECT name INTO employee_name FROM employees WHERE id = employee_id;
END;

CALL GetEmployee(12, @employee_name);
```
  </p></li>
  <li><p align="justify">
    <b>Parâmetro OUT: </b>Esse tipo de parâmetro é usado para retornar valores do procedimento ou função de volta para o programa chamador. O valor é definido dentro do procedimento e é lido pelo programa chamador após a execução do procedimento. Exemplo:
  </p></li>

```sql
CREATE PROCEDURE GetTotalEmployees(OUT total_employees INT)
BEGIN
    SELECT COUNT(*) INTO total_employees FROM employees;
END;

CALL (@total_employees);
```

  <li><p align="justify">
    <b>Parâmetro INOUT: </b>Este tipo de parâmetro permite a passagem bidirecional de valores entre o programa chamador e o procedimento ou função. O valor inicial é fornecido pelo programa chamador e pode ser modificado dentro do procedimento. Exemplo:
  </p></li>

```sql
CREATE PROCEDURE UpdateSalary(INOUT employee_salary DECIMAL(10,2))
BEGIN
   SET employee_salary = employee_salary * 1.1; -- Aumenta em 10%
END;

@employee_salary = 1000;
CALL UpdateSalary(@employee_salary);
```
</ol>

<ol>
  <li><p align="justify"><b>Variáveis IN: </b>São introduzidas em PROCEDURES pelo servidor, não podendo ser declaradas de forma literal. Ou seja, devem estar armazenadas no servidor (com @var, por exemplo). Mas, não tem seu valor alterado pela PROCEDURE.</p></li>
  <li><p align="justify"><b>Variáveis OUT: </b>Variáveis OUT são produzidas pela PROCEDURE e enviadas ao servidor.</p></li>
  <li><p align="justify"><b>Variáveis INOUT: </b>Variáveis INOUT são enviadas pelo servidor (@var deve ser criada) e a PROCEDURE reenvia seu novo resultado ao servidor (OUT).</p></li>
  <li><p align="justify"><b>Variáveis não declaradas: </b>Para declarar literalmente uma variável à PROCEDURE, a variável não deve ser <b>OUT</b> ou <b>INOUT</b> (como a variável 'taxa' no exemplo 1 de INOUT).</p></li>
</ol>

<p align="justify">Ou seja, não há diferença, para variáveis de entrada, declarar ou não <b>IN</b>. Sempre se deverá informar um valor dentro dos parâmetros. Deve-se atentar somente para variáveis <b>OUT ou INOUT</b>, pois nestas se deve declarar antes e durante a CALL da PROCEDURE (INOUT) ou somente durante a CALL da procedure (OUT).</p>

<h3>1.2 BLOCO BEGIN END</h3>

<p align="justify">
  São "contêineres" usados para delimitar blocos de comando a serem executados pela FUNCTION ou STORED PROCEDURE. Eles:
</p>

<ul>
  <li><p align="justify">Cada comando deve terminar com ';' (ponto e vírgula).</p></li>
  <li><p align="justify">Pode haver BEGIN END aninhados, ou seja, um BEGIN END dentro de outro BEGIN END.</p></li>
</ul>

<h3>1.3 CONDICIONAIS</h3>

<p align="justify">
  Podem ser usados em PROCEDURES e variáveis (DECLARE) podem receber condicionais
</p>

```sql
-- sintaxe IF:
IF condicao THEN operacao
ELSEIF condicao THEN operacao
ELSE operacao
END IF;

-- sintaxe CASE WHEN:
CASE WHEN condicao THEN operacao
     WHEN condicao THEN operacao
     ELSE operacao
     END;
```

<h3>1.4 ESTRUTURAS DE REPETIÇÃO</h3>

<p align="justify">
  Criam uma iteração que se repete até que um comando de parada seja acionado. São eles: <b>LOOP, REPEAT, WHILE</b>.
</p>

```sql
-- sintaxe LOOP
nomeLoop: LOOP
-- comandos...
END LOOP nomeLoop;

-- sintaxe REPEAT
nomeRepeat: REPEAT
-- comandos...
UNTIL condicao
END REPEAT nomeRepeat;

-- sintaxe WHILE
nomeWhile: WHILE
-- comandos...
END WHILE nomewhile;
```

<p align="justify">
  Dentro das estruturas de repetição, podem haver os comandos de continuar ou de parada do iteração:
</p>

<ol>
  <li><p align="justify"><b>ITERATE: </b>O comando ITERATE é usado para pular uma iteração específica de um loop e avançar para a próxima iteração. Isso permite que você ignore certas condições e continue o loop com a próxima iteração. O ITERATE é útil quando você deseja pular a execução de algumas instruções dentro do loop e ir diretamente para a próxima iteração. O ITERATE é semelhante ao comando CONTINUE em outros dialetos de SQL.</p></li>
  <li><p align="justify"><b>LEAVE: </b>O comando LEAVE é usado para sair completamente de um loop, interrompendo a execução do loop em sua totalidade. Quando o LEAVE é executado, o loop é interrompido e a execução continua após o bloco de loop. O LEAVE é comparável ao comando BREAK em outros dialetos de SQL.</p></li>
</ol>

<p align="justify">Exemplos de cada uma, na ordem de facilidade (REPEAT, LOOP, WHILE):</p>

```sql
-- 1. REPEAT
delimiter //
create procedure acumula_repeat (limite int)
main:
begin
	declare iterador int default 0;
	declare soma int default 0;
	if limite < 0 then
		select concat('Numero de "limite" deve ser maior que zero ->> ', limite, ' < 0');
		leave main;
	end if;
	repeticao: repeat
		set iterador = iterador + 1;
		set soma = soma + iterador;
	until iterador = limite end repeat repeticao;           -- a igualdade é inclusa
	select soma into @resultado_repeat;                     -- criando var com resultado
	select soma;
end //
delimiter ;


-- 2. LOOP
delimiter //
create procedure acumula_loop (limite int)
main:
begin
	declare iterador int default 0;
	declare soma int default 0;
	if limite < 0 then
		select concat('Numero de "limite" deve ser maior que zero ->> ', limite, ' < 0');
		leave main;
	end if;
	repeticao: loop 
		if iterador < limite then
			set iterador = iterador + 1;
			set soma = soma + iterador;
		else
			leave repeticao;
		end if;
	end loop repeticao;
	select soma into @resultado_loop;						-- criando var com resultado
	select soma;
end //
delimiter ;


-- 3. WHILE
delimiter //
create procedure acumula_while (limite int)
main:
begin
	declare iterador int default 0;
	declare soma int default 0;
	if limite < 0 then
		select concat('Numero de "limite" deve ser maior que zero ->> ', limite, ' < 0');
		leave main;
	end if;
	repeticao: while iterador < limite do                   -- no while, a igualdade iterador = limite é inclusa
		set iterador = iterador + 1;
		set soma = soma + iterador;
	end while repeticao;
	select soma into @resultado_while;						-- criando var com resultado
	select soma;
end //
delimiter ;


-- 4. chamando procedures (cada uma retorna um select e uma var @)
call acumula_repeat(7);
call acumula_loop(7);
call acumula_while(7);

select @resultado_repeat, @resultado_loop, @resultado_while;   -- chamando as var @ de resultado
```

<table align="center"><thead><tr><th>@resultado_repeat</th><th>@resultado_loop</th><th>@resultado_while</th></tr></thead><tbody><tr><td>28</td><td>28</td><td>28</td></tr></tbody></table>

<h3>1.5 EXEMPLOS: IN, OUT, INOUT</h3>

<p align="justify">
  <b>EXEMPLO 1: INOUT - procedure que recebe um salário (varriável IN) e o devolve com um aumento de 10% (variável OUT).</b>
</p>

```sql
delimiter //
create procedure proc_aumento_1 (inout valor float, taxa float)        -- INOUT recebe um valor (variável) e altera esse valor.
begin
 set valor = valor * (1 + taxa);
end //
delimiter ;

set @valor = 100;                                     -- setando variável 'valor' (IN)
call proc_aumento_1(@valor, 0.1);                     -- chamando função
select @valor;                                        -- 'valor' alterado         (OUT)
```

<table align="center"><thead><tr><th>@valor</th></tr></thead><tbody><tr><td>110</td></tr></tbody></table>

<p align="justify">
  <b>EXEMPLO 2: IN - procedure que busca o total do preço dos remédios, agrupados por remédio e médico, filtrando ou pelo nome da especialidade do médico (IN) ou pelo seu ID (IN).</b>
</p>

```sql
delimiter //
create procedure consultaPrecoRemedio (in medicoID int, in nomeEspec text)
begin
	select 
	m.`id` as `medicoId`
      , m.`nome` as `medico`
      , m.`especialidade`
      , rm.`nome` as `remedio`
      , sum(rm.`preco`) as `totalReceitado`
      from medico m
  	inner join consulta c on c.`medico_id` = m.`id`
  	inner join paciente p on c.`paciente_id` = p.`id`
  	inner join receita r on c.`id` = r.`consulta_id`
  	inner join remedio rm on rm.`id` = r.`remedio_id`
      where m.`especialidade` regexp(nomeEspec) 
         or m.`id` = medicoID
      group by m.`id`, m.`nome`, m.`especialidade`, rm.`nome`
      order by `totalReceitado` desc;
end //
delimiter ;

call consultaPrecoRemedio(null, 'cardio');
```

<table align="center"><thead><tr><th>medicoId</th><th>medico</th><th>especialidade</th><th>remedio</th><th>totalReceitado</th></tr></thead><tbody><tr><td>1</td><td>Dr. João Santos</td><td>cardio</td><td>Remedio 1</td><td>21</td></tr><tr><td>1</td><td>Dr. João Santos</td><td>cardio</td><td>Remedio 6</td><td>18,5</td></tr></tbody></table>

<p align="justify">
  Ambas as variáveis são tipo IN, declaradas literamente pelo usuário ou implantadas (@). A <b>procedure somente retorna a tabela do SELECT</b>, sem variáveis de saída. Note que para pode ser uma ou outra variável (ID ou especialidade). E para chamar uma e não a outra e vice-versa, o argumento da <b>CALL</b> é <b>NULL</b>.
</p>

<p align="justify">
  <b>EXEMPLO 3: IN - procedure que atualiza (UPDATE) o preço de um determinado remédio, podendo ser uma correção percentual ou por taxa.</b>
</p>

```sql
delimiter //
create procedure alterarPreco (in remedioID int, 
                               in tipo enum('percentual', 'valor'), 
                               in valor float)
begin
	update remedio
	set preco = case when tipo = 'percentual' then preco * (1 + valor)
                         when tipo = 'valor' then preco + valor 
                         end 
	where id = remedioID;
end //
delimiter ;

select * from remedio where id = 2;                -- preço antigo -> 25,1074
call alterarPreco(2, 'percentual', 0.1);
select * from remedio where id = 2;
```

<table align="center"><thead><tr><th>ID</th><th>nome</th><th>preco</th><th>planos_cobertos</th></tr></thead><tbody><tr><td>2</td><td>Remedio 2</td><td>27,6182</td><td>AMIL</td></tr></tbody></table>

<p align="justify">
  <b>EXEMPLO 4: OUT - procedure que atualiza o preco de um determinado remedio e envia/armazena o preco inicial (OUT) e o corrigido (OUT).</b>
</p>

```sql
delimiter //
create procedure alterarValor (in remedioId int, 
                               taxa float,
                               out antes float,
                               out depois float)
begin
	-- antes entra em 'antes', depois entra em 'depois': col1, col2 INTO var1, var2
	select 
	  preco as antes
	, preco * (1 + taxa) as depois 
	into
          antes                                -- var OUT 'antes' recebe 1ª col, coluna 'antes'
        , depois                               -- var OUT 'depois' recebe 2ª col, coluna 'depois'
	from remedio where id = remedioId;
    update remedio
    set preco = preco * (1 + taxa)
    where id = remedioId;
end //
delimiter ;

call alterarValor(2, 0.1, @antes, @depois);
select * from remedio where id = 2;                -- de 30.3801 foi para 33.4181
select @antes as `antes`, @depois as `depois`;
```

<table align="center"><thead><tr><th>antes</th><th>depois</th></tr></thead><tbody><tr><td>30,38007545</td><td>33,41808319</td></tr></tbody></table>

<p align="justify">
	Dois pontos a reparar:
</p>

<ol>
	<li><p align="justify"><b>Atribuição INTO: </b>Note que cada valor no SELECT (antes, depois) foi atribuido a uma variável após a cláusula INTO: <b>col1, col2 INTO var1, var2</b>.</p></li>
	<li><p align="justify"><b>CALL de variáveis OUT: </b>Para chamar a função, as variáveis OUT devem ser inseridas nos parâmetros da PROCEDURE como acima. Ou seja: <b>CALL procedure(@varOUT);</b>.</p></li>
</ol>

<h3>1.6 EXEMPLOS: ITERAÇÕES</h3>

<h4>1.6.1 REPEAT</h4>

<h5>1.6.1.1 REPEAT, somente</h5>

<p align="justify">
	<b>EXEMPLO 1: </b> Procedure que apura a tabuada de um nº de 1 a 10.
</p>

```sql
delimiter //
create procedure tabuada(numero int)
main:
begin
    declare tabuada_de int default 0;
    declare resultado int;
	repeat
	    set tabuada_de = tabuada_de + 1;
	    set resultado = numero * tabuada_de;
            select concat(numero, ' x ', tabuada_de, ' = ', resultado);
	until tabuada_de = 10 end repeat;                                       -- Dará até que tabuada_de = 10, incluso. Depois termina.
end //
delimiter ;

call tabuada(7);
```

<table align="center"><thead><tr><th>concat(numero, &#39; x &#39;, tabuada_de, &#39; = &#39;, resultado)</th></tr></thead><tbody><tr><td>7 x 1 = 7</td></tr><tr><td>7 x 2 = 14</td></tr><tr><td>7 x 3 = 21</td></tr><tr><td>7 x 4 = 28</td></tr><tr><td>7 x 5 = 35</td></tr><tr><td>7 x 6 = 42</td></tr><tr><td>7 x 7 = 49</td></tr><tr><td>7 x 8 = 56</td></tr><tr><td>7 x 9 = 63</td></tr><tr><td>7 x 10 = 70</td></tr></tbody></table>

<p align="justify">Acima, cada SELECT produzirá uma consulta a parte, cada uma com um resultado. <b>Para melhorar, pode-se armazenar cada resultado SELECT em uma tabela tempoorária</b>.</p>


<h5>1.6.1.2 REPEAT com tabela temporária</h5>

<p align="justify">EXEMPLO 1: Procedure que realize tabuada de um número até 10. Mas que os resultados sejam armazenados em uma tabela temporária.</p>

```sql
delimiter //
create procedure tabuadaTable(numero int)
main:
begin
    -- variaveis
    declare tabuada_de int default 0;
    declare resultado int;
    -- tabela temporária
    create temporary table tabuada_temp (resposta text);
	repeat
            set tabuada_de = tabuada_de + 1;
	    set resultado = numero * tabuada_de;
            -- inserindo valores
	    insert into tabuada_temp
	    	select concat(numero, ' x ', tabuada_de, ' = ', resultado);
	until tabuada_de = 10 end repeat;
        -- retornando (1) e deletando a tabela temporária (2)
	select * from tabuada_temp;           -- (1)
	drop table tabuada_temp;              -- (2)
end //
delimiter ;

call tabuadaTable(7);
```

<table align="center"><thead><tr><th>resposta</th></tr></thead><tbody><tr><td>7 x 1 = 7</td></tr><tr><td>7 x 2 = 14</td></tr><tr><td>7 x 3 = 21</td></tr><tr><td>7 x 4 = 28</td></tr><tr><td>7 x 5 = 35</td></tr><tr><td>7 x 6 = 42</td></tr><tr><td>7 x 7 = 49</td></tr><tr><td>7 x 8 = 56</td></tr><tr><td>7 x 9 = 63</td></tr><tr><td>7 x 10 = 70</td></tr></tbody></table>

<p align="justify">Acima, a tabela temporária é criada, cada SELECT é introduzido nela. Ao final da repetição REPEAT a tabela é retornada com SELECT e destruída na sequência. Caso a tabela temporária não fosse excluída, retornaria erro ao processar novamente a PROCEDURE, porque a tabela já existiria. Outra opção é inserir o comando IF NOT EXISTS dentro da criação da tabela. Mas, neste caso, dever-se-ia truncar a tabela removendo os registros da tabuada antiga.</p>

<h5>1.6.1.3 REPEAT com IF</h5>

<p align="justify">
	<b>EXEMPLO 1: </b>Procedure que, começando de 1, soma a sequência de números inteiros seguintes até que atinga um valor estabelecido. Caso esse valor estabelecido seja menor ou igual a zero, não faz nada.
</p>

```sql
delimiter //
create procedure proc_acumula(valor_teto int)
main:
begin
    declare contador int default 0;
    declare soma int default 0;
    if valor_teto <= 0 then                                                                       -- se o valor informado valor_teto for menor que zero...
      select concat('valor de ', valor_teto, ' deve ser maior que 0') as `erro`;                  -- ...retorna a mensagem...
      leave main;                                                                                 -- ...e sai totalmente da procedure. 
    end if;
   
    repeat
      set contador = contador + 1;                             -- acumula o valor de contador com 1
      set soma = soma + contador;                              -- acumula o valor de soma com o valor do contador
    until contador = valor_teto end repeat;                    -- até que o contador seja o valor informado, valor_teto
   select soma, contador;                                      -- retorna a soma acumulada dos contadores e último valor do contador, valor_teto
end //
delimiter ;
```

```sql
call proc_acumula(0);          -- quando não passa pelo condicional IF, pois o nº do contador deve ser maior que 0.
```

<table align="center"><thead><tr><th>erro</th></tr></thead><tbody><tr><td>valor de 0 deve ser maior que 0</td></tr></tbody></table>

```sql
call proc_acumula(5);          -- valor total da soma dos contadores e a quantidade de contadores, ou valor_teto (5).
```

<table align="center"><thead><tr><th>soma</th><th>contador</th></tr></thead><tbody><tr><td>15</td><td>5</td></tr></tbody></table>

<p align="justify">
	<b>EXEMPLO 2: </b>Procedure que some sequencialmente o preço dos remédios, começando do remédio de ID 1 e indo até um número de ID determinado informado. Caso este ID informado seja menor que zero ou maior que o último ID de remédios, interromper e sair da execução.
</p>

```sql
delimiter //
create procedure somaPrecos_1 (ultimoId int)
main: 
begin
    -- variaveis
    declare soma float default 0;
    declare iterate_id int default 1;
    declare contador int default 0;
    declare maximoId int;

    --setando valor da var "maximoId"
    select max(id) into maximoId from remedio;

    -- condicional
    if ultimoId <= 0 or ultimoId > maximoId then
       select concat('valor deve ser maior que 0 e menor que ', maximoId) as `erro`;
       leave main;
    end if;

    --bloco REPEAT
    repeat
      set soma = soma + (select preco from remedio where id = iterate_id);            -- acumulando os precos dos remédios sequencialmente
      set iterate_id = iterate_id + 1;                                                -- o ID do remedio aumenta 1 a cda sequencia para ser usado no filtro
      set contador = contador + 1;                                                    -- o contador aumenta para dar a parada em UNTIL
    until contador = ultimoId end repeat;
   select soma, contador;
end //
delimiter ;
```

```sql
call somaPrecos_1(0);           -- mensagem de erro, pois não existe id de remédio que seja zero.
```

<table align="center"><thead><tr><th>erro</th></tr></thead><tbody><tr><td>valor deve ser maior que 0 e menor que 15</td></tr></tbody></table>

```sql
call somaPrecos_1(5);
```

<table align="center"><thead><tr><th>soma</th><th>contador</th></tr></thead><tbody><tr><td>101,168</td><td>5</td></tr></tbody></table>

<h4>1.6.2 LOOP</h4>

<p align="justify">Iterações LOOP obrigatoriamente devem ter um comando IF. Pois, o comando de parada é dado pela condição lógica do IF. Uma Sintaxe padrão:</p>

```sql
DELIMITER //
CREATE PROCEDURE nome (params)
BEGIN
	-- declarar variaveis
	DECLARE var tipo;
	SELECT col INTO var FROM tabela ... ;
	DECLARE iterador INT DEFAULT 0;                    -- variavel de iteração para limitar IF e interromper LOOP
	loopIteracao: LOOP
		SET iterador = iterador + 1;
		IF iterador <= parada THEN
			-- comandos
		ELSEIF condicao THEN
			ITERATE loopIretacao;              -- passa para a próxima iteração
		ELSE
			LEAVE loopIteracao;                -- sai da iteração totalmente
		END IF;
	END LOOP iteracao;
	-- comandos
END //
DELIMITER ;
```

<p align="justify"><b>EXEMPLO 1: </b>Procedure que faça a tabuada de um determinado número e que armazene os resultados em uma tabela temporária, removendo-a ao final.</p>

```sql
delimiter //
create procedure tabuadaLoop(numero int)
begin
	declare tabuada_de int default 0;
	declare resultado int default 0;
	create temporary table if not exists resultados (resultado text);
	iteracao: loop  
		if tabuada_de <= 9 then
			set tabuada_de = tabuada_de + 1;
			set resultado = numero * tabuada_de;
			insert into resultados
				select concat(numero, ' x ', tabuada_de, ' = ', resultado);
		else 
			leave iteracao;
		end if;
	end loop iteracao;
	select * from resultados;
	truncate table resultados;
end //
delimiter ;

call tabuadaLoop(7);
```

<table align="center"><thead><tr><th>resultado</th></tr></thead><tbody><tr><td>7 x 1 = 7</td></tr><tr><td>7 x 2 = 14</td></tr><tr><td>7 x 3 = 21</td></tr><tr><td>7 x 4 = 28</td></tr><tr><td>7 x 5 = 35</td></tr><tr><td>7 x 6 = 42</td></tr><tr><td>7 x 7 = 49</td></tr><tr><td>7 x 8 = 56</td></tr><tr><td>7 x 9 = 63</td></tr><tr><td>7 x 10 = 70</td></tr></tbody></table>

<p align="justify"><b>EXEMPLO 2: </b>Procedure que retorne uma tabela com os números ímpares. Caso sejam pares, esquipá-los da iteração (ITERATE).</p>

```sql
delimiter //
create procedure resto()
begin
	declare i int default 0;
	create temporary table if not exists resultados (resultado text);
	parImpar: loop
    	set i = i + 1;
    	if i >= 10 then
        	leave parImpar;         -- ultimo numero -> sai totalmente do loop
    	elseif mod(i, 2) = 0 then   
        	iterate parImpar;       -- numero par - passa pra próxima iteração
    	end if;
    	insert into resultados select concat(i," é ímpar");
	end loop parImpar;
	select * from resultados;
	truncate table resultados;
end //
delimiter ;
```

<table align="center"><thead><tr><th>resultado</th></tr></thead><tbody><tr><td>1 é ímpar</td></tr><tr><td>3 é ímpar</td></tr><tr><td>5 é ímpar</td></tr><tr><td>7 é ímpar</td></tr><tr><td>9 é ímpar</td></tr></tbody></table>

<p align="justify"><b>EXEMPLO 3: </b>Procedure que crie, retorne e delete uma tabela temporária com o ID, nome, preco em real, preco dolarizado dos remédios com base em uma cotação. Caso o remédio não possua planos que o cubram, deve ser ignorado <b>(ITERATE)</b>.</p>

```sql
delimiter //
create procedure descontoPlanos (aliquota_1 decimal(10,2), aliquota_2 decimal(10,2), aliquota_3 decimal(10,2))
begin
	declare iterador int default 0;
	declare limite int;
	declare virgulas int;
	select max(id) into limite from remedio;
	create temporary table if not exists descontoPlanos_temp (id int,
	                                                          remedio text,
	                                                          preco float,
	                                                          combo text,
	                                                          aliquota decimal(10,2),
	                                                          precoDescontado float);
	iteracao: loop
		set iterador = iterador + 1; 
		if iterador <= limite then
			select length(planos_cobertos) - length(replace(planos_cobertos, ',', '')) 
			into virgulas 
			from remedio 
		    where id = iterador;
			if virgulas = 0 then
				insert into descontoPlanos_temp
					select id, nome, preco, '1 plano', aliquota_1, preco * (1-aliquota_1)
					from remedio where id = iterador;
			elseif virgulas = 1 then 
				insert into descontoPlanos_temp
					select id, nome, preco, '2 planos', aliquota_2, preco * (1-aliquota_2)
				    from remedio where id = iterador;
			elseif virgulas = 2 then
				insert into descontoPlanos_temp
					select id, nome, preco, '3 planos', aliquota_3, preco * (1-aliquota_3)
					from remedio where id = iterador;
			else
				iterate iteracao;     -- passa para o próximo loop
			end if;
		else
			leave iteracao;               -- sai do loop completamente
		end if;
	end loop iteracao;
	select * from descontoPlanos_temp;
	truncate table descontoPlanos_temp;
end //
delimiter ;

call precoDolar(3.50);
```

<table align="center"><thead><tr><th>id</th><th>remedio</th><th>preco</th><th>combo</th><th>aliquota</th><th>precoDescontado</th></tr></thead><tbody><tr><td>1</td><td>Remedio 1</td><td>10,5</td><td>2 planos</td><td>0,2</td><td>8,4</td></tr><tr><td>2</td><td>Remedio 2</td><td>33,4181</td><td>1 plano</td><td>0,1</td><td>30,0763</td></tr><tr><td>3</td><td>Remedio 3</td><td>15</td><td>1 plano</td><td>0,1</td><td>13,5</td></tr><tr><td>4</td><td>Remedio 4</td><td>30,25</td><td>3 planos</td><td>0,4</td><td>18,15</td></tr><tr><td>5</td><td>Remedio 5</td><td>12</td><td>1 plano</td><td>0,1</td><td>10,8</td></tr><tr><td>7</td><td>Remedio 7</td><td>25</td><td>2 planos</td><td>0,2</td><td>20</td></tr><tr><td>8</td><td>Remedio 8</td><td>8,75</td><td>1 plano</td><td>0,1</td><td>7,875</td></tr><tr><td>9</td><td>Remedio 9</td><td>16,5</td><td>2 planos</td><td>0,2</td><td>13,2</td></tr><tr><td>10</td><td>Remedio 10</td><td>22,5</td><td>2 planos</td><td>0,2</td><td>18</td></tr><tr><td>11</td><td>Remedio 11</td><td>14,25</td><td>2 planos</td><td>0,2</td><td>11,4</td></tr><tr><td>12</td><td>Remedio 12</td><td>18,75</td><td>1 plano</td><td>0,1</td><td>16,875</td></tr><tr><td>13</td><td>Remedio 13</td><td>12,5</td><td>1 plano</td><td>0,1</td><td>11,25</td></tr><tr><td>14</td><td>Remedio 14</td><td>20</td><td>2 planos</td><td>0,2</td><td>16</td></tr><tr><td>15</td><td>Remedio 15</td><td>33</td><td>2 planos</td><td>0,2</td><td>26,4</td></tr></tbody></table>

<p align="justify">Repare que o remédio de ID 6 não está presente. Porque não havia planos que o cobriam e, com isso, ele foi esquipado. Note também que há 2 IFs, sendo o 1º ELSE para o ITERATE e o 2º para o LEAVE. O 1º IF testa o limite do loop enquanto o 2º testa quem entra ou sai da consulta.</p>

<h2>2. TRATANDO ERROS OU EXCEÇÕES</h2>

<p align="justify">
	Em SQL, erros são tratados dentro de variáveis DECLARE. Dentro do DECLARE, deve-se setar:
</p>

<ol>
	<li><p align="justify"><b>HANDLER: </b>Como irá lidar com o erro (continue handler, exit handler, etc.). <b>NOTA: </b>O handler mais comum é o CONTINUE HANDLER porque é possível definir caminhos de ação através de condicional IF;</p></li>
	<li><p align="justify"><b>Tipo de exceção: </b>Qual o erro que se deve tratar. Pode ser um erro específico, definindo a numeração do <b>SQLSTATE</b> que representa um erro (de inserção, de update, etc.) ou um erro qualquer, sem definição (<b>SQLEXCEPTION</b>).</p></li>
</ol>

<p align="justify">Uma SINTAXE BÁSICA para lidar com QUALQUER ERRO é:</p>

```sql
delimiter //
create procedure exemplo (params)
inicio: begin
	declare erro smallint default = 0;                                       -- var que define o caminho no IF
	declare continue handler for sqlexception set erro = 1;                  -- se houver problemas, erro muda de 0 para 1

	begin
	-- comandos, que podem apresentar erros/problemas
		if erro = 1 then
		-- instrucoes se 'comandos' apresentar problemas
		else 
		-- instrucoes se 'comandos' NÃO apresentar problemas
		end if;
	end;
end //
delimiter ;
```

<p align="justify">
	<b>EXEMPLO 1: Fazer procedure para 'lojinha' para inserir novos pedidos. Tratar qualquer erro, SQLEXCEPTION.</b>
</p>

```sql
delimiter //
create procedure tratar_excecao_1 (comprador text, bairro text, entregaId int, resposta text)
insert_pedido: begin
	-- setando variável com default zero
	declare excecao smallint default 0;
	-- caso ocorra erro setar 'excecao' igual a 1
	declare continue handler for sqlexception set excecao = 1;
    
    begin
	-- insert de valores
        insert into pedidos values (id, comprador, bairro, entregaId);
        
        -- checando excecao com IF: Se der erro (não insertar), excecao é 1 e informa o erro, caso contrário, faz o insert
        if excecao = 1 then
	    set resposta = 'Erro ao gravar dados.';
            select resposta as ocorrencia;
            rollback;
            leave insert_pedido;
	else
            set resposta = 'Salvo com sucesso.';
            select resposta as ocorrencia;
            commit;
	end if;
    end;
end //
delimiter ;
```

<p align="justify">No db 'lojinha', a tabela 'entregas' só possui 2 registros. Assim, o campo 'entregaId', que é FK de entregas.Id só pode receber 1 ou 2. Inserir um novo registro com entregaId = 3 geraria um erro de FK (SQLSTATE). Ao chamar a procedure acima com CALL e tentar inserir um registro com 'entregaId' = 3, teriamos:</p>

```sql
call tratar_excecao_1('Paulo', 'Taquara', 3, @resposta);
```

<table align="center"><thead><tr><th>ocorrencia</th></tr></thead><tbody><tr><td>Erro ao gravar dados.</td></tr></tbody></table>

<p align="justify">Uma SINTAXE BÁSICA para lidar com ERROS ESPECÍFICOS é:</p>

```sql
delimiter //
create procedure exemplo (params)
inicio: begin
    declare var_de_erro condition for sqlstate 'XXXXX'                -- 'XXXXX' é uma string do numero SQLSTATE do erro a tratar
    declare erro smallint default 0;                                  -- var que define o caminho no IF
    declare continue handler for var_de_erro set erro = 1;            -- se ocorrer o erro SQLSTATE 'XXXXX', erro muda de 0 para 1

    begin
    -- comandos, que podem dar o SQLSTATE 'XXXXX'
        if erro = 1 then
        -- instrucoes, se 'comandos' ocorrer SQLSTATE 'XXXXX'
        else
        -- instrucoes, se 'comandos' NAO ocorrer SQLSTATE 'XXXXX'
        end if;
    end;
end//
delimiter ;
```

<p align="justify">
	<b>EXEMPLO 2: Fazer procedure para 'lojinha' para inserir novos pedidos. Tratar erro de FK, SQLSTATE, cujo código do erro é 23000.</b>
</p>

```sql
delimiter //
create procedure tratar_excecao_2 (comprador text, bairro text, entregaId int)
insert_pedido: begin
    declare erro_1452 condition for sqlstate '23000';
    declare excecao smallint default 0;
    declare continue handler for erro_1452 set excecao = 1;
    
    begin
        -- insert de valores
        insert into pedidos values (id, comprador, bairro, entregaId);
        
        -- checando excecao com IF: se 'erro_1452' for verdadeiro, avisar, rollback e sair da procedure.
        if excecao = 1 then
	    select 'Erro ao gravar dados. Problema de FK.' as ocorrencia;
            rollback;
            leave insert_pedido;
        else
	    select 'Salvo com sucesso.' as ocorrencia;
            commit;
	end if;
    end;
end //
delimiter ;
```

<p align="justify">Tentando inserir um registro em 'pedidos' com a procedure acima:</p>

```sql
call tratar_excecao_2('Paulo', 'Taquara', 3);
```

<table align="center"><thead><tr><th>ocorrencia</th></tr></thead><tbody><tr><td>Erro ao gravar dados. Problema de FK.</td></tr></tbody></table>
