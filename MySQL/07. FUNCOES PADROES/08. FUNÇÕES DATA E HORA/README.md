<h2>8. FUNÇÕES DATA E HORA</h2>

<p align="justify">
	Funções úteis para manipulação de datas e horas, de registros e do sistema. Segue:
</p>

<table align="center"><thead><tr><th>FUNÇÃO</th><th>DESCRIÇÃO</th><th>EXEMPLO</th></tr></thead><tbody><tr><td>CURRENT_DATE()</td><td>Retorna a data atual.</td><td>CURRENT_DATE()</td></tr><tr><td>CURDATE()</td><td>Retorna a data atual.</td><td>CURDATE()</td></tr><tr><td>CURRENT_TIME()</td><td>Retorna a hora atual.</td><td>CURRENT_TIME()</td></tr><tr><td>CONVERT_TZ()</td><td>Converte uma data ou hora de um fuso horário para outro.</td><td>CONVERT_TZ(COL, '+03:00', '+00:00')</td></tr><tr><td>NOW()</td><td>Retorna a data e hora atual.</td><td>NOW()</td></tr><tr><td>DATE()</td><td>Extrai a parte da data de uma data ou timestamp.</td><td>DATE('2022-01-01 10:30:00')</td></tr><tr><td>TIME()</td><td>Extrai a parte da hora de uma data ou timestamp.</td><td>TIME('2022-01-01 10:30:00')</td></tr><tr><td>DAY()</td><td>Extrai o dia de uma data.</td><td>DAY('2022-01-01')</td></tr><tr><td>MONTH()</td><td>Extrai o mês de uma data.</td><td>MONTH('2022-01-01')</td></tr><tr><td>YEAR()</td><td>Extrai o ano de uma data.</td><td>YEAR('2022-01-01')</td></tr><tr><td>HOUR()</td><td>Extrai a hora de uma hora ou timestamp.</td><td>HOUR('10:30:00')</td></tr><tr><td>MINUTE()</td><td>Extrai os minutos de uma hora ou timestamp.</td><td>MINUTE('10:30:00')</td></tr><tr><td>SECOND()</td><td>Extrai os segundos de uma hora ou timestamp.</td><td>SECOND('10:30:00')</td></tr><tr><td>DATE_DIFF()</td><td>Corrige uma data e hora por um intervalo de tempo especificado.</td><td>DATE_ADD('data', INTERVAL -3 HOUR)</td></tr><tr><td>DATEDIFF()</td><td>Calcula a diferença entre duas datas ou horas em uma unidade específica.</td><td>DATEDIFF(DAY, '2022-01-01', '2022-01-06')</td></tr><tr><td>DATE_FORMAT()</td><td>Formata uma data ou hora em um formato específico.</td><td>DATE_FORMAT(NOW(), '%Y-%m-%d %H:%i:%s')</td></tr><tr><td>MONTHNAME()</td><td>Extrai o nome do mês de uma data.</td><td>MONTHNAME('2022-01-01')</td></tr><tr><td>DAYNAME()</td><td>Extrai o nome do dia da semana de uma data.</td><td>DAYNAME('2022-01-01')</td></tr><tr><td>DAYOFWEEK()</td><td>Extrai o dia da semana de uma data em formato numérico (1 - domingo, 7 - sábado).</td><td>DAYOFWEEK('2022-01-01')</td></tr><tr><td>DAYOFMONTH()</td><td>Extrai o dia do mês de uma data.</td><td>DAYOFMONTH('2022-01-01')</td></tr><tr><td>DAYOFYEAR()</td><td>Extrai o dia do ano de uma data.</td><td>DAYOFYEAR('2022-01-01')</td></tr><tr><td>EXTRACT()</td><td>Extrai uma parte específica (ano, mês, dia, etc.) de uma data ou timestamp.</td><td>EXTRACT(YEAR FROM '2022-01-01')</td></tr><tr><td>LAST_DAY()</td><td>Retorna o último dia do mês de uma data.</td><td>LAST_DAY('2022-01-01')</td></tr></tbody></table>

