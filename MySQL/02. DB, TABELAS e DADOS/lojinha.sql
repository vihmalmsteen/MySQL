-- DDL
create database if not exists lojinha;
use lojinha;
set foreign_key_checks = 0;

create table if not exists produtos(
id 		int auto_increment primary key,
produto text,
tipo	text,
preco 	decimal(10,2)
);

create table if not exists pedidos(
id 				int auto_increment primary key,
comprador		text,
bairro			text,
entregaId		int,
foreign key (entregaId) references entregas(id)
);

create table if not exists itensCarrinhos(
id 			int auto_increment primary key,
produtoId 	int,
qtde 		int,
pedidoId	int,
foreign key (produtoId) references produtos(id),
foreign key (pedidoId) references pedidos(id)
);

create table if not exists entregas (
id int auto_increment primary key,
carro text
);

insert into produtos (produto, tipo, preco) 
values
("pao", "padaria", 1.20),("leite", "lacteos", 1.40),
("manteiga", "lacteos", 1.35),("ovo", "animais", 1.10),("presunto", "frios", 2.40),
("queijo", "frios", 1.80),("café", "bebidas", 1.30),("mortadela", "frios", 1.20),
("suco", "bebidas", 0.80),("banana", "frutas", 0.75),("maça", "frutas", 0.55)
;

insert into itenscarrinhos (produtoId, qtde, pedidoId)
values
(1, 2, 1),(2, 1, 1),(4, 1, 1),(5, 1, 1),(7, 3, 1),(4, 3, 2),
(5, 3, 2),(10, 3, 2),(11, 1, 2),(1, 3, 3),(2, 1, 3),(3, 2, 3),
(6, 1, 3),(11, 1, 3),(2, 3, 4),(3, 3, 4),(4, 3, 4),(6, 3, 5),
(7, 3, 5),(8, 3, 5),(1, 1, 6),(7, 3, 6),(10, 1, 6),(11, 2, 6),
(1, 1, 7),(5, 2, 7),(6, 3, 7),(1, 1, 8),(5, 1, 8),(6, 2, 8),
(1, 3, 9),(2, 3, 9),(4, 3, 9),(5, 1, 9),(6, 3, 9),(1,2,10),(3,1,10),(7,3,10)
;

insert into pedidos (comprador, bairro, entregaId)
values
("Ana", "Barra", 1),("Anderson", "Recreio", 1),("Beto", "Barra", 1),("Cláudio", "Recreio", 1),
("Cláudia", "Copacabana", 2),("Francisco", "Barra", 1),("Fernanda", "Barra", 1),
("Fabrício", "Botafogo", 2),("Mônica", "Recreio", 1),("Eduardo", "Centro", 2)
;

insert into entregas (carro)
values
('furgão'),('moto');

set foreign_key_checks = 1;




-- VIEW lojaVendas
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




-- checks
select * from itenscarrinhos;
/*
+----+-----------+------+----------+
| id | produtoId | qtde | pedidoId |
+----+-----------+------+----------+
| 1  | 1         | 2    | 1        |
| 2  | 2         | 1    | 1        |
| 3  | 4         | 1    | 1        |
| 4  | 5         | 1    | 1        |
| 5  | 7         | 3    | 1        |
| 6  | 4         | 3    | 2        |
| 7  | 5         | 3    | 2        |
| 8  | 10        | 3    | 2        |
| 9  | 11        | 1    | 2        |
| 10 | 1         | 3    | 3        |
| 11 | 2         | 1    | 3        |
| 12 | 3         | 2    | 3        |
| 13 | 6         | 1    | 3        |
| 14 | 11        | 1    | 3        |
| 15 | 2         | 3    | 4        |
| 16 | 3         | 3    | 4        |
| 17 | 4         | 3    | 4        |
| 18 | 6         | 3    | 5        |
| 19 | 7         | 3    | 5        |
| 20 | 8         | 3    | 5        |
| 21 | 1         | 1    | 6        |
| 22 | 7         | 3    | 6        |
| 23 | 10        | 1    | 6        |
| 24 | 11        | 2    | 6        |
| 25 | 1         | 1    | 7        |
| 26 | 5         | 2    | 7        |
| 27 | 6         | 3    | 7        |
| 28 | 1         | 1    | 8        |
| 29 | 5         | 1    | 8        |
| 30 | 6         | 2    | 8        |
| 31 | 1         | 3    | 9        |
| 32 | 2         | 3    | 9        |
| 33 | 4         | 3    | 9        |
| 34 | 5         | 1    | 9        |
| 35 | 6         | 3    | 9        |
| 36 | 1         | 2    | 10       |
| 37 | 3         | 1    | 10       |
| 38 | 7         | 3    | 10       |
+----+-----------+------+----------+
*/


select * from pedidos;
/*
+----+-----------+------------+-----------+
| id | comprador | bairro     | entregaId |
+----+-----------+------------+-----------+
| 1  | Ana       | Barra      | 1         |
| 2  | Anderson  | Recreio    | 1         |
| 3  | Beto      | Barra      | 1         |
| 4  | Cláudio   | Recreio    | 1         |
| 5  | Cláudia   | Copacabana | 2         |
| 6  | Francisco | Barra      | 1         |
| 7  | Fernanda  | Barra      | 1         |
| 8  | Fabrício  | Botafogo   | 2         |
| 9  | Mônica    | Recreio    | 1         |
| 10 | Eduardo   | Centro     | 2         |
+----+-----------+------------+-----------+
*/


