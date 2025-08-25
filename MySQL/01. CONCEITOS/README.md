<h2>1. Instalação do MySQL</h2>

<p align="justify">
  Ir no site da <a href="https://dev.mysql.com/downloads/installer/">oracle e baixar o MySQL Comunnity Installer</a>. De preferência, a versão 8 para cima (mais tipagens, funções, etc.). Após baixar, instalar tudo, mas, principalmente o server e o workbench. De maneira adicional, pode-se optar pro trabalhar com o <a href="https://dbeaver.io/download/">DBeaver</a> que dá suporte a outros tipos de bancos, não somente MySQL, e também tem recursos adicionais via plugins e add-ons.
</p>

<h2>2. Conceitos teóricos</h2>

<h3>2.1 Características de um banco de dados relacional</h3>

<p align="justify">Banco de dados que segue o modelo relacional. Esse modelo é baseado na teoria dos conjuntos, sendo composto por tabelas com linhas e colunas. Cada tabela representa uma entidade ou relação, enquanto as linhas representam os registros e as colunas representam os atributos.</p>

<p align="justify">As tabelas em um banco de dados relacional têm relacionamentos entre si por meio de chaves primárias e chaves estrangeiras. A chave primária é um atributo que identifica unicamente cada registro em uma tabela, enquanto a chave estrangeira é uma referência a uma chave primária em outra tabela.</p>

<p align="justify">O banco de dados relacional possui a vantagem de ser flexível e de permitir a consulta e manipulação dos dados de forma eficiente. Ele também garante a integridade dos dados por meio de restrições de integridade, como chaves primárias e chaves estrangeiras.</p>

<p align="justify">Exemplos de bancos de dados relacionais populares são o MySQL, o Oracle e o Microsoft SQL Server.</p>

<h3>Modelo Entidade-Relaciomento</h3>

<p align="justify">O modelo Entidade-Relacionamento (ER) é uma representação gráfica utilizada para modelar e descrever um banco de dados. Ele é composto por entidades, relacionamentos e atributos.</p>

<p align="justify">As entidades são objetos do mundo real que são representados no banco de dados, como uma pessoa, um produto ou uma empresa. Cada entidade possui atributos, que são características ou propriedades que descrevem a entidade. Por exemplo, uma entidade "pessoa" pode ter atributos como nome, idade, endereço, etc.</p>

<p align="justify">Os relacionamentos são conexões entre as entidades, que representam a forma como elas interagem ou se relacionam entre si. Por exemplo, uma entidade "cliente" pode se relacionar com uma entidade "pedido", estabelecendo uma relação de compra.</p>

<p align="justify">No modelo ER, os relacionamentos também podem ter atributos, chamados de atributos de relacionamento, que descrevem informações específicas do relacionamento em si. Por exemplo, um relacionamento "compra" pode ter o atributo "data" para indicar a data da compra.</p>

<p align="justify">Para representar o modelo ER graficamente, são utilizados diagramas ER, que possuem símbolos específicos para entidades, relacionamentos e atributos. Esses diagramas são úteis para visualizar a estrutura do banco de dados e entender a forma como as entidades estão relacionadas.</p>

<p align="justify">O modelo ER serve como base para a criação do esquema do banco de dados relacional, que é a estrutura física do banco de dados contendo as tabelas, colunas e restrições. A partir do modelo ER, é possível fazer a conversão para a estrutura relacional, utilizando-se técnicas de normalização para eliminar redundâncias e garantir a consistência dos dados.</p>

<h3>2.2 Cardinalidade</h3>

<p align="justify"></p>

A cardinalidade é um conceito importante no modelo Entidade-Relacionamento (ER) que descreve a forma como as entidades estão relacionadas entre si. Ela define o número mínimo e máximo de ocorrências que uma entidade pode ter em um relacionamento. Existem três tipos de cardinalidade que podem ser aplicados aos relacionamentos:

