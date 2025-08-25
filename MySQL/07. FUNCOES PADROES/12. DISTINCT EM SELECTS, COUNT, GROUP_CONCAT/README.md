<h2>1. DISTINCT</h2>

<p align="justify">
  Comando que retorna registros dstintos. Usado principalmente em:
</p>

<ul>
  <li><p align="justify"><b>SELECT: </b>No SELECT, retorna os registros distintos de cada linha da tabela. Se todas as linhas forem distintas, irá retornar todos todas as linhas. Quando, por exemplo, há na consulta a chamada de chaves primárias (IDs). Pois, todos são diferentes. A sintaxe básica:</p></li>

```sql
SELECT DISTINCT cols
FROM tabela;
```
  
  <li><p align="justify"><b>COUNT: </b>Permite retornar a contagem distinta dos registros de uma coluna. Sua sintaxe básica:</p></li>

```sql
SELECT
  col1
, COUNT(DISTINCT col2)
FROM tabela
GROUP BY col1;
```

  <li><p><b>GROUP_CONCAT: </b>Retorna a contatenação das strings distintas de uma coluna.</p></li>

```sql
SELECT
  col1
, GROUP_CONCAT(DISTINCT col2)
FROM tabela
GROUP BY col1;
```

</ul>

<p align="justify">Usando o <b>database lojinha</b>, vejamos os exemplos seguindo a <b>VIEW lojaVenda</b> abaixo, contendo os pedidos, seus itens comprados, quem comprou e onde mora, carro da entrega, tipo do produto e preço:</p>

```sql
create view lojaVendas as (
select
  pe.`id` as `pedido`
, ic.`id` as `itemId`
, pe.`comprador`
, pe.`bairro`
, e.`carro`
, pr.`produto`
, pr.`tipo`
, pr.`preco`
from itenscarrinhos ic
	left join pedidos pe 	on ic.`pedidoId` = pe.`id`
	left join produtos pr 	on ic.`produtoId` = pr.`id`
	left join entregas e	on e.`id` = pe.`entregaId`
order by pedido);
```

