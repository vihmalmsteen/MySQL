# 1. CRIANDO TABELA DE CUPONS E KITS VÁLIDOS PARA CADA CUPOM:
create table cupons (ID int NOT NULL AUTO_INCREMENT,
                     TIPO varchar(50),
                     desconto float(10,2),
                     kit text,
                     primary key (ID));

insert into cupons values
(null, "percentual", 0.10, "[1, 3]"),
(null, "integral", 1.00, "[7]"),
(null, "valor", 120, "[9, 11]");

select * from cupons;


# 2. CRIANDO TABELA DE PILOTOS E SEUS KITS:
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

select * from pilotos;


select p.* from pilotos p
  where json_overlaps(
                      # 1º argumento
                      (json_array(p.kit_ID))                       
                      ,
                      # 2º argumento
                      (select 
                        json_arrayagg(JTc.JS_cupom)
                          from cupons c
                            join
                        json_table(c.kit, '$[*]' columns(JS_cupom int path '$')) as JTc)
                     );
					 
# json_overlaps(array_1, array_2): dentro de where, é um teste se subconjunto do 1º array está contido no conjunto do 2º array.


# NOTA 1: PRIMEIRO ARGUMENTO DE JSON_OVERLAPS -> json_array

select json_array(p.kit_ID) as row_array from pilotos p;

# Deve ser inserido cada elemento dentro de array (cada ID do kit nas linhas se tornam um array)



# NOTA 2: SEGUNDO ARGUMENTO DE JSON_OVERLAPS -> json_arrayagg

select json_arrayagg(JTc.JS_cupom) as allcupons_array
  from cupons c
     join
  json_table(c.kit, '$[*]' columns(JS_cupom int path '$')) as JTc;
  
# Necessário seu uso. Pois, deve ser um array contendo todos os IDs de cupons. E json_arrayagg é uma window_function, podendo agregar
# todos os registros de uma coluna.