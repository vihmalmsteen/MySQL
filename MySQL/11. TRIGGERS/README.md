<h1>1. TRIGGERS</h1>

<p align="justify">
  São eventos condicionados que ocorrem em função de um DML (INSERT, DELETE, UPDATE). Sua sintaxe básica:
</p>

```sql
CREATE TRIGGER gatilho MOMENTO OPERACAO
ON tabela
FOR EACH ROW
-- comandos
```

<p align="justify">
  Após o nome da trigger, dos argumentos MOMENTO e OPERACAO: argumento BEFORE ou AFTER são usados para dizer quando a trigger vai ocorrer: antes (BEFORE) ou depois (AFTER). 
</p>

<ul>
  <li><p><b>MOMENTO: </b>Pode ser <b>BEFORE</b> ou <b>AFTER</b>, indicando se a trigger será executada antes ou depois do comando DML;</p></li>
  <li><p><b>OPERACAO: </b>É o comando DML, sendo ou <b>INSERT</b>, ou <b>DELETE</b> ou <b>UPDATE</b>.</p></li>
</ul>

<p align="justify">
  Triggers recebem dados que são oriundos de antes ou depois de um comando DML. A depender do comando, o dado em si pode ou não existir antes ou depois do comando DML (ou seja, BEFORE ou AFTER). Por exemplo, um DML de INSERT não haverá dados antes (BEFORE), mas haverá depois do insert (AFTER). Estes dados são definidos dentro dos comandos da trigger, após FOR EACH ROW, com os argumentos NEW e OLD, para os dados novos e antigos, respectivamente:
</p>

<table align="center"><thead><tr><th>DML</th><th>OLD</th><th>NEW</th><th>EXEMPLO</th><th>USO</th></tr></thead><tbody><tr><td>INSERT</td><td>não existe</td><td>existe</td><td>NEW.nome_col</td><td>Pega um novo valor inserido em uma tabela.</td></tr><tr><td>DELETE</td><td>existe</td><td>não existe</td><td>OLD.nome_col</td><td>Pega um valor removido de uma tabela.</td></tr><tr><td>UPDATE</td><td>existe</td><td>existe</td><td>OLD.nome_col | NEW.nome_col</td><td>Pega o valor anterior (OLD) ou posterior (NEW) de um update.</td></tr></tbody></table>

<p align="justify">Para checar quais as triggers existem, usar o comando:</p>

```sql
SHOW triggers;
```

<p align="justify">Triggers possuem vantagens e desvantagens:</p>

<p align="justify">Vantagens:</p>

<ul>
	<li><p align="justify"><b>1º: </b>Triggers podem ser úteis para inspecionar as alterações de dados nas tabelas;</p></li>
	<li><p align="justify"><b>2º: </b>Oferecem uma maneira alternativa de executar tarefas agendadas. Não precisamos esperar a execução dos eventos agendados porque as triggers são invocadas automaticamente antes ou depois de uma alteração ser feita nos dados de uma tabela.</p></li>
</ul>

<p align="justify">Desvantagens:</p>

<ul>
	<li><p align="justify"><b>1º: </b>Podem aumentar a sobrecarga do banco de dados, principalmente triggers atreladas a INSERTS em aplicações de alta transação, ou triggers muito complexas;</p></li>
	<li><p align="justify"><b>2º: </b>Alterações na tabela alvo da Trigger podem quebrar não somente a trigger como a aplicação. Como, por exemplo, a remoção de uma coluna na tabela alvo de uma trigger de backup AFTER INSERT pode quebrar a trigger, que tentará fazer  INSERT  de mais valores do que agora existem. O que faria com que o próprio INSERT na tabela alvo não ocorra, quebrando o banco de dados. Deve-se ter muito cuidado para atualizar as triggers juntamente com a lógica do DB.</p></li>
</ul>


<p align="justify"><b>EXEMPLO 1: </b>Usando o DB 'lojinha', criemos uma tabela chamada 'pedidosNovos' que receberá através de trigger os novos pedidos que forem inseridos na tabela 'pedidos' original. Adicionalmente, a nova tabela conterá a data e hora que os registros foram inseridos nesta nova tabela:</p>

```sql
-- criando a tabela 'pedidosNovos'
create table pedidosNovos (id int primary key auto_increment, 
                           comprador text,
                           bairro text,
                           entregaId smallint,
                           momento datetime);

-- criando a trigger 'novosPedidos'
create trigger novosPedidos after insert
on pedidos 
for each row
	insert into pedidosNovos values
	(new.id, new.comprador, new.bairro, new.entregaId, now())
;

-- inserindo dados de pedidos na tabela de 'pedidos'
insert into pedidos values
(id, 'Rogério', 'Ipanema', 2),
(id, 'Carinny', 'Leblon', 2),
(id, 'Vera', 'Urca', 2),
(id, 'Xico', 'Morro do Dendê', 1)
;

-- retornando a nova tabela 'pedidosNovos'
select * from pedidosNovos;
```

<table align="center"><thead><tr><th>id</th><th>comprador</th><th>bairro</th><th>entregaId</th><th>momento</th></tr></thead><tbody><tr><td>26</td><td>Rogério</td><td>Ipanema</td><td>2</td><td>2024-01-08 00:07:38</td></tr><tr><td>27</td><td>Carinny</td><td>Leblon</td><td>2</td><td>2024-01-08 00:07:38</td></tr><tr><td>28</td><td>Vera</td><td>Urca</td><td>2</td><td>2024-01-08 00:07:38</td></tr><tr><td>29</td><td>Xico</td><td>Morro do Dendê</td><td>1</td><td>2024-01-08 00:07:38</td></tr></tbody></table>

<p align="justify"><b>EXEMPLO 2: </b>Usando o DB 'lojinha', criemos uma tabela chamada 'produtosBK' que receberá através de trigger produtos descadastrados (deletados) da tabela principal 'produtos':</p>

```sql
-- DDL
CREATE TABLE IF NOT EXISTS produtosBK (
	  id int
	, produto text
	, tipo text
	, preco float
	, tipoAcao text
	, momento timestamp
);

-- trigger
CREATE TRIGGER produtosBK_trigger
BEFORE DELETE ON produtos
FOR EACH ROW   
	INSERT INTO produtosBK values
    (OLD.id, OLD.produto, OLD.tipo, OLD.preco, 'DELETED', now());

-- delete
DELETE FROM produtos 
WHERE tipo = 'frios';
```

<p align="justify">Na tabela alvo 'produtos':</p>

<table align="center"><thead><tr><th>id</th><th>produto</th><th>tipo</th><th>preco</th></tr></thead><tbody><tr><td>1</td><td>pao</td><td>padaria</td><td>1,2</td></tr><tr><td>2</td><td>leite</td><td>lacteos</td><td>1,4</td></tr><tr><td>3</td><td>manteiga</td><td>lacteos</td><td>1,35</td></tr><tr><td>4</td><td>ovo</td><td>animais</td><td>1,1</td></tr><tr><td>7</td><td>café</td><td>bebidas</td><td>1,3</td></tr><tr><td>9</td><td>suco</td><td>bebidas</td><td>0,8</td></tr><tr><td>10</td><td>banana</td><td>frutas</td><td>0,75</td></tr><tr><td>11</td><td>maça</td><td>frutas</td><td>0,55</td></tr></tbody></table>

<p align="justify">Na tabela 'produtosBK':</p>

<table align="center"><thead><tr><th>id</th><th>produto</th><th>tipo</th><th>preco</th><th>tipoAcao</th><th>momento</th></tr></thead><tbody><tr><td>5</td><td>presunto</td><td>frios</td><td>2,4</td><td>DELETED</td><td>2024-01-15 12:58:26</td></tr><tr><td>6</td><td>queijo</td><td>frios</td><td>1,8</td><td>DELETED</td><td>2024-01-15 12:58:26</td></tr><tr><td>8</td><td>mortadela</td><td>frios</td><td>1,2</td><td>DELETED</td><td>2024-01-15 12:58:26</td></tr></tbody></table>