<ul>
  <li><p align="justify"><b>Cardinalidade um para um (1:1): </b>Nesse tipo de relacionamento, uma instância de uma entidade pode estar associada a apenas uma instância da outra entidade. Por exemplo, em um relacionamento entre "pessoa" e "documento de identificação", uma pessoa possui apenas um documento de identificação, e um documento de identificação está associado a apenas uma pessoa.</p></li>
  <li><p align="justify"><b>Cardinalidade um para muitos (1:N): </b>Nesse tipo de relacionamento, uma instância de uma entidade pode estar associada a várias instâncias da outra entidade, mas cada instância da outra entidade está associada a apenas uma instância da primeira entidade. Por exemplo, em um relacionamento entre "departamento" e "funcionário", um departamento pode ter vários funcionários, mas cada funcionário está associado a apenas um departamento.</p></li>
  <li><p align="justify"><b>Cardinalidade muitos para muitos (N:N): </b>Nesse tipo de relacionamento, várias instâncias de uma entidade podem estar associadas a várias instâncias da outra entidade. Por exemplo, em um relacionamento entre "aluno" e "disciplina", um aluno pode estar matriculado em várias disciplinas, e uma disciplina pode ter vários alunos matriculados.</p></li>
</ul>

<p align="justify">A cardinalidade é representada nos diagramas ER por meio de símbolos específicos. Por exemplo, um relacionamento 1:1 é representado por uma linha sólida que conecta as entidades, um relacionamento 1:N é representado por uma linha sólida e um losango no lado "N" e um relacionamento N:N é representado por uma linha sólida e dois losangos, um em cada lado. Entender a cardinalidade é fundamental para o projeto adequado do banco de dados e para garantir a integridade dos dados. Ela ajuda a definir as chaves primárias e estrangeiras e a estabelecer restrições de integridade referencial.</p>

<h3>2.3 Sistemas de Gerenciamento de Bancos de Dados - SGBD</h3>

<p align="justify">Um Sistema de Gerenciamento de Banco de Dados (SGBD) é um software responsável por gerenciar um banco de dados. Ele oferece um conjunto de ferramentas e funcionalidades que permitem armazenar, organizar, manipular e recuperar dados de forma eficiente e segura. Os principais objetivos de um SGBD são:</p>

<ul>
  <li><p align="justify"><b>Garantir a integridade e consistência dos dados: </b>Um SGBD possui mecanismos para controlar o acesso e modificar os dados de forma que sua integridade seja preservada. Isso inclui o uso de chaves primárias, restrições de integridade, transações e mecanismos de recuperação em caso de falhas.</p></li>
  <li><p align="justify"><b>Permitir o compartilhamento de dados: </b>Um SGBD permite que vários usuários acessem e modifiquem os dados de forma simultânea. Ele oferece mecanismos de controle de concorrência para garantir a consistência e evitar conflitos entre as diferentes operações.</p></li>
  <li><p align="justify"><b>Garantir a segurança dos dados: </b>Um SGBD oferece mecanismos de autenticação e controle de acesso para garantir que apenas usuários autorizados possam acessar e modificar os dados. Além disso, ele permite criar backups e realizar a recuperação dos dados em caso de falhas ou desastres.</p></li>
  <li><p align="justify"><b>Fornecer uma interface de consulta e manipulação dos dados: </b>Um SGBD oferece uma linguagem de consulta, como SQL (Structured Query Language), que permite aos usuários realizar consultas e manipular os dados de forma fácil e eficiente. Ele também pode oferecer ferramentas gráficas para facilitar a interação com o banco de dados.</p></li>
</ul>

<p align="justify">Existem diferentes tipos de SGBDs, sendo os mais populares os bancos de dados relacionais, como MySQL, Oracle, SQL Server e PostgreSQL. Esses sistemas utilizam o modelo relacional para organizar os dados em tabelas e estabelecer relações entre elas. Além disso, existem também os bancos de dados NoSQL, que utilizam modelos diferentes, como o modelo de documento, o modelo de chave-valor e o modelo de grafo, para atender a necessidades específicas de armazenamento e consulta de dados.</p>

<h3>2.4 ACID e CRUD</h3>

<p align="justify">O termo ACID é um acrônimo para Atomicidade, Consistência, Isolamento e Durabilidade. Essas são propriedades essenciais de um Sistema de Gerenciamento de Banco de Dados (SGBD) que garantem a robustez e confiabilidade das transações.</p>