select * from produtos;
/*
+----+-----------+---------+-------+
| id | produto   | tipo    | preco |
+----+-----------+---------+-------+
| 1  | pao       | padaria | 1,2   |
| 2  | leite     | lacteos | 1,4   |
| 3  | manteiga  | lacteos | 1,35  |
| 4  | ovo       | animais | 1,1   |
| 5  | presunto  | frios   | 2,4   |
| 6  | queijo    | frios   | 1,8   |
| 7  | café      | bebidas | 1,3   |
| 8  | mortadela | frios   | 1,2   |
| 9  | suco      | bebidas | 0,8   |
| 10 | banana    | frutas  | 0,75  |
| 11 | maça      | frutas  | 0,55  |
+----+-----------+---------+-------+
*/


select * from entregas;
/*
+----+--------+
| id | carro  |
+----+--------+
| 1  | furgão |
| 2  | moto   |
+----+--------+
*/


select * from lojaVendas;
/*
+--------+--------+-----------+------------+--------+-----------+---------+-------+
| pedido | itemId | comprador | bairro     | carro  | produto   | tipo    | preco |
+--------+--------+-----------+------------+--------+-----------+---------+-------+
| 1      | 1      | Ana       | Barra      | furgão | pao       | padaria | 1,2   |
| 1      | 2      | Ana       | Barra      | furgão | leite     | lacteos | 1,4   |
| 1      | 3      | Ana       | Barra      | furgão | ovo       | animais | 1,1   |
| 1      | 4      | Ana       | Barra      | furgão | presunto  | frios   | 2,4   |
| 1      | 5      | Ana       | Barra      | furgão | café      | bebidas | 1,3   |
| 2      | 6      | Anderson  | Recreio    | furgão | ovo       | animais | 1,1   |
| 2      | 7      | Anderson  | Recreio    | furgão | presunto  | frios   | 2,4   |
| 2      | 8      | Anderson  | Recreio    | furgão | banana    | frutas  | 0,75  |
| 2      | 9      | Anderson  | Recreio    | furgão | maça      | frutas  | 0,55  |
| 3      | 10     | Beto      | Barra      | furgão | pao       | padaria | 1,2   |
| 3      | 11     | Beto      | Barra      | furgão | leite     | lacteos | 1,4   |
| 3      | 12     | Beto      | Barra      | furgão | manteiga  | lacteos | 1,35  |
| 3      | 13     | Beto      | Barra      | furgão | queijo    | frios   | 1,8   |
| 3      | 14     | Beto      | Barra      | furgão | maça      | frutas  | 0,55  |
| 4      | 15     | Cláudio   | Recreio    | furgão | leite     | lacteos | 1,4   |
| 4      | 16     | Cláudio   | Recreio    | furgão | manteiga  | lacteos | 1,35  |
| 4      | 17     | Cláudio   | Recreio    | furgão | ovo       | animais | 1,1   |
| 5      | 18     | Cláudia   | Copacabana | moto   | queijo    | frios   | 1,8   |
| 5      | 19     | Cláudia   | Copacabana | moto   | café      | bebidas | 1,3   |
| 5      | 20     | Cláudia   | Copacabana | moto   | mortadela | frios   | 1,2   |
| 6      | 21     | Francisco | Barra      | furgão | pao       | padaria | 1,2   |
| 6      | 22     | Francisco | Barra      | furgão | café      | bebidas | 1,3   |
| 6      | 23     | Francisco | Barra      | furgão | banana    | frutas  | 0,75  |
| 6      | 24     | Francisco | Barra      | furgão | maça      | frutas  | 0,55  |
| 7      | 25     | Fernanda  | Barra      | furgão | pao       | padaria | 1,2   |
| 7      | 26     | Fernanda  | Barra      | furgão | presunto  | frios   | 2,4   |
| 7      | 27     | Fernanda  | Barra      | furgão | queijo    | frios   | 1,8   |
| 8      | 28     | Fabrício  | Botafogo   | moto   | pao       | padaria | 1,2   |
| 8      | 29     | Fabrício  | Botafogo   | moto   | presunto  | frios   | 2,4   |
| 8      | 30     | Fabrício  | Botafogo   | moto   | queijo    | frios   | 1,8   |
| 9      | 31     | Mônica    | Recreio    | furgão | pao       | padaria | 1,2   |
| 9      | 32     | Mônica    | Recreio    | furgão | leite     | lacteos | 1,4   |
| 9      | 33     | Mônica    | Recreio    | furgão | ovo       | animais | 1,1   |
| 9      | 34     | Mônica    | Recreio    | furgão | presunto  | frios   | 2,4   |
| 9      | 35     | Mônica    | Recreio    | furgão | queijo    | frios   | 1,8   |
| 10     | 36     | Eduardo   | Centro     | moto   | pao       | padaria | 1,2   |
| 10     | 37     | Eduardo   | Centro     | moto   | manteiga  | lacteos | 1,35  |
| 10     | 38     | Eduardo   | Centro     | moto   | café      | bebidas | 1,3   |
+--------+--------+-----------+------------+--------+-----------+---------+-------+
*/