<table align="center"><thead><tr><th>pedido</th><th>itemId</th><th>comprador</th><th>bairro</th><th>carro</th><th>produto</th><th>tipo</th><th>preco</th></tr></thead><tbody><tr><td>1</td><td>1</td><td>Ana</td><td>Barra</td><td>furgão</td><td>pao</td><td>padaria</td><td>1,2</td></tr><tr><td>1</td><td>2</td><td>Ana</td><td>Barra</td><td>furgão</td><td>leite</td><td>lacteos</td><td>1,4</td></tr><tr><td>1</td><td>3</td><td>Ana</td><td>Barra</td><td>furgão</td><td>ovo</td><td>animais</td><td>1,1</td></tr><tr><td>1</td><td>4</td><td>Ana</td><td>Barra</td><td>furgão</td><td>presunto</td><td>frios</td><td>2,4</td></tr><tr><td>1</td><td>5</td><td>Ana</td><td>Barra</td><td>furgão</td><td>café</td><td>bebidas</td><td>1,3</td></tr><tr><td>2</td><td>6</td><td>Anderson</td><td>Recreio</td><td>furgão</td><td>ovo</td><td>animais</td><td>1,1</td></tr><tr><td>2</td><td>7</td><td>Anderson</td><td>Recreio</td><td>furgão</td><td>presunto</td><td>frios</td><td>2,4</td></tr><tr><td>2</td><td>8</td><td>Anderson</td><td>Recreio</td><td>furgão</td><td>banana</td><td>frutas</td><td>0,75</td></tr><tr><td>2</td><td>9</td><td>Anderson</td><td>Recreio</td><td>furgão</td><td>maça</td><td>frutas</td><td>0,55</td></tr><tr><td>3</td><td>10</td><td>Beto</td><td>Barra</td><td>furgão</td><td>pao</td><td>padaria</td><td>1,2</td></tr><tr><td>3</td><td>11</td><td>Beto</td><td>Barra</td><td>furgão</td><td>leite</td><td>lacteos</td><td>1,4</td></tr><tr><td>3</td><td>12</td><td>Beto</td><td>Barra</td><td>furgão</td><td>manteiga</td><td>lacteos</td><td>1,35</td></tr><tr><td>3</td><td>13</td><td>Beto</td><td>Barra</td><td>furgão</td><td>queijo</td><td>frios</td><td>1,8</td></tr><tr><td>3</td><td>14</td><td>Beto</td><td>Barra</td><td>furgão</td><td>maça</td><td>frutas</td><td>0,55</td></tr><tr><td>4</td><td>15</td><td>Cláudio</td><td>Recreio</td><td>furgão</td><td>leite</td><td>lacteos</td><td>1,4</td></tr><tr><td>4</td><td>16</td><td>Cláudio</td><td>Recreio</td><td>furgão</td><td>manteiga</td><td>lacteos</td><td>1,35</td></tr><tr><td>4</td><td>17</td><td>Cláudio</td><td>Recreio</td><td>furgão</td><td>ovo</td><td>animais</td><td>1,1</td></tr><tr><td>5</td><td>18</td><td>Cláudia</td><td>Copacabana</td><td>moto</td><td>queijo</td><td>frios</td><td>1,8</td></tr><tr><td>5</td><td>19</td><td>Cláudia</td><td>Copacabana</td><td>moto</td><td>café</td><td>bebidas</td><td>1,3</td></tr><tr><td>5</td><td>20</td><td>Cláudia</td><td>Copacabana</td><td>moto</td><td>mortadela</td><td>frios</td><td>1,2</td></tr><tr><td>6</td><td>21</td><td>Francisco</td><td>Barra</td><td>furgão</td><td>pao</td><td>padaria</td><td>1,2</td></tr><tr><td>6</td><td>22</td><td>Francisco</td><td>Barra</td><td>furgão</td><td>café</td><td>bebidas</td><td>1,3</td></tr><tr><td>6</td><td>23</td><td>Francisco</td><td>Barra</td><td>furgão</td><td>banana</td><td>frutas</td><td>0,75</td></tr><tr><td>6</td><td>24</td><td>Francisco</td><td>Barra</td><td>furgão</td><td>maça</td><td>frutas</td><td>0,55</td></tr><tr><td>7</td><td>25</td><td>Fernanda</td><td>Barra</td><td>furgão</td><td>pao</td><td>padaria</td><td>1,2</td></tr><tr><td>7</td><td>26</td><td>Fernanda</td><td>Barra</td><td>furgão</td><td>presunto</td><td>frios</td><td>2,4</td></tr><tr><td>7</td><td>27</td><td>Fernanda</td><td>Barra</td><td>furgão</td><td>queijo</td><td>frios</td><td>1,8</td></tr><tr><td>8</td><td>28</td><td>Fabrício</td><td>Botafogo</td><td>moto</td><td>pao</td><td>padaria</td><td>1,2</td></tr><tr><td>8</td><td>29</td><td>Fabrício</td><td>Botafogo</td><td>moto</td><td>presunto</td><td>frios</td><td>2,4</td></tr><tr><td>8</td><td>30</td><td>Fabrício</td><td>Botafogo</td><td>moto</td><td>queijo</td><td>frios</td><td>1,8</td></tr><tr><td>9</td><td>31</td><td>Mônica</td><td>Recreio</td><td>furgão</td><td>pao</td><td>padaria</td><td>1,2</td></tr><tr><td>9</td><td>32</td><td>Mônica</td><td>Recreio</td><td>furgão</td><td>leite</td><td>lacteos</td><td>1,4</td></tr><tr><td>9</td><td>33</td><td>Mônica</td><td>Recreio</td><td>furgão</td><td>ovo</td><td>animais</td><td>1,1</td></tr><tr><td>9</td><td>34</td><td>Mônica</td><td>Recreio</td><td>furgão</td><td>presunto</td><td>frios</td><td>2,4</td></tr><tr><td>9</td><td>35</td><td>Mônica</td><td>Recreio</td><td>furgão</td><td>queijo</td><td>frios</td><td>1,8</td></tr><tr><td>10</td><td>36</td><td>Eduardo</td><td>Centro</td><td>moto</td><td>pao</td><td>padaria</td><td>1,2</td></tr><tr><td>10</td><td>37</td><td>Eduardo</td><td>Centro</td><td>moto</td><td>manteiga</td><td>lacteos</td><td>1,35</td></tr><tr><td>10</td><td>38</td><td>Eduardo</td><td>Centro</td><td>moto</td><td>café</td><td>bebidas</td><td>1,3</td></tr></tbody></table>