<ul>
  <li><p align="justify"><b>Atomicidade: </b>A atomicidade garante que uma transação seja tratada como uma unidade indivisível de processamento. Isso significa que uma transação é executada por completo ou é totalmente revertida em caso de falha. Se uma transação é composta por várias operações, todas as operações devem ser executadas com sucesso para que a transação seja considerada bem-sucedida. Caso contrário, todas as operações são revertidas e o banco de dados volta ao estado anterior à transação.
</p></li>
  <li><p align="justify"><b>Consistência: </b>A consistência garante que o banco de dados esteja em um estado consistente antes e após a execução de uma transação. Isso significa que uma transação deve respeitar as restrições de integridade definidas no banco de dados. Por exemplo, se uma restrição de chave primária estabelece que uma determinada coluna não pode ter valores duplicados, uma transação não pode inserir dados que violem essa restrição.</p></li>
  <li><p align="justify"><b>Isolamento: </b>O isolamento garante que uma transação em execução não seja afetada por outras transações concorrentes. Isso significa que cada transação deve ocorrer de forma isolada e independente das outras transações em execução. O isolamento evita que transações concorrentes interfiram umas nas outras, preservando a consistência dos dados e evitando problemas como leituras sujas, ou seja, a leitura de dados modificados por uma transação ainda não finalizada.</p></li>
  <li><p align="justify"><b>Durabilidade: </b>A durabilidade garante que uma transação bem-sucedida seja persistente no banco de dados, mesmo em caso de falhas de sistema ou reinicializações. Isso significa que as alterações realizadas em uma transação bem-sucedida são permanentes e não são perdidas. O SGBD deve garantir que as alterações sejam gravadas em disco e possam ser recuperadas mesmo após um eventual problema.</p></li>
</ul>

<p align="justify">Já o termo CRUD é um acrônimo para Create, Read, Update e Delete, que são as operações básicas de um SGBD para manipulação de dados em um banco de dados. O CRUD representa as ações de criar (inserir) novos registros, ler (consultar) registros existentes, atualizar registros existentes e excluir registros. Essas são as operações fundamentais para manipular os dados em um banco de dados e são geralmente realizadas por meio de comandos SQL (Structured Query Language).</p>


<h3>2.5 Tipos de dados</h3>

<p align="justify">
  Alguns dos principais tipos de dados são dispostos abaixo:
</p>

