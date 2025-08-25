select * from JSON_TABLE(
'[
{"pedidoID_kit":"351127_Ingresso Indústria", "kit_bruto":"1800", "kit_cupom":"0", "kit_liquido":"1800", "kit_conveniencia":"180", "kit_total":"1980"},
{"pedidoID_kit":"351259_Ingresso Comunidade Sábado | Inteira", "kit_bruto":"300", "kit_cupom":"60", "kit_liquido":"240", "kit_conveniencia":"24", "kit_total":"264"},
{"pedidoID_kit":"351259_Ingresso Comunidade Sábado | Meia Entrada", "kit_bruto":"150", "kit_cupom":"30", "kit_liquido":"120", "kit_conveniencia":"12", "kit_total":"132"},
{"pedidoID_kit":"351259_Ingresso Indústria", "kit_bruto":"2700", "kit_cupom":"540", "kit_liquido":"2160", "kit_conveniencia":"216", "kit_total":"2376"},
{"pedidoID_kit":"351388_Ingresso Indústria", "kit_bruto":"900", "kit_cupom":"0", "kit_liquido":"900", "kit_conveniencia":"90", "kit_total":"990"}
]'
, '$[*]'

COLUMNS(
  pedidoID_kit            varchar(200)  path "$.pedidoID_kit"
, kit_bruto               float         path "$.kit_bruto"
, kit_cupom               float         path "$.kit_cupom"
, kit_liquido             float         path "$.kit_liquido"
, kit_conveniencia        float         path "$.kit_conveniencia"
, kit_total               float         path "$.kit_total"
       )
) as js_table

/*
DETALHES:
A tabella fica em um array [] e todo o array é uma string -> '[]'
Cada linha da tabela é uma chave, chaves separadas por vírgula dentro do array -> '[{}, {}, {}]'
Tanto as chaves como registros das chaves devem estar aspados, independente dos registros serem float ou int -> [{"col_1":"reg_texto"}, {"col_2":"reg_int"}, {"col_3":"reg_float"}]
*/