```sql
select
  current_timestamp() as `current_timestamp`                              -- data e hora completas do sistema
, now() as `now`                                                          -- data e hora completas do sistema
, current_date() as `current_date`                                        -- data completa do sistema
, curdate() as `curdate`                                                  -- data completa do sistema
, current_time() as `current_time`                                        -- hora completa do sistema
, time(convert_tz(current_time(), '+03:00', '+00:00')) as `convert_tz`    -- conversão de fuso
, date(now()) as `date`                                                   -- extrai data completa
, time(now()) as `time`                                                   -- extrai hora completa
, day(now()) as `day`                                                     -- extrai dia, somente
, month(now()) as `month`                                                 -- extrai mês, somente
, year(now()) as `year`                                                   -- extrai ano, somente
, hour(now()) as `hour`                                                   -- extrai hora, somente
, minute(now()) as `minute`                                               -- extrai minuto, somente
, second(now()) as `second`                                               -- extrai segundo, somente
, date_add(now(), interval -3 hour) as `date_add`                         -- apura novas data e hora completas com um intervalo especificado (pode ser usada no lugar de CONVERT_TZ)
, datediff(now(), '2022-01-01') as `datediff`                             -- retorna a diferença em dias de duas datas: FINAL - INICIAL
, date_format(now(), '%d/%m/%Y') as `date_format`                         -- converte para um formato de hora informado ('%d/%m/%Y' é o padrão brasileiro)
, monthname(now()) as `monthname`                                         -- nome do mês
, dayname(now()) as `dayname`                                             -- nome do dia da semana
, dayofweek(now()) as `dayofweek`                                         -- nº do dia da semana
, dayofmonth(now()) as `dayofmonth`                                       -- nº do dia do mês
, dayofyear(now()) as `dayofyear`                                         -- nº do dia do ano
, extract(year from now()) as `extract`                                   -- extrai um componente temporal de uma data
, last_day(now()) as `lastday`                                            -- retorna último dia do mês
;
```

<table align="center"><thead><tr><th>current_timestamp</th><th>now</th><th>current_date</th><th>curdate</th><th>current_time</th><th>convert_tz</th><th>date</th><th>time</th><th>day</th><th>month</th><th>year</th><th>hour</th><th>minute</th><th>second</th><th>date_add</th><th>datediff</th><th>date_format</th><th>monthname</th><th>dayname</th><th>dayofweek</th><th>dayofmonth</th><th>dayofyear</th><th>extract</th><th>lastday</th></tr></thead><tbody><tr><td>2023-11-22 20:28:47</td><td>2023-11-22 20:28:47</td><td>2023-11-22</td><td>2023-11-22</td><td>20:28:47</td><td>17:28:47</td><td>2023-11-22</td><td>20:28:47</td><td>22</td><td>11</td><td>2023</td><td>20</td><td>28</td><td>47</td><td>2023-11-22 17:28:47</td><td>690</td><td>22/11/2023</td><td>November</td><td>Wednesday</td><td>4</td><td>22</td><td>326</td><td>2023</td><td>2023-11-30</td></tr></tbody></table>

<p align="justify"><b>NOTAS:</b></p>

<ol>
	<li><p align="justify">Basta saber algumas poucas como <b>NOW()</b> ou <b>CURRENT_TIMESTAMP()</b> para retornar data e hora completa.</p></li>
	<li><p align="justify"><b>DATE_ADD</b> pode substituir <b>CONVERT_TZ</b>.</p></li>
	<li><p align="justify"></p><b>DATE_FORMAT</b> aceita outros formatos, mas este é um dos mais usados por conta do padrão brasileiro. Contudo, é convertido para string, deixando de ser data.</li>
	<li><p align="justify">Estas funções de data também servem em INSERTS.</p></li>
</ol>

```sql
-- criando tabela
create table exemplo (id int auto_increment primary key not null,
                      data_hora timestamp not null);

-- inserts
insert into exemplo values (id, current_timestamp());
insert into exemplo values (id, current_timestamp());
insert into exemplo values (id, current_timestamp());
insert into exemplo values (id, date_add(current_timestamp(), interval 7 day));

-- check
select * from exemplo;
```

<table align="center"><thead><tr><th>id</th><th>data_hora</th></tr></thead><tbody><tr><td>1</td><td>2023-11-22 20:51:16</td></tr><tr><td>2</td><td>2023-11-22 20:51:18</td></tr><tr><td>3</td><td>2023-11-22 20:51:20</td></tr><tr><td>4</td><td>2023-11-29 20:52:14</td></tr></tbody></table>
