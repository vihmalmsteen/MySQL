-- ########## APÓS TRANSFORMAR ARRAY EM LINHAS, FAZER JOIN DESTA TABELA ORIUNDA DE JSON_TABLE COM OUTRA ##########

-- 1. CRIANDO TABLE chefes_equipe E INSERINDO VALORES:

create table chefes_equipe (ID int, 
                            chefe_nome varchar(50), 
                            modalidade varchar(50), 
                            pilotosID TEXT);

insert into chefes_equipe values
(100, "ANA", "CHEFE DE EQUIPE", "[1, 2, 3]"),
(101, "BETO", "CHEFE DE EQUIPE", "[4]"),
(102, "PACHECO", "CHEFE DE EQUIPE", "[5, 6, 7, 8]"),
(103, "JUNIOR", "CHEFE DE EQUIPE", "[9, 10, 11, 12, 13, 14]"),
(104, "THIAGO", "CHEFE DE EQUIPE", "[15, 16, 17]"),
(105, "DANILO", "CHEFE DE EQUIPE", "[18]"),
(106, "ISAIAS", "CHEFE DE EQUIPE", "[19, 20, 21]"),
(107, "WELLINGTON", "CHEFE DE EQUIPE", "[22, 23]"),
(108, "ROSIVALDO", "CHEFE DE EQUIPE", "[24, 25, 26]");


-- 2. TABELA CRIADA:
select * from chefes_equipe;


# 3. CRIANDO tabe pilotos E INSERINDO VALORES:
create table pilotos (ID int, 
                      piloto_nome varchar(50),
                      modalidade varchar(50),
                      chefes_IDs TEXT,
                      cupom TEXT);

insert into pilotos values
(1, "ADALBERTO", "PILOTO", "[100]", "[1, 2, 3]"),
(2, "MARCOS PAULO", "PILOTO", "[100]", "[1, 2]"),
(3, "JAIRO", "PILOTO", "[100]", "[4, 5, 6]"),
(4, "CLAUDIO", "PILOTO", "[101]", "[7]"),
(5, "MAURICIO", "PILOTO", "[102]", "[3]"),
(6, "VITOR", "PILOTO", "[102]", "[1, 3]"),
(7, "YURI", "PILOTO", "[102]", "[]"),
(8, "GAGARIN", "PILOTO", "[102]", "[]"),
(9, "MASLOW", "PILOTO", "[103]", "[]"),
(10, "DAMODARAN", "PILOTO", "[103]", "[]"),
(11, "MAOMÉ", "PILOTO", "[103]", "[]"),
(12, "JESUS", "PILOTO", "[103]", "[]"),
(13, "NAZARÉ", "PILOTO", "[103]", "[]"),
(14, "OZZY", "PILOTO", "[103]", "[9, 10]"),
(15, "HETFIELD", "PILOTO", "[104]", "[11]"),
(16, "PETRUCCI", "PILOTO", "[104]", "[11]"),
(17, "ZAKK", "PILOTO", "[104]", "[9]"),
(18, "NOEL", "PILOTO", "[105]", "[]"),
(19, "BAKI", "PILOTO", "[106]", "[3, 6]"),
(20, "NATANAEL", "PILOTO", "[106]", "[2, 4, 8]"),
(21, "PICOLLO", "PILOTO", "[106]", "[9]"),
(22, "DAIMAOH", "PILOTO", "[107]", "[1]"),
(23, "CORLEONE", "PILOTO", "[107]", "[1]"),
(24, "PINOQUIO", "PILOTO", "[108]", "[2]"),
(25, "CHAPOLIN", "PILOTO", "[108]", "[2]"),
(26, "CIRO", "PILOTO", "[108]", "[]");


# 4. TABELA CRIADA:
select * from pilotos;


# 5. CRIANDO TABLE cupons E INSERINDO VALORES:

create table cupons (ID int,
                     NOME varchar(50),
                     TIPO varchar(20),
                     VALOR float(20,2));
insert into cupons values
(1, "RALLY_MAR", "percentual", 0.30),
(3, "RALLY_ABR", "valor", 200),
(4, "RALLY_MAR", "percentual", 0.10),
(7, "RALLY_MAR", "percentual", 0.45),
(9, "RALLY_MAR", "percentual", 0.90),
(10, "RALLY_ABR", "valor", 700),
(11, "RALLY_ABR", "valor", 800),
(13, "RALLY_MAR", "percentual", 0.25),
(17, "RALLY_ABR", "valor", 1000),
(19, "RALLY_MAR", "percentual", 0.70),
(22, "RALLY_ABR", "valor", 500);


# 6. TBELA CRIADA:
select * from cupons;


# 7. JOIN ENTRE TABELA DE PILOTOS E DE CUPONS, 'ON' ID DO CUPOM:
select 
    a.ID                        as ID
  , a.piloto_nome               as piloto
  , a.modalidade                as modalidade
  , a.chefes_IDs -> '$[0]'      as chefe_ID
  , a.cupom_JT                  as cupom_ID
  , a.cupom                     as cupom_array
  , b.ID                        as cupomID
  , b.NOME                      as cupom_nome
  , b.TIPO                      as cupom_tipo
  , b.VALOR                     as cupom_valor
  
  from 

(
 select p.*, JT_cupom.*
 from pilotos p
   join
 json_table(
            p.cupom
          , '$[*]' columns(cupom_JT int path '$')
           ) JT_cupom
  
  union all
  
  select *, null as cupom_JT from pilotos where cupom = "[]"    # pegando os que não usaram cupom

) as a

  left join

(
 select c.* from cupons c
) as b

  on a.cupom_JT = b.ID
  order by a.ID
;