<h3>2. NO SELECT</h3>

<p align="justify"><b>EXEMPLO: </b>Caso fosse inserido DISTINCT na VIEW acima como está, retornaria a própria VIEW, todas as linhas. Pois todas as linhas são distintas devido principalmente ao campo <b>itemId</b> o qual nenhum registro é diferente. Mas, caso quisessemos retornar <b>os bairros distintos</b> dos compradores:</p>

```sql
select 
distinct bairro
from lojaVendas;
```

<table align="center"><thead><tr><th>bairro</th></tr></thead><tbody><tr><td>Barra</td></tr><tr><td>Recreio</td></tr><tr><td>Copacabana</td></tr><tr><td>Botafogo</td></tr><tr><td>Centro</td></tr></tbody></table>

<h3>3. EM <i>COUNT</i> E <i>GROUP_CONCAT</i></h3>

<p align="justify"><b>EXEMPLO: </b>Caso tivessemos a tabela abaixo:</p>

```sql
select carro, bairro, produto
from lojaVendas;
```

<table align="center"><thead><tr><th>carro</th><th>bairro</th><th>produto</th></tr></thead><tbody><tr><td>furgão</td><td>Barra</td><td>pao</td></tr><tr><td>furgão</td><td>Barra</td><td>leite</td></tr><tr><td>furgão</td><td>Barra</td><td>ovo</td></tr><tr><td>furgão</td><td>Barra</td><td>presunto</td></tr><tr><td>furgão</td><td>Barra</td><td>café</td></tr><tr><td>furgão</td><td>Recreio</td><td>ovo</td></tr><tr><td>furgão</td><td>Recreio</td><td>presunto</td></tr><tr><td>furgão</td><td>Recreio</td><td>banana</td></tr><tr><td>furgão</td><td>Recreio</td><td>maça</td></tr><tr><td>furgão</td><td>Barra</td><td>pao</td></tr><tr><td>furgão</td><td>Barra</td><td>leite</td></tr><tr><td>furgão</td><td>Barra</td><td>manteiga</td></tr><tr><td>furgão</td><td>Barra</td><td>queijo</td></tr><tr><td>furgão</td><td>Barra</td><td>maça</td></tr><tr><td>furgão</td><td>Recreio</td><td>leite</td></tr><tr><td>furgão</td><td>Recreio</td><td>manteiga</td></tr><tr><td>furgão</td><td>Recreio</td><td>ovo</td></tr><tr><td>moto</td><td>Copacabana</td><td>queijo</td></tr><tr><td>moto</td><td>Copacabana</td><td>café</td></tr><tr><td>moto</td><td>Copacabana</td><td>mortadela</td></tr><tr><td>furgão</td><td>Barra</td><td>pao</td></tr><tr><td>furgão</td><td>Barra</td><td>café</td></tr><tr><td>furgão</td><td>Barra</td><td>banana</td></tr><tr><td>furgão</td><td>Barra</td><td>maça</td></tr><tr><td>furgão</td><td>Barra</td><td>pao</td></tr><tr><td>furgão</td><td>Barra</td><td>presunto</td></tr><tr><td>furgão</td><td>Barra</td><td>queijo</td></tr><tr><td>moto</td><td>Botafogo</td><td>pao</td></tr><tr><td>moto</td><td>Botafogo</td><td>presunto</td></tr><tr><td>moto</td><td>Botafogo</td><td>queijo</td></tr><tr><td>furgão</td><td>Recreio</td><td>pao</td></tr><tr><td>furgão</td><td>Recreio</td><td>leite</td></tr><tr><td>furgão</td><td>Recreio</td><td>ovo</td></tr><tr><td>furgão</td><td>Recreio</td><td>presunto</td></tr><tr><td>furgão</td><td>Recreio</td><td>queijo</td></tr><tr><td>moto</td><td>Centro</td><td>pao</td></tr><tr><td>moto</td><td>Centro</td><td>manteiga</td></tr><tr><td>moto</td><td>Centro</td><td>café</td></tr></tbody></table>

<p align="justify">Nela temos qual produto será entregue e em qual bairro. Note que há várias repetições. Pois, podem ser entregue o mesmo produto em pedidos diferentes ou o mesmo bbairro em pedidos diferentes. Caso quisessemos ver, para cada um dos carros: os bairros distintos de entrega (1), os produtos distintos de entrega (2), a contagem de produtos distintos (3), a contagem de produtos (4):<b></b>
</p>

