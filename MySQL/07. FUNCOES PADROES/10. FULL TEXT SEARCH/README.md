<h2>10. FULL TEXT SEARCH</h2>

<p align="justify">
	Um índice de texto completo (full-text index) é uma estrutura de dados no MySQL que permite realizar pesquisas eficientes em documentos de texto ou colunas de texto longos. Ele facilita a correspondência de palavras-chave, pesquisa por frases, classificação de relevância e outras operações relacionadas à pesquisa de texto. Ao criar um índice de texto completo em uma coluna, o MySQL analisa o texto dessa coluna e cria uma estrutura otimizada que facilita a pesquisa de palavras-chave e a recuperação rápida de resultados relevantes. Um índice de texto completo permite pesquisas mais poderosas do que as pesquisas padrão com uso do operador LIKE. Com ele, você pode realizar pesquisas por palavras individuais, combinações exatas de palavras, frases, pesquisa por similaridade, entre outras opções. A criação de um índice de texto completo no MySQL envolve duas etapas principais:
</p>

<ol>
	<li><p align="justify">Configurar a coluna para suportar índices de texto completo. Isso envolve a definição do tipo de dados apropriado (como `TEXT`, `VARCHAR`, `LONGTEXT`, etc.) e, em seguida, adicionando o índice de texto completo à coluna específica usando a sintaxe `FULLTEXT INDEX`.</p></li>
	<li><p aling="justify">Indexar os dados por meio de uma indexação inicial ou atualização em tempo real.</p></li>
</ol>

```sql
-- na criação da tabela:
CREATE TABLE tabela (
          id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
          col1 VARCHAR(200),
          col2 TEXT,
          FULLTEXT (col1, col2),
          FULLTEXT INDEX idx_fulltext_col1 (col1),
          FULLTEXT INDEX idx_fulltext_col2 (col2)
        )
;

-- criando tabela e alterando separadamente:
CREATE TABLE tabela (
          id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
          col1 VARCHAR(200),
          col2 TEXT,
          FULLTEXT (col1, col2)
        )
;

alter table tabela add FULLTEXT INDEX idx_fulltext_col1 (col1);
alter table tabela add FULLTEXT INDEX idx_fulltext_col2 (col2);
```

<p align="justify">
	Nos casos acima, consultas FULL TEXT deverão ser feitas separadamente. Caso haja a necessidade de realizar consultas simultaneas, declarar da seguinte forma:
</p>

```sql
-- na criacao da tabela:
CREATE TABLE tabela (
          id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
          col1 VARCHAR(200),
          col2 TEXT,
          FULLTEXT (col1, col2),
          FULLTEXT INDEX idx_fulltext_cols (col1, col2)
        )
;

-- criando tabela e alterando separadamente:
CREATE TABLE tabela (
          id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
          col1 VARCHAR(200),
          col2 TEXT,
          FULLTEXT (col1, col2)
        )
;

alter table tabela add FULLTEXT INDEX idx_fulltext_cols (col1, col2);
```

<p align="justify">Para remover um índice criado:</p>

```sql
ALTER TABLE tabela DROP INDEX indice;
```

<p align="justify">
	Após a criação do índice de texto completo, você pode usar a função `MATCH() AGAINST()` nas consultas para pesquisar o conteúdo do documento de texto indexado.
</p>

```sql
-- em SELECT
select MATCH (coluna) AGAINST ('termo de pesquisa') as `col`
from tabela

-- em WHERE
select col
from tabela
where MATCH (coluna) AGAINST ('termo de pesquisa') as `col`
```

<p aling="justify">
	<b>O retorno da função é um score percentual da relevância do termo buscado dentro do texto.</b>
</p>

<p align="justify"></p>
É importante observar que nem todas as colunas são adequadas para índices de texto completo. Por exemplo, colunas que contêm dados binários ou numéricos não são apropriadas para esse tipo de índice. Além disso, as pesquisas com índice de texto completo podem ser mais lentas do que as pesquisas regulares com índices B-tree tradicionais, especialmente quando a tabela contém uma grande quantidade de dados de texto.

```sql
use hospital;

-- adicionando índices FULL TEXT às colunas de nome do médico e do paciente
alter table medico add FULLTEXT INDEX idx_fulltext_medico (nome);
alter table paciente add FULLTEXT INDEX idx_fulltext_paciente (nome);

-- Checando pontuação dos nomes com 'Santos'
select 
  m.`nome` as `medico`
, match (m.`nome`) against('Santos') as `pontuacaoMedico`
, p.`nome` as `paciente`
, match (p.`nome`) against('Santos') as `pontuacaoPaciente`
from consulta c
	join medico m     on c.`medico_id` = m.`id`
	join paciente p   on c.`paciente_id` = c.`id`
limit 10
;
```

<table align="center"><thead><tr><th>medico</th><th>pontuacaoMedico</th><th>paciente</th><th>pontuacaoPaciente</th></tr></thead><tbody><tr><td>Dr. João Santos</td><td>0,488559067</td><td>Fulano Silva</td><td>0</td></tr><tr><td>Dr. João Santos</td><td>0,488559067</td><td>Cicrano Souza</td><td>0</td></tr><tr><td>Dr. João Santos</td><td>0,488559067</td><td>Beltrano Oliveira</td><td>0</td></tr><tr><td>Dr. João Santos</td><td>0,488559067</td><td>Maria Rodrigues</td><td>0</td></tr><tr><td>Dr. João Santos</td><td>0,488559067</td><td>José Pereira</td><td>0</td></tr><tr><td>Dr. João Santos</td><td>0,488559067</td><td>Ana Silva</td><td>0</td></tr><tr><td>Dr. João Santos</td><td>0,488559067</td><td>Paulo Santos</td><td>0,910578787</td></tr><tr><td>Dr. João Santos</td><td>0,488559067</td><td>Mariana Oliveira</td><td>0</td></tr><tr><td>Dr. João Santos</td><td>0,488559067</td><td>Pedro Gomes</td><td>0</td></tr><tr><td>Dr. João Santos</td><td>0,488559067</td><td>Fulano Silva</td><td>0</td></tr></tbody></table>

```sql
-- retornando os nomes dos pacientes cuja pontuação é maior que 50% para o nome 'Santos'
select 
  nome as `paciente`
, match(nome) against('Santos') as `score`
from paciente
where match(nome) against('Santos') >= 0.5
order by `score` desc
;
```

<table align="center"><thead><tr><th>nome</th><th>score</th></tr></thead><tbody><tr><td>Paulo Santos</td><td>0,910578787</td></tr></tbody></table>