<table align="justify"><thead><tr><th>TIPO</th><th>DESCRIÇÃO</th><th>EXEMPLO CREATE</th><th>EXEMPLO INSERT</th></tr></thead><tbody><tr><td>INT</td><td>Usado para armazenar valores inteiros. Pode ter diferentes tamanhos, como INT, SMALLINT, TINYINT e BIGINT.</td><td>`CREATE TABLE tabela (coluna_int INT);`</td><td>`INSERT INTO tabela (coluna_int) VALUES (10);`</td></tr><tr><td>VARCHAR</td><td>Usado para armazenar strings de caracteres variáveis. O tamanho máximo é especificado ao criar a tabela.</td><td>`CREATE TABLE tabela (coluna_varchar VARCHAR(255));`</td><td>`INSERT INTO tabela (coluna_varchar) VALUES (&quot;Hello, World!&quot;);`</td></tr><tr><td>CHAR</td><td>Semelhante ao VARCHAR, mas usado para strings de tamanho fixo. O tamanho máximo também é especificado ao criar a tabela.</td><td>`CREATE TABLE tabela (coluna_char CHAR(10));`</td><td>`INSERT INTO tabela (coluna_char) VALUES (&quot;Example&quot;);`</td></tr><tr><td>TEXT</td><td>Usado para armazenar grandes volumes de texto.</td><td>`CREATE TABLE tabela (coluna_text TEXT);`</td><td>`INSERT INTO tabela (coluna_text) VALUES (&quot;Lorem ipsum dolor sit amet, consectetur adipiscing elit.&quot;);`</td></tr><tr><td>DATE</td><td>Usado para armazenar valores de data no formato &#39;AAAA-MM-DD&#39;.</td><td>`CREATE TABLE tabela (coluna_date DATE);`</td><td>`INSERT INTO tabela (coluna_date) VALUES (&quot;2022-07-31&quot;);`</td></tr><tr><td>TIME</td><td>Usado para armazenar valores de tempo no formato &#39;HH:MM:SS&#39;.</td><td>`CREATE TABLE tabela (coluna_time TIME);`</td><td>`INSERT INTO tabela (coluna_time) VALUES (&quot;15:30:00&quot;);`</td></tr><tr><td>DATETIME</td><td>Usado para armazenar valores de data e hora no formato &#39;AAAA-MM-DD HH:MM:SS&#39;.</td><td>`CREATE TABLE tabela (coluna_datetime DATETIME);`</td><td>`INSERT INTO tabela (coluna_datetime) VALUES (&quot;2022-07-31 15:30:00&quot;);`</td></tr><tr><td>TIMESTAMP</td><td>Usado para armazenar datas e horas, incluindo informações sobre o fuso horário.</td><td>`CREATE TABLE tabela (coluna_timestamp TIMESTAMP);`</td><td>`INSERT INTO tabela (coluna_timestamp) VALUES (&quot;2022-07-31 15:30:00&quot;);`</td></tr><tr><td>DECIMAL</td><td>Usado para armazenar valores numéricos com precisão fixa. O tamanho e a escala (número de dígitos após o decimal) são especificados ao criar a tabela.</td><td>`CREATE TABLE tabela (coluna_decimal DECIMAL(10, 2));`</td><td>`INSERT INTO tabela (coluna_decimal) VALUES (10.5);`</td></tr><tr><td>FLOAT e DOUBLE</td><td>Usados para armazenar valores de ponto flutuante de precisão simples (FLOAT) ou dupla (DOUBLE).</td><td>`CREATE TABLE tabela (coluna_float FLOAT);`</td><td>`INSERT INTO tabela (coluna_float) VALUES (3.14);`</td></tr><tr><td>ENUM</td><td>Usado para armazenar um conjunto finito de valores que são escolhidos a partir de uma lista pré-definida.</td><td>`CREATE TABLE tabela (coluna_enum ENUM(&#39;solteiro&#39;, &#39;casado&#39;, &#39;divorciado&#39;));`</td><td>`INSERT INTO tabela (coluna_enum) VALUES (&quot;solteiro&quot;);`</td></tr><tr><td>SET</td><td>Semelhante ao ENUM, permite armazenar um conjunto de valores, mas a diferença é que o SET permite armazenar múltiplos valores escolhidos a partir de uma lista.</td><td>`CREATE TABLE tabela (coluna_set SET(&#39;vermelho&#39;, &#39;azul&#39;, &#39;amarelo&#39;));`</td><td>`INSERT INTO tabela (coluna_set) VALUES (&quot;vermelho,azul&quot;);`</td></tr><tr><td>BLOB</td><td>Usado para armazenar dados binários grandes, como imagens, vídeos, documentos, entre outros. Existem subtipos como TINYBLOB, BLOB, MEDIUMBLOB e LONGBLOB, para diferentes tamanhos de dados.</td><td>`CREATE TABLE tabela (coluna_blob BLOB);`</td><td>`INSERT INTO tabela (coluna_blob) VALUES (binary data);`</td></tr><tr><td>JSON</td><td>Usado para armazenar dados em formato JSON (JavaScript Object Notation). Útil quando é necessário armazenar, recuperar e manipular dados estruturados em formato JSON diretamente no banco de dados.</td><td>`CREATE TABLE tabela (coluna_json JSON);`</td><td>`INSERT INTO tabela (coluna_json) VALUES (&#39;{&quot;name&quot;: &quot;John&quot;, &quot;age&quot;: 30, &quot;city&quot;: &quot;New York&quot;}&#39;);`</td></tr></tbody></table>

<h3>2.6 Atributos de dados</h3>

<p align="justify">
  São características especificadas no momento de criação de campos (colunas) de uma tabela. Segue:
</p>