```sql
select 
  `carro`
, group_concat(distinct `bairro` separator ', ') as `bairrosDistintos (1)`
, group_concat(distinct `produto` separator ', ') as `produtosDistintos (2)`
, count(distinct `produto`) as `count de produtos únicos (3)`
, count(`produto`) as `count de produtos (4)`
from lojaVendas
group by `carro`
;
```

<table align="center"><thead><tr><th>carro</th><th>bairrosDistintos (1)</th><th>produtosDistintos (2)</th><th>count de produtos únicos (3)</th><th>count de produtos (4)</th></tr></thead><tbody><tr><td>furgão</td><td>Barra, Recreio</td><td>banana, café, leite, maça, manteiga, ovo, pao, presunto, queijo</td><td>9</td><td>29</td></tr><tr><td>moto</td><td>Botafogo, Centro, Copacabana</td><td>café, manteiga, mortadela, pao, presunto, queijo</td><td>6</td><td>9</td></tr></tbody></table>

<p align="justify">
	Veja que em termos únicos, o furgão entrega Na Barra e no Recreio. Caso não houvesse DISTINCT, haveria múltiplos "Barra" e "Recreio" como string na 2ª coluna. Também, a quantidade contada na 4ª coluna é a quantidade única de produtos entregues. Na Barra e Recreio, foram entregues 9 produtos ("banana, café, leite, maça, manteiga, ovo, pao, presunto, queijo") enquanto nos demais bairros foram entregues 6 ("café, manteiga, mortadela, pao, presunto, queijo"). Contudo, a última coluna, sem contagem distinta, retornou a contagem de produtos, apenas. Ou seja, na Barra e Recreio há 29 produtos entregues enquanto, nos demais bairros, 9 produtos.
</p>

<h3>4. EXTRA: GROUP_CONCAT E JOINS</h3>

<p align="justify">
	Para concatenações de textos distintos, GROUP_CONCAT funciona melhor que funções JSON que, a princípio podem fazer a mesma coisa. Como JSON_ARRAYAGG. Mas, cada um tem suas limitações:
</p>

<table align="center"><thead><tr><th>FUNÇÃO</th><th>FUNÇÃO</th><th>PRÓS</th><th>CONTRAS</th></tr></thead><tbody><tr><td>GROUP_CONCAT</td><td>Concatena registros em uma string.</td><td>Permite DISTINCT.</td><td>Não permite PARTITION BY (usar GROUP BY).</td></tr><tr><td>JSON_ARRAYAGG</td><td>Transforma registros em um array, separando-os como elementos.</td><td>Não permite DISTINCT.</td><td>permite PARTITION BY.</td></tr></tbody></table>

<p align="justify">
	Enquanto JSON_ARRAYAGG pode ser melhor para situações de comparações entre conjuntos (se um elemento ou array está contido em outro, para filtragem, etc.), a função GROUP_CONCAT costuma ser melhor para expor informações. Isto porque permite concatenar STRINGS únicas, evitando repetição. O que não é possível com JSON_ARRAYAGG. Contudo, como GROUP_CONCAT não aceita particionamento, sendo possível apenas agrupar com GROUP BY, caso se quisesse replicar a lógica do particionamento, não agregando registros, deve-se operar com subqueries. Como <b>exemplo</b>, imagine que quisessemos da VIEW pedido, tipo e nome do produto. Contudo, que os produtos fossem agrupados por pedido, mas sem agregação:
</p>

```sql
select 
  a.`pedido`, a.`tipo`, a.`produto`, b.`produtos`
from 

(
select *
from lojaVendas
) as a

join 

(
select 
`pedido`
, group_concat(distinct `produto` separator ', ') as `produtos`
from lojaVendas
group by `pedido`
) as b

on a.`pedido` = b.`pedido`;
```

