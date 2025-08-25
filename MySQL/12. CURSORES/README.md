<h1>1. CURSOR</h1>

<p align="justify">
  Cursores são declarações em PROCEDURES e TRIGGERS que são usados com LOOPS. Servem para armazenar na memória registro a registro a cada iteração de uma consulta ou cálculo:
</p>

<ul>
  <li><p align="justify"><b>1º: </b>Usados em PROVEDURES E TRIGGERS;</p></li>
  <li><p align="justify"><b>2º: </b>Em lassos de repetição (loops);</p></li>
  <li><p align="justify"><b>3º: </b>Cada registro a ser armazenado deve ser declarada uma variável;</p></li>
  <li><p align="justify"><b>4º: </b>O cursor deve ser aberto (open), inserir os registros em cada variável (fetch) e depois fechado ao final do loop (close);</p></li>
  <li><p align="justify"><b>5º: </b>Por ser usado em lassos, deve haver um comando de parada. O qual pode ser um contador de linhas do SELECT (1), ou um HANDLER (2).</p></li>
</ul>

<p align="justify">
  Sintaxe básica para o stop de parada do LOOP em ambas situações. Com contador de parada (1) e com HANDLER (2):
</p>

```sql
-- Exemplo em procedure com contador de parada (1):

CREATE PROCEDURE procedimento ()
main: BEGIN
  DECLARE var1 tipo1;
  DECLARE var2 tipo2;
  DECLARE varN tipoN;
  DECLARE cur_fim INT;
  DECLARE contador INT DEFAULT 0;
  DECLARE cur CURSOR FOR SELECT col1, col2, colN FROM tabela;

  SELECT COUNT(*) INTO cur_fim FROM tabela;

  OPEN cur;
  meu_loop: LOOP
    SET contador = contador + 1;
    IF contador >= cur_fim THEN
      FETCH cur INTO var1, var2, varN;
    ELSE
      LEAVE meu_loop;
    END IF;
  END LOOP;
  CLOSE cur;
END;
```

```sql
-- Exemplo em procedure com HANDLER (2):
CREATE PROCEDURE procedimento()
main: BEGIN
  DECLARE var1 tipo1;
  DECLARE var2 tipo2;
  DECLARE varN tipoN;
  DECLARE fim INT DEFAULT 0;
  DECLARE cur CURSOR FOR SELECT col1, col2, colN FROM tabela;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 1;

  OPEN cur;
  meu_loop: LOOP
  	    FETCH NEXT FROM cur INTO var1, var2, varN;
        IF fim = 1 THEN
          LEAVE meu_loop;
        ELSE
          -- comandos
        END IF;
  END LOOP;
  CLOSE cur;
```

<p align="justify">Detalhes:</p>

<ul>
  <li><p align="justify"><b>No 1º exemplo, com contador: </b>O LOOP termina quando o contador atinge o total de linhas da tabela. Na iteração cara variável declarada (var1, var2, varN) receberá um registro da tabela através do comando FETCH;</p></li>
  <li><p align="justify"><b>No 2º exemplo, com HANDLER: </b>A variável 'fim' define o valor binário entre 0 e 1, a qual o HANDLER do tipo NOT FOUND alterará seu valor de 0 para 1 quando o cursor não encontrar qualquer registro para armazenar nas demais variáveis. No LOOP, FETCH NEXT pegará automaticamente os registros seguintes da tabela do cursor;</p></li>
  <li><p align="justify"><b>NOTA: </b>Cursores são declarados assim como variáveis, bem como seu HANDLER, caso usado. Contudo, as variáveis devem ter o DECLARE antes do cursor e o HANDLER depois dele. Ainda, note que cada variável armazenada em FETCH será a mesma da sequência do SELECT do cursor.</p></li>
</ul>

<p align="justify">
  <b>EXEMPLO 1: </b>No DB 'lojinha', fazer uma procedure que retorne uma tabela 'produtosDois', contendo as colunas produto, tipo e preco da tabela 'produtos', usando cursor com contador.
</p>

