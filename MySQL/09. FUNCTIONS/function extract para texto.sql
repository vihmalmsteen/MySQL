/*
Criando função para strings que funcione como JSON_EXTRACT, retornando o elemento de um texto separado 
por vírgulas e caso o índice fornecido seja superior à quantidade de elementos no texto, retornar nulo.
*/

DELIMITER //
CREATE FUNCTION get_array_element(arr TEXT, indice INT)
RETURNS TEXT
BEGIN
    DECLARE num_elements INT;
    DECLARE elemento TEXT;
    SET num_elements = (SELECT LENGTH(arr) - LENGTH(REPLACE(arr, ',', '')) + 1);
    IF indice > num_elements OR indice <= 0 THEN
        RETURN NULL;
    ELSE
        SET elemento = SUBSTRING_INDEX(SUBSTRING_INDEX(arr, ',', indice), ',', -1);
        RETURN elemento;
    END IF;
END //
DELIMITER ;



/*
-- tabela de exemplo com retorno:
select 
  r.planos_cobertos
, get_array_element(r.planos_cobertos, 1) as `1`
, get_array_element(r.planos_cobertos, 2) as `2`
, get_array_element(r.planos_cobertos, 3) as `3`
, get_array_element(r.planos_cobertos, 4) as `4`
from remedio r 
;

+---------------------------+------------+------------+------------+------+
| planos_cobertos           | 1          | 2          | 3          | 4    |
+---------------------------+------------+------------+------------+------+
| AMIL,SILVESTRE            | AMIL       | SILVESTRE  | NULL       | NULL |
| AMIL                      | AMIL       | NULL       | NULL       | NULL |
| SILVESTRE                 | SILVESTRE  | NULL       | NULL       | NULL |
| AMIL,SILVESTRE,SULAMERICA | AMIL       | SILVESTRE  | SULAMERICA | NULL |
| SULAMERICA                | SULAMERICA | NULL       | NULL       | NULL |
| NULL                      | NULL       | NULL       | NULL       | NULL |
| AMIL,SULAMERICA           | AMIL       | SULAMERICA | NULL       | NULL |
| SILVESTRE                 | SILVESTRE  | NULL       | NULL       | NULL |
| AMIL,SULAMERICA           | AMIL       | SULAMERICA | NULL       | NULL |
| AMIL,SILVESTRE            | AMIL       | SILVESTRE  | NULL       | NULL |
| SILVESTRE,SULAMERICA      | SILVESTRE  | SULAMERICA | NULL       | NULL |
| AMIL                      | AMIL       | NULL       | NULL       | NULL |
| SULAMERICA                | SULAMERICA | NULL       | NULL       | NULL |
| AMIL,SILVESTRE            | AMIL       | SILVESTRE  | NULL       | NULL |
| AMIL,SULAMERICA           | AMIL       | SULAMERICA | NULL       | NULL |
+---------------------------+------------+------------+------------+------+
*/