<table align="center"><thead><tr><th>pedido</th><th>tipo</th><th>produto</th><th>produtos</th></tr></thead><tbody><tr><td>1</td><td>padaria</td><td>pao</td><td>café, leite, ovo, pao, presunto</td></tr><tr><td>1</td><td>lacteos</td><td>leite</td><td>café, leite, ovo, pao, presunto</td></tr><tr><td>1</td><td>animais</td><td>ovo</td><td>café, leite, ovo, pao, presunto</td></tr><tr><td>1</td><td>frios</td><td>presunto</td><td>café, leite, ovo, pao, presunto</td></tr><tr><td>1</td><td>bebidas</td><td>café</td><td>café, leite, ovo, pao, presunto</td></tr><tr><td>2</td><td>animais</td><td>ovo</td><td>banana, maça, ovo, presunto</td></tr><tr><td>2</td><td>frios</td><td>presunto</td><td>banana, maça, ovo, presunto</td></tr><tr><td>2</td><td>frutas</td><td>banana</td><td>banana, maça, ovo, presunto</td></tr><tr><td>2</td><td>frutas</td><td>maça</td><td>banana, maça, ovo, presunto</td></tr><tr><td>3</td><td>padaria</td><td>pao</td><td>leite, maça, manteiga, pao, queijo</td></tr><tr><td>3</td><td>lacteos</td><td>leite</td><td>leite, maça, manteiga, pao, queijo</td></tr><tr><td>3</td><td>lacteos</td><td>manteiga</td><td>leite, maça, manteiga, pao, queijo</td></tr><tr><td>3</td><td>frios</td><td>queijo</td><td>leite, maça, manteiga, pao, queijo</td></tr><tr><td>3</td><td>frutas</td><td>maça</td><td>leite, maça, manteiga, pao, queijo</td></tr><tr><td>4</td><td>lacteos</td><td>leite</td><td>leite, manteiga, ovo</td></tr><tr><td>4</td><td>lacteos</td><td>manteiga</td><td>leite, manteiga, ovo</td></tr><tr><td>4</td><td>animais</td><td>ovo</td><td>leite, manteiga, ovo</td></tr><tr><td>5</td><td>frios</td><td>queijo</td><td>café, mortadela, queijo</td></tr><tr><td>5</td><td>bebidas</td><td>café</td><td>café, mortadela, queijo</td></tr><tr><td>5</td><td>frios</td><td>mortadela</td><td>café, mortadela, queijo</td></tr><tr><td>6</td><td>padaria</td><td>pao</td><td>banana, café, maça, pao</td></tr><tr><td>6</td><td>bebidas</td><td>café</td><td>banana, café, maça, pao</td></tr><tr><td>6</td><td>frutas</td><td>banana</td><td>banana, café, maça, pao</td></tr><tr><td>6</td><td>frutas</td><td>maça</td><td>banana, café, maça, pao</td></tr><tr><td>7</td><td>padaria</td><td>pao</td><td>pao, presunto, queijo</td></tr><tr><td>7</td><td>frios</td><td>presunto</td><td>pao, presunto, queijo</td></tr><tr><td>7</td><td>frios</td><td>queijo</td><td>pao, presunto, queijo</td></tr><tr><td>8</td><td>padaria</td><td>pao</td><td>pao, presunto, queijo</td></tr><tr><td>8</td><td>frios</td><td>presunto</td><td>pao, presunto, queijo</td></tr><tr><td>8</td><td>frios</td><td>queijo</td><td>pao, presunto, queijo</td></tr><tr><td>9</td><td>padaria</td><td>pao</td><td>leite, ovo, pao, presunto, queijo</td></tr><tr><td>9</td><td>lacteos</td><td>leite</td><td>leite, ovo, pao, presunto, queijo</td></tr><tr><td>9</td><td>animais</td><td>ovo</td><td>leite, ovo, pao, presunto, queijo</td></tr><tr><td>9</td><td>frios</td><td>presunto</td><td>leite, ovo, pao, presunto, queijo</td></tr><tr><td>9</td><td>frios</td><td>queijo</td><td>leite, ovo, pao, presunto, queijo</td></tr><tr><td>10</td><td>padaria</td><td>pao</td><td>café, manteiga, pao</td></tr><tr><td>10</td><td>lacteos</td><td>manteiga</td><td>café, manteiga, pao</td></tr><tr><td>10</td><td>bebidas</td><td>café</td><td>café, manteiga, pao</td></tr></tbody></table>

<p align="justify">
	Basta fazer duas queries, uma para a consulta e outra para a agregação com GROUP_CONCAT, e uní-las via JOIN. Dependendo do contexto é um recurso muito válido de uso que não seria possível com JSON_ARRAYAGG.
</p>