```sql
CREATE PROCEDURE exemplo_1 ()
main: BEGIN
  DECLARE produto_cur TEXT;
  DECLARE tipo_cur TEXT;
  DECLARE preco_cur DECIMAL(10,2);
  DECLARE cur_fim INT;
  DECLARE contador INT DEFAULT 0;
  DECLARE cur CURSOR FOR SELECT produto, tipo, preco FROM produtos;

  SELECT COUNT(*) INTO cur_fim FROM produtos;
  CREATE TEMPORARY TABLE IF NOT EXISTS produtosDois (
 	produto text, tipo text, preco decimal(10,2)
  );
 
  OPEN cur;
  	meu_loop: LOOP
    	SET contador = contador + 1;
    	IF contador <= cur_fim THEN
      		FETCH cur INTO produto_cur, tipo_cur, preco_cur;
      		INSERT INTO produtosDois VALUES (produto_cur, tipo_cur, preco_cur);
    	ELSE
      		LEAVE meu_loop;
    	END IF;
  	END LOOP;
  CLOSE cur;
  SELECT * FROM produtosDois;
  DROP TEMPORARY TABLE produtosDois;
END;

-- chamando
CALL exemplo_1();
```

<table align="center"><thead><tr><th>produto</th><th>tipo</th><th>preco</th></tr></thead><tbody><tr><td>pao</td><td>padaria</td><td>1,2</td></tr><tr><td>leite</td><td>lacteos</td><td>1,4</td></tr><tr><td>manteiga</td><td>lacteos</td><td>1,35</td></tr><tr><td>ovo</td><td>animais</td><td>1,1</td></tr><tr><td>presunto</td><td>frios</td><td>2,4</td></tr><tr><td>queijo</td><td>frios</td><td>1,8</td></tr><tr><td>café</td><td>bebidas</td><td>1,3</td></tr><tr><td>mortadela</td><td>frios</td><td>1,2</td></tr><tr><td>suco</td><td>bebidas</td><td>0,8</td></tr><tr><td>banana</td><td>frutas</td><td>0,75</td></tr><tr><td>maça</td><td>frutas</td><td>0,55</td></tr></tbody></table>

<p align="justify">
  <b>EXEMPLO 2: </b>Mesmo cenário, mas usando HANDLER do tipo NOT FOUND.
</p>

```sql
CREATE PROCEDURE exemplo_2()
main:BEGIN
	DECLARE produto_cur TEXT;
	DECLARE tipo_cur TEXT;
	DECLARE preco_cur DECIMAL(10,2);
	DECLARE done INT DEFAULT 0; 
	DECLARE cur CURSOR FOR SELECT produto, tipo, preco FROM produtos;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

	CREATE TEMPORARY TABLE IF NOT EXISTS produtosDois (
    	produto TEXT, tipo TEXT, preco DECIMAL(10,2)
    );

	OPEN cur;
		main_loop: LOOP
	    	FETCH NEXT FROM cur INTO produto_cur, tipo_cur, preco_cur;
	    	IF done = 1 THEN
	    		LEAVE main_loop;
	    	ELSE
	    		INSERT INTO produtosDois VALUES (produto_cur, tipo_cur, preco_cur);
	    	END IF;
		END LOOP;
	CLOSE cur; -- encerra o cursor

	SELECT * FROM produtosDois;
	DROP TEMPORARY TABLE produtosDois;

END;

-- chamando
CALL exemplo_2();
```

<table align="center"><thead><tr><th>produto</th><th>tipo</th><th>preco</th></tr></thead><tbody><tr><td>pao</td><td>padaria</td><td>1,2</td></tr><tr><td>leite</td><td>lacteos</td><td>1,4</td></tr><tr><td>manteiga</td><td>lacteos</td><td>1,35</td></tr><tr><td>ovo</td><td>animais</td><td>1,1</td></tr><tr><td>presunto</td><td>frios</td><td>2,4</td></tr><tr><td>queijo</td><td>frios</td><td>1,8</td></tr><tr><td>café</td><td>bebidas</td><td>1,3</td></tr><tr><td>mortadela</td><td>frios</td><td>1,2</td></tr><tr><td>suco</td><td>bebidas</td><td>0,8</td></tr><tr><td>banana</td><td>frutas</td><td>0,75</td></tr><tr><td>maça</td><td>frutas</td><td>0,55</td></tr></tbody></table>
