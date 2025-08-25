-- ########## PARA EXPLODIR COM ARRAYS JSON COM JSON_TABLE ##########



-- 1. CRIANDO TABLE inscricoes E INSERINDO VALORES:

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
(106, "ISAIAS", "CHEFE DE EQUIPE", "[19, 20, 21]"),
(107, "WELLINGTON", "CHEFE DE EQUIPE", "[22, 23]"),
(108, "ROSIVALDO", "CHEFE DE EQUIPE", "[24, 25, 26]");



-- 2. TABELA CRIADA:

select * from inscricoes;


-- 3. TABELA inscricoes JOIN JSON_TABLE:

select 
    i.*
  , js_table_pilotos.*
from inscricoes i

  join

json_table(
    i.pilotosID
  , '$[*]' columns(PilotoID int path '$')
) js_table_pilotos