<table align="center"><thead><tr><th>CATEGORIA</th><th>DESCRIÇÃO</th><th>EXEMPLO CREATE</th></tr></thead><tbody><tr><td>SIGNED</td><td>Indica que um tipo de dado numérico pode ter valores positivos e negativos.</td><td>`column_name INT SIGNED`</td></tr><tr><td>UNSIGNED</td><td>Indica que um tipo de dado numérico só pode ter valores positivos (não pode ser negativo).</td><td>`column_name INT UNSIGNED`</td></tr><tr><td>ZEROFILL</td><td>Preenche os dígitos não utilizados com zeros à esquerda.</td><td>`column_name INT ZEROFILL`</td></tr><tr><td>AUTO_INCREMENT</td><td>Incrementa automaticamente os valores em uma coluna numérica para criar identificadores únicos.</td><td>`column_name INT AUTO_INCREMENT PRIMARY KEY`</td></tr></tbody></table>

<p align="justify">
  <b>NOTA: </b>Nesse exemplo, a tabela_secundaria possui uma coluna id_tabela_principal que é uma chave estrangeira (FOREIGN KEY) referenciando a coluna id da tabela_principal. Isso garante que apenas valores existentes na tabela_principal possam ser inseridos na tabela_secundaria. É importante lembrar que o uso de FOREIGN KEY requer que as tabelas estejam definidas com um mecanismo de armazenamento que suporte essa funcionalidade, como o InnoDB.
</p>

<h3>2.7 Constraints (restrições)</h3>

<p align="justify">
  Constraints (restrições) são regras aplicadas a colunas ou tabelas em um banco de dados para garantir a integridade dos dados e impor certas condições em relação a esses dados. Elas definem as restrições que devem ser seguidas ao inserir, atualizar ou excluir registros em uma tabela. As constraints ajudam a evitar a inserção de dados inválidos ou inconsistentes, garantindo que apenas dados corretos e válidos sejam armazenados.
</p>

<table align="center"><thead><tr><th>CONSTRAINT</th><th>DEFINIÇÃO</th><th>EXEMPLO CREATE</th></tr></thead><tbody><tr><td>Primary Key</td><td>Identifica exclusivamente cada registro em uma tabela. Impõe a restrição de que os valores devem ser exclusivos.</td><td>`CREATE TABLE tabela_exemplo (id INT PRIMARY KEY, nome VARCHAR(50));`</td></tr><tr><td>Foreign Key</td><td>Estabelece uma relação entre duas tabelas. Impõe a restrição de que os valores devem corresponder a outra tabela.</td><td>`CREATE TABLE tabela1 (id INT PRIMARY KEY);`&lt;br&gt;`CREATE TABLE tabela2 (id INT PRIMARY KEY, tabela1_id INT, FOREIGN KEY (tabela1_id) REFERENCES tabela1(id));`</td></tr><tr><td>Unique</td><td>Garante que um campo tenha um valor único em toda a tabela.</td><td>`CREATE TABLE tabela_exemplo (id INT UNIQUE, nome VARCHAR(50));`</td></tr><tr><td>Not Null</td><td>Define que um campo não pode ser deixado em branco e deve ter um valor atribuído.</td><td>`CREATE TABLE tabela_exemplo (id INT NOT NULL, nome VARCHAR(50) NOT NULL);`</td></tr><tr><td>Check</td><td>Permite definir uma condição para os valores aceitos em uma coluna.</td><td>`CREATE TABLE tabela_exemplo (id INT CHECK (id &gt; 0), nome VARCHAR(50) CHECK (LEN(nome) &gt; 2));`</td></tr><tr><td>Default</td><td>Define um valor padrão para um campo caso nenhum valor seja fornecido.</td><td>`CREATE TABLE tabela_exemplo (id INT DEFAULT 0, nome VARCHAR(50) DEFAULT &#39;Sem nome&#39;);`</td></tr><tr><td>Index</td><td>Melhora o desempenho de consultas ao criar uma estrutura de busca rápida.</td><td>`CREATE TABLE tabela_exemplo (id INT, nome VARCHAR(50), INDEX (nome));`</td></tr></tbody></table>
