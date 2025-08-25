# 1. CRIANDO TABELA COM JSONS:
create table pedidos (ID int not null auto_increment, 
                      DataCompra timestamp default current_timestamp,
                      comprador_ID int,
                      produtos_ID_1 text,     # array
                      produtos_ID_2 json,     # json completo
                      primary key (ID));

insert into pedidos values
(ID, current_timestamp, 1, "[1, 2, 3]", '{"IDs":[1, 2, 3], "produtos":["maça", "cigarro", "pão"]}'),
(ID, current_timestamp, 2, "[1, 3, 4]", '{"IDs":[1, 3, 4], "produtos":["maça", "pão", "leite"]}'),
(ID, current_timestamp, 2, "[3, 4, 5]", '{"IDs":[3, 4, 5], "produtos":["pão", "leite", "bolo"]}'),
(ID, current_timestamp, 2, "[7]"      , '{"IDs":[7],       "produtos":["jujuba"]}'),
(ID, current_timestamp, 2, "[2, 3, 4]", '{"IDs":[2, 3, 4], "produtos":["cigarro", "pão", "leite"]}'),
(ID, current_timestamp, 2, "[9]"      , '{"IDs":[9],       "produtos":["isqueiro"]}'),
(ID, current_timestamp, 2, "[11, 12]" , '{"IDs":[11, 12],  "produtos":["fuzil", "ácido de bateria"]}');

select * from pedidos;



# 2. ACESSANDO DADOS JSON:
select 
    p.ID
  , p.produtos_ID_1 ->> '$[0]'             as posicional
  , p.produtos_ID_2 ->> '$.produtos'       as chave
  , p.produtos_ID_2 ->> '$.produtos[0]'    as positional_e_chave
  , p.produtos_ID_2 -> '$.produtos[0]'     as positional_e_chave_quoted
  
from pedidos p